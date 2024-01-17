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
  mapbox.MapboxMap? mapboxMap;

  MapBloc()
      : super(MapState(
            lockMapTap: false,
            mapMessage: MapMessage.loading,
            currentLocation: null,
            posts: [],
            deliveryPosts: [],
            mapboxUrl: "mapbox://styles/hka14/clr1fm2af01bf01qr8ksm8wpk")) {
    on<FetchPostsEvent>(_mapFetchPostsEventToState);
    on<GetCurrentLocationEvent>(_getCurrentLocationEventToState);
    on<GetMapFeedEvent>(_getMapFeedEventToState);
  }

  FutureOr<void> _mapFetchPostsEventToState(
      FetchPostsEvent event, Emitter<MapState> emit) async {
    if (state.lockMapTap) return;

    var client = CarshopSDK().client;
    emit(state.copyWith(lockMapTap: true));
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
        emit(state.copyWith(
            lockMapTap: false,
            mapMessage: MapMessage.notFound,
            posts: [],
            deliveryPosts: []));
      } else {
        emit(state.copyWith(
          lockMapTap: false,
          mapMessage: MapMessage.dataLoaded,
          posts: normalPostsList,
          deliveryPosts: deliveryPostsList,
        ));
      }
    }
  }

  void _getCurrentLocationEventToState(
      GetCurrentLocationEvent event, Emitter<MapState> emit) async {
    try {
      location.Position? userLocation = await LocationService.getLocation();
      if (userLocation == null) {
        emit(state.copyWith(
          mapMessage: MapMessage.failedToGetLocation,
          currentLocation: null,
        ));
      } else {
        _showUserLocation(userLocation);
        emit(state.copyWith(
            mapMessage: MapMessage.succeededToGetLocation,
            currentLocation: Coordination(
                lat: userLocation.latitude, lng: userLocation.longitude)));
      }
    } catch (e) {
      emit(state.copyWith(
        mapMessage: MapMessage.failedToGetLocation,
        currentLocation: null,
      ));
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

  FutureOr<void> _getMapFeedEventToState(
      GetMapFeedEvent event, Emitter<MapState> emit) async {
    var client = CarshopSDK().client;

    /// delivery posts
    var mapFeedResponse = await client.deliveryPostsMapFeedGet(
        lat: state.currentLocation?.lat,
        lng: state.currentLocation?.lng /*lat: 34.689039, lng: 33.018344*/);
    List<MapRoad>? mapFeedList = mapFeedResponse.body;
    _addRouteLines(mapFeedList ?? []);
  }
}
