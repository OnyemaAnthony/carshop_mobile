import 'package:carshop_clientsdk/carshop_clientsdk.dart';

class MapState {
  final List<PublicNormalPostDescriptor>? posts;
  final List<PublicDeliveryPostDesc>? deliveryPosts;
  final Coordination? currentLocation;
  final String mapboxUrl;

  copyWith({
    Coordination? currentLocation,
    List<PublicNormalPostDescriptor>? posts,
    List<PublicDeliveryPostDesc>? deliveryPosts,
    String? mapboxUrl,
  }) {
    return MapState(
      currentLocation: currentLocation ?? this.currentLocation,
      posts: posts ?? this.posts,
      deliveryPosts: deliveryPosts ?? this.deliveryPosts,
      mapboxUrl: mapboxUrl ?? this.mapboxUrl,
    );
  }

  MapState(
      {this.currentLocation,
      this.posts,
      this.deliveryPosts,
      required this.mapboxUrl});
}

class DataReady extends MapState {
  DataReady({
    required super.currentLocation,
    required super.posts,
    required super.deliveryPosts,
    required super.mapboxUrl,
  });
}

class LocationLoading extends MapState {
  LocationLoading({required String mapboxUrl}) : super(mapboxUrl: mapboxUrl);
}

class NotPostsFound extends MapState {
  NotPostsFound(
      {required super.currentLocation,
      required super.posts,
      required super.deliveryPosts,
      required super.mapboxUrl});
}

class GetUserLocationSuccess extends MapState {
  GetUserLocationSuccess(
      {super.currentLocation,
      super.posts,
      super.deliveryPosts,
      required super.mapboxUrl});
}

class GetUserLocationError extends MapState {
  GetUserLocationError(
      {super.currentLocation,
      super.posts,
      super.deliveryPosts,
      required super.mapboxUrl});
}

class GetMapFeedSuccess extends MapState {
  GetMapFeedSuccess(
      {super.currentLocation,
      super.posts,
      super.deliveryPosts,
      required super.mapboxUrl});
}
