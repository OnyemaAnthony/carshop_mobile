import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/blocs/map/map_states.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:carshop_mobile/repositories/map_repository.dart';
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/location_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as location;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:turf/turf.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(LocationLoading()) {
    on<FetchPostsEvent>(_mapFetchPostsEventToState);
    on<GetCurrentLocationEvent>(_getCurrentLocationEventToState);
    on<GetMapFeedEvent>(_getMapFeedEventToState);
  }

  FutureOr<void> _mapFetchPostsEventToState(
      FetchPostsEvent event, Emitter<MapState> emit) async {
    var client = CarshopSDK().client;

    double deliveryRadius = 50000;
    var radius = await MapRepository.tapRadiusinMeter(mapboxMap!);
    List<Future<dynamic>> futures = [];

    if (state.currentLocation != null) {
      Coordination currentLocation = state.currentLocation!;

      var deliveryPostsFuture = client.deliveryPostsGet(
          locationLat: currentLocation.lat,
          locationLng: currentLocation.lng,
          radiusMeter: deliveryRadius);
      futures.add(deliveryPostsFuture);
    }

    var normalPostsFuture = client.normalPostsGet(
        locationLat: event.location.x,
        locationLng: event.location.y,
        radiusMeter: radius);

    futures.add(normalPostsFuture);
    var responses = await Future.wait(futures);

    Response<List<PublicDeliveryPostDesc>>? deliveryPosts;
    Response<PublicNormalPostsDesc>? normalPosts;

    if (futures.length == 1) {
      normalPosts = responses[0] as Response<PublicNormalPostsDesc>;
    } else if (futures.length == 2) {
      deliveryPosts = responses[0] as Response<List<PublicDeliveryPostDesc>>;
      normalPosts = responses[1] as Response<PublicNormalPostsDesc>;
    }

    if (deliveryPosts?.body != null && normalPosts?.body != null) {
      List<PublicDeliveryPostDesc> deliveryPostsList = deliveryPosts!.body!;
      List<PublicNormalPostDescriptor> normalPostsList =
          normalPosts!.body!.normalPosts;

      if (deliveryPostsList.isEmpty && normalPostsList.isEmpty) {
        emit(NotPostsFound(
            currentLocation:
                state.currentLocation ?? const Coordination(lat: 0, lng: 0),
            posts: [],
            deliveryPosts: []));
      } else {
        emit(DataReady(
          posts: normalPostsList,
          deliveryPosts: deliveryPostsList,
          currentLocation: state.currentLocation,
        ));
      }
    }
  }

  mapbox.MapboxMap? mapboxMap;
  void _getCurrentLocationEventToState(
      GetCurrentLocationEvent event, Emitter<MapState> emit) async {
    try {
      location.Position? userLocation = await LocationService.getLocation();
      if (userLocation == null) {
        emit(GetUserLocationError());
      } else {
        _showUserLocation(userLocation);
        emit(GetUserLocationSuccess(
            currentLocation: Coordination(
                lat: userLocation.latitude, lng: userLocation.longitude)));
      }
    } catch (e) {
      emit(GetUserLocationError());
    }
  }

  Future<void> _showUserLocation(location.Position userLocation) async {
    await MapRepository.moveToSpecificLocation(mapboxMap, userLocation);
    await MapRepository.createMarker(mapboxMap, 'marker.png',
        Position(userLocation.longitude, userLocation.latitude));
  }

  Future<void> _addRouteLines(List<MapRoad> mapFeed) async {
    for (var element in mapFeed) {
      var points = await MapRepository.fetchRouteCoordinates(
          mapbox.Position(element.start.lng, element.start.lat),
          mapbox.Position(element.end.lng, element.end.lat),
          ApiKeys.mapBoxAccessToken);
      await MapRepository.createRouteLine(mapboxMap, points);
      await MapRepository.createMarker(
          mapboxMap, 'start_marker.png', points.first);
      await MapRepository.createMarker(
          mapboxMap, 'end_marker.png', points.last);
    }
  }

  Future<void> _showHeatmap(
      List<mapbox.Position> heatmapList, String heatmapId) async {
    await MapRepository.createHeatmap(mapboxMap, heatmapList, heatmapId);
  }

  FutureOr<void> _getMapFeedEventToState(
      GetMapFeedEvent event, Emitter<MapState> emit) async {
    var client = CarshopSDK().client;

    /// normal posts
    var normalPostsResponse = await client.normalPostsMapFeedGet();
    List<MapPosition>? normalPostsFeedList = normalPostsResponse.body;
    List<mapbox.Position> normalPostsHeatMap = [];
    normalPostsFeedList?.forEach((element) {
      normalPostsHeatMap.add(mapbox.Position(element.lng, element.lat));
    });
    _showHeatmap(normalPostsHeatMap, 'normalPostsHeatMap');

    /// delivery posts
    var mapFeedResponse = await client.deliveryPostsMapFeedGet(
        lat: state.currentLocation?.lat,
        lng: state.currentLocation?.lng /*lat: 34.689039, lng: 33.018344*/);
    List<MapRoad>? mapFeedList = mapFeedResponse.body;
    _addRouteLines(mapFeedList ?? []);
    emit(GetMapFeedSuccess(
        currentLocation: state.currentLocation,
        posts: state.posts,
        deliveryPosts: state.deliveryPosts));
  }
}
