import 'dart:convert';
import 'dart:math';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
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

  static Future<void> createMarker(MapboxMap? mapboxMap, String markerImage,
      Position position) async {
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

  static Future<void> createHeatmap(
      MapboxMap? mapboxMap, List<Position> points, String heatmapId) async {
    if (points.length > 1) {
      await mapboxMap?.style.addSource(
          GeoJsonSource(id: heatmapId, data: _createGeoJson(points)));
      await mapboxMap?.style.addLayer(
          HeatmapLayer(id: '${heatmapId}_layer', sourceId: heatmapId));
    }
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

  static Future<Coordination> screenCoord2LatLng(
      MapboxMap mapboxMap, ScreenCoordinate screenCoordinate) async {
    var coordin = await mapboxMap.coordinateForPixel(screenCoordinate);
    List<dynamic> coordinates = (coordin["coordinates"] as List<dynamic>);
    return Coordination(lat: coordinates[1], lng: coordinates[0]);
  }
}
