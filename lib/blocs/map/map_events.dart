import 'package:carshop_clientsdk/carshop_clientsdk.dart';

class MapEvent {}

class FetchPostsEvent extends MapEvent {
  Coordination location;
  FetchPostsEvent({required this.location});
}

class GetCurrentLocationEvent extends MapEvent {}

class GetMapFeedEvent extends MapEvent {}
