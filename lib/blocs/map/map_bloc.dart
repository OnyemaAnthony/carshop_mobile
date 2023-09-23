import 'dart:async';
import 'package:logger/logger.dart';
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
    var posts = await client.normalPostsGet(
        body: GetManyPostsDto(location: event.location));

    if (posts.body != null) {
      if (posts.body!.isEmpty) {
        emit(NotPostsFound(
            currentLocation: state.currentLocation!,
            posts: [],
            markers: state.markers!));
      } else {
        emit(PostsReady(
            posts: posts.body!,
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
    var coor = Coordination(lat: position.latitude, lng: position.longitude);
    var latlng = LatLng(coor.lat, coor.lng);

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
      emit(CurrLocationUpdated(currentLocation: coor, markers: markers));
      if (event.after != null) {
        event.after!(coor);
      }
    } else if (state.posts == null) {
      emit(CurrLocationUpdated(currentLocation: coor, markers: markers));
    } else {
      emit(PostsReady(
          currentLocation: coor, posts: state.posts!, markers: markers));
    }
  }
}
