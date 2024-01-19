import 'package:carshop_clientsdk/carshop_clientsdk.dart';

enum MapMessage {
  idle,
  failedToGetLocation,
  loading,
  error,
  succeededToGetLocation,
  notFound,
  dataLoaded,
}

class MapState {
  final List<PublicNormalPostDescriptor>? posts;
  final List<PublicDeliveryPostDesc>? deliveryPosts;
  final Coordination? currentLocation;
  final String mapboxUrl;
  final MapMessage? mapMessage;
  final bool lockMapTap;

  copyWith({
    Coordination? currentLocation,
    List<PublicNormalPostDescriptor>? posts,
    List<PublicDeliveryPostDesc>? deliveryPosts,
    String? mapboxUrl,
    MapMessage? mapMessage,
    bool? lockMapTap,
  }) {
    return MapState(
      currentLocation: currentLocation ?? this.currentLocation,
      posts: posts ?? this.posts,
      deliveryPosts: deliveryPosts ?? this.deliveryPosts,
      mapboxUrl: mapboxUrl ?? this.mapboxUrl,
      mapMessage: mapMessage ?? MapMessage.idle,
      lockMapTap: lockMapTap ?? false,
    );
  }

  MapState(
      {required this.currentLocation,
      required this.posts,
      required this.deliveryPosts,
      required this.mapboxUrl,
      required this.mapMessage,
      required this.lockMapTap});
}
