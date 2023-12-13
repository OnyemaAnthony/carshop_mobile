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

class CurrLocationUpdated extends MapState {
  CurrLocationUpdated({required Coordination currentLocation})
      : super(
            currentLocation: currentLocation, posts: null, deliveryPosts: null);
}

class LocationLoading extends MapState {
  LocationLoading()
      : super(currentLocation: null, posts: null, deliveryPosts: null);
}

class NotPostsFound extends MapState {
  NotPostsFound(
      {required super.currentLocation,
      required super.posts,
      required super.deliveryPosts});
}
