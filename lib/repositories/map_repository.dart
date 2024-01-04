import 'dart:convert';
import 'dart:math';
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:turf/distance.dart';
import 'package:turf/polyline.dart';
import 'package:geolocator/geolocator.dart' as location;

class MapRepository {
  static Future<void> moveToSpecificLocation(
      MapboxMap? mapboxMap, location.Position location) async {
    await mapboxMap!.flyTo(
      CameraOptions(
        center: Point(
          coordinates: Position(
              /*64.502971113, 67.828697712,*/ location.longitude,
              location.latitude),
        ).toJson(),
        zoom: 14.0,
      ),
      MapAnimationOptions(
        duration: 1000,
        startDelay: 0,
      ),
    );
  }

  static Future<void> createMarker(
      MapboxMap? mapboxMap, String markerImage, Position position) async {
    PointAnnotationManager? pointAnnotationManager =
        await mapboxMap?.annotations.createPointAnnotationManager();
    final ByteData bytes = await rootBundle.load('assets/images/$markerImage');
    final Uint8List list = bytes.buffer.asUint8List();
    var options = PointAnnotationOptions(
      geometry: Point(
        coordinates: position,
      ).toJson(),
      iconSize: .15,
      image: list,
    );
    pointAnnotationManager?.create(options);
  }

  static Future<void> createRouteLine(
      MapboxMap? mapboxMap, List<Position> points) async {
    PolylineAnnotationManager? polylineAnnotationManager =
        await mapboxMap?.annotations.createPolylineAnnotationManager();
    var options = PolylineAnnotationOptions(
      geometry: LineString(
        coordinates: points,
      ).toJson(),
      lineColor: _createRandomColor(),
      lineWidth: 5,
    );
    polylineAnnotationManager?.create(options);
  }

  static Future<List<Position>> fetchRouteCoordinates(
      Position start, Position end, String accessToken) async {
    final response = await _fetchDirectionRoute(start, end);
    return Polyline.decode(response.data['routes'][0]['geometry']);
  }

  static Future<dio.Response> _fetchDirectionRoute(
      Position start, Position end) async {
    final uri =
        "https://api.mapbox.com/directions/v5/mapbox/driving/${start.lng},${start.lat};${end.lng},${end.lat}?overview=full&access_token=${ApiKeys.mapBoxAccessToken}";
    return dio.Dio().get(uri);
  }

  static int _createRandomColor() {
    var random = Random();
    return Color.fromARGB(
            255, random.nextInt(255), random.nextInt(255), random.nextInt(255))
        .value;
  }

  static String _createGeoJson(List<Position> points) {
    Map map = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": LineString(coordinates: points).toJson()
        }
      ]
    };
    return json.encode(map);
  }

  static Future<num> tapRadiusinMeter(MapboxMap mapboxMap) async {
    var cameraState = await mapboxMap.getCameraState();

    var coordin = await mapboxMap.coordinateBoundsForCamera(CameraOptions(
        center: cameraState.center,
        zoom: cameraState.zoom,
        bearing: cameraState.bearing,
        pitch: cameraState.pitch));

    var northeast = coordin.northeast["coordinates"] as List<dynamic>;
    var southwest = coordin.southwest["coordinates"] as List<dynamic>;
    var northeastPos = Position.named(lat: northeast[1], lng: northeast[0]);
    var southwestPos = Position.named(lat: southwest[1], lng: southwest[0]);

    return distanceRaw(northeastPos, southwestPos, Unit.meters) / 4;
  }
}
