import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final List<NormalPost>? posts;
  final Coordination? currentLocation;
  final Map<MarkerId, Marker>? markers;

  MapState(
      {required this.currentLocation,
      required this.posts,
      required this.markers});
}

class PostsReady extends MapState {
  PostsReady(
      {required Coordination currentLocation,
      required List<NormalPost> posts,
      required Map<MarkerId, Marker> markers})
      : super(currentLocation: currentLocation, posts: posts, markers: markers);
}

class CurrLocationUpdated extends MapState {
  CurrLocationUpdated(
      {required Coordination currentLocation,
      required Map<MarkerId, Marker> markers})
      : super(currentLocation: currentLocation, markers: markers, posts: null);
}

class LocationLoading extends MapState {
  LocationLoading() : super(currentLocation: null, posts: null, markers: null);
}
