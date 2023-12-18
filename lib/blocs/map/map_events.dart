import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapEvent {}

class FetchPostsEvent extends MapEvent {
  ScreenCoordinate location;
  FetchPostsEvent({required this.location});
}

class GetCurrentLocationEvent extends MapEvent {}

class GetMapFeedEvent extends MapEvent {}
