import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final List<NormalPost>? posts;
  final List<PublicDeliveryPostDesc>? deliveryPosts;

  final Coordination? currentLocation;
  final Map<MarkerId, Marker>? markers;

  MapState(
      {required this.currentLocation,
      required this.posts,
      required this.markers,
      required this.deliveryPosts});
}

class DataReady extends MapState {
  DataReady(
      {required Coordination currentLocation,
      required List<NormalPost> posts,
      required List<PublicDeliveryPostDesc> deliveryPosts,
      required Map<MarkerId, Marker> markers})
      : super(
            currentLocation: currentLocation,
            posts: posts,
            markers: markers,
            deliveryPosts: deliveryPosts);
}

class CurrLocationUpdated extends MapState {
  CurrLocationUpdated(
      {required Coordination currentLocation,
      required Map<MarkerId, Marker> markers})
      : super(
            currentLocation: currentLocation,
            markers: markers,
            posts: null,
            deliveryPosts: null);
}

class LocationLoading extends MapState {
  LocationLoading()
      : super(
            currentLocation: null,
            posts: null,
            markers: null,
            deliveryPosts: null);
}

class NotPostsFound extends MapState {
  NotPostsFound(
      {required super.currentLocation,
      required super.posts,
      required super.markers,
      required super.deliveryPosts});
}
