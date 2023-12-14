import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/blocs/map/map_states.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:carshop_mobile/utilities/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(LocationLoading()) {
    on<FetchPostsEvent>(_mapFetchPostsEventToState);
    on<GetCurrentLocationEvent>(_getCurrentLocationEventToState);
  }

  FutureOr<void> _mapFetchPostsEventToState(
      FetchPostsEvent event, Emitter<MapState> emit) async {
    var client = CarshopSDK().client;

    var deliveryPostsFuture = client.deliveryPostsGet(
        locationLat: event.location.lat,
        locationLng: event.location.lng,
        radiusMeter: 5000);

    var normalPostsFuture = client.normalPostsGet(
        locationLat: event.location.lat,
        locationLng: event.location.lng,
        radiusMeter: 100000);

    var responses = await Future.wait([deliveryPostsFuture, normalPostsFuture]);
    var deliveryPosts = responses[0] as Response<List<PublicDeliveryPostDesc>>;
    var normalPosts = responses[1] as Response<PublicNormalPostsDesc>;

    if (deliveryPosts.body != null && normalPosts.body != null) {
      if (deliveryPosts.body!.isEmpty &&
          normalPosts.body!.normalPosts.isEmpty) {
        emit(NotPostsFound(
            currentLocation:
                state.currentLocation ?? const Coordination(lat: 0, lng: 0),
            posts: [],
            deliveryPosts: []));
      } else {
        emit(DataReady(
          posts: normalPosts.body!.normalPosts,
          deliveryPosts: deliveryPosts.body!,
          currentLocation:
              state.currentLocation ?? const Coordination(lat: 0, lng: 0),
        ));
      }
    } else {
      emit(CurrLocationUpdated(currentLocation: state.currentLocation!));
    }
  }

  FutureOr<void> _getCurrentLocationEventToState(
      GetCurrentLocationEvent event, Emitter<MapState> emit) async {
    Position position = await Services().getUserCoordinate();
    var coordination =
        Coordination(lat: position.latitude, lng: position.longitude);
    var latlng = LatLng(coordination.lat, coordination.lng);

    final marker = Marker(
      markerId: const MarkerId('place_name'),
      position: latlng,
      infoWindow: const InfoWindow(
        title: 'This is your current location',
        snippet: 'address',
      ),
    );

    Map<MarkerId, Marker>? markers = {};
    markers[const MarkerId('place_name')] = marker;

    if (state is LocationLoading) {
      emit(CurrLocationUpdated(currentLocation: coordination));
      if (event.after != null) {
        event.after!(coordination);
      }
    } else if (state.posts == null) {
      emit(CurrLocationUpdated(currentLocation: coordination));
    } else {
      emit(DataReady(
          currentLocation: coordination,
          posts: state.posts!,
          deliveryPosts: state.deliveryPosts!));
    }
  }
}
