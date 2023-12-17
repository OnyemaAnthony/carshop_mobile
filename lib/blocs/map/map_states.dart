import 'package:carshop_clientsdk/carshop_clientsdk.dart';

class MapState {
  final List<PublicNormalPostDescriptor>? posts;
  final List<PublicDeliveryPostDesc>? deliveryPosts;
  final Coordination? currentLocation;

  copyWith({
    Coordination? currentLocation,
    List<PublicNormalPostDescriptor>? posts,
    List<PublicDeliveryPostDesc>? deliveryPosts,
  }) {
    return MapState(
      currentLocation: currentLocation ?? this.currentLocation,
      posts: posts ?? this.posts,
      deliveryPosts: deliveryPosts ?? this.deliveryPosts,
    );
  }

  MapState({this.currentLocation, this.posts, this.deliveryPosts});
}

class DataReady extends MapState {
  DataReady({
    required Coordination currentLocation,
    required List<PublicNormalPostDescriptor> posts,
    required List<PublicDeliveryPostDesc> deliveryPosts,
  }) : super(
            currentLocation: currentLocation,
            posts: posts,
            deliveryPosts: deliveryPosts);
}

class LocationLoading extends MapState {}

class NotPostsFound extends MapState {
  NotPostsFound(
      {required super.currentLocation,
      required super.posts,
      required super.deliveryPosts});
}

class GetUserLocationSuccess extends MapState {
  GetUserLocationSuccess(
      {super.currentLocation, super.posts, super.deliveryPosts});
}

class GetUserLocationError extends MapState {
  GetUserLocationError(
      {super.currentLocation, super.posts, super.deliveryPosts});
}

class GetMapFeedSuccess extends MapState {
  GetMapFeedSuccess({super.currentLocation, super.posts, super.deliveryPosts});
}
