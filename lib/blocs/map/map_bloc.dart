import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/blocs/map/map_states.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:carshop_mobile/utilities/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(LocationLoading()) {
    on<FetchPostsEvent>(_mapFetchPostsEventToState);
    on<GetCurrentLocationEvent>(_getCurrentLocationEventToState);
  }

  FutureOr<void> _mapFetchPostsEventToState(
      FetchPostsEvent event, Emitter<MapState> emit) async {
    var client = CarshopSDK().client;

    var deliveryPosts = await client.deliveryPostsGet(
        locationLat: event.location.lat,
        locationLng: event.location.lng,
        radiusMeter: 5000);
    if (deliveryPosts.body != null) {
      if (deliveryPosts.body!.isEmpty) {
        emit(NotPostsFound(
            currentLocation: state.currentLocation!,
            posts: [],
            markers: state.markers!,
            deliveryPosts: []));
      } else {
        emit(DataReady(
            posts: [],
            deliveryPosts: deliveryPosts.body!,
            currentLocation: state.currentLocation!,
            markers: state.markers!));
      }
    } else {
      emit(CurrLocationUpdated(
          currentLocation: state.currentLocation!, markers: state.markers!));
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
      emit(
          CurrLocationUpdated(currentLocation: coordination, markers: markers));
      if (event.after != null) {
        event.after!(coordination);
      }
    } else if (state.posts == null) {
      emit(
          CurrLocationUpdated(currentLocation: coordination, markers: markers));
    } else {
      emit(DataReady(
          currentLocation: coordination,
          posts: state.posts!,
          markers: markers,
          deliveryPosts: state.deliveryPosts!));
    }
  }
}
