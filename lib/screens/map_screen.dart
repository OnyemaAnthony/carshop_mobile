import 'dart:async';
import 'package:carshop_mobile/screens/create_delivery_post_screen.dart';
import 'package:carshop_mobile/screens/create_post_screen.dart';
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
    PostModel(title: "title", content: "content",location: PostLocation( lat: 10, lng: 5)),
    PostModel(title: "best post", content: "helooooooooo",location: PostLocation( lat: 10, lng: 5)),
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
        content: "longest text ever bla bla bla",location: PostLocation( lat: 10,
        lng: 5)),
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
        content: "trenddddddddddddy lets go",location: PostLocation(lat: 10,
  lng: 5)),
    PostModel(title: "boring again", content: "oh crap", location: PostLocation(lat: 10, lng: 5)),
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

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
    final CameraPosition _kGooglePlex =  const CameraPosition(
    target: LatLng(37.4219983, -122.084), zoom: 14,
  );



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(
        onTap: (position){
          UiUtilities.push(context, PostSwipeScreen(posts: posts,));
          UiUtilities.showToast(message: 'coordinates copied', toast: Toast.LENGTH_LONG);
        },
        mapToolbarEnabled: true,
        markers: markers.values.toSet(),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          UiUtilities.push(context, CreateDeliveryPostScreen());
        },
       // onPressed: _goToTheLake,
        label:  const Text('Go to my location'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    Position position =await Services().getUserCoordinate();
     final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(position.latitude,position.longitude),
        tilt: 59.440717697143555,
        zoom: 14);
    final marker = Marker(
      markerId: const MarkerId('place_name'),
      position: LatLng(latitude!, longitude!),
      infoWindow: const InfoWindow(
        title: 'This is your current location',
        snippet: 'address',
      ),
    );

    setState(() {
      markers[const MarkerId('place_name')] = marker;
    });
    final GoogleMapController controller = await _controller.future;

    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }



}

