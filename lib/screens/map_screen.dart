import 'dart:async';
import 'package:carshop_mobile/screens/post_swipe_screen.dart';
import 'package:carshop_mobile/utilities/services.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/post/delivery_post.dart';
import '../models/post/post_model.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<PostModel> posts = [
    PostModel(title: "title", content: "content", lat: 10, long: 5),
    PostModel(title: "best post", content: "helooooooooo", lat: 10, long: 5),
    DeliveryPost(
        title: "Delivery Post",
        content: "Delivery Post Content",
        productName: "Food",
        reward: 20,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 1)),
        destination: Coordination(latitude: 5, longitude: 19)),
    PostModel(
        title: "boring post",
        content: "longest text ever bla bla bla",
        lat: 10,
        long: 5),
    DeliveryPost(
        title: "Delivery Post",
        content: "Delivery Post Content",
        productName: "Car",
        reward: 10,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 1)),
        destination: Coordination(latitude: 5, longitude: 19)),
    PostModel(
        title: "trend post",
        content: "trenddddddddddddy lets go",
        lat: 10,
        long: 5),
    PostModel(title: "boring again", content: "oh crap", lat: 10, long: 5),
    DeliveryPost(
        title: "Delivery Post",
        content: "Delivery Post Content",
        productName: "Tooth Brush",
        reward: 30,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 1)),
        destination: Coordination(latitude: 5, longitude: 19)),
  ];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  double? latitude = 0;
  double? longitude = 0;
  final loger = Logger();

  getLocation()async{
    Services service = Services();
   Position position =  await service.getUserCoordinate();
   print('latitude ${position.latitude}, longitude ${position.longitude}');
   setState(() {
     latitude = position.latitude;
     longitude = position.longitude;
   });
  }

  @override
  void initState() {

    super.initState();

    getLocation();
  }
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
    final CameraPosition _kGooglePlex =  const CameraPosition(
    target: LatLng(37.4219983, -122.084),
   // target: LatLng(latitude!, longitude!),
    zoom: 14,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(
        onTap: (position){
          UiUtilities.push(context, PostSwipeScreen(posts: posts,));
          UiUtilities.showToast(message: 'coordinates copied', toast: Toast.LENGTH_LONG);
          loger.d('the location ${position.longitude}   ${position.latitude}');

        },
        mapToolbarEnabled: true,
        markers: markers.values.toSet(),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          final marker = Marker(
            markerId: const MarkerId('place_name'),
            position: LatLng(latitude!, longitude!),
            // icon: BitmapDescriptor.,
            infoWindow: const InfoWindow(
              title: 'title',
              snippet: 'address',
            ),
          );

          setState(() {
            markers[const MarkerId('place_name')] = marker;
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label:  const Text('To the lake!'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;

    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }



}

