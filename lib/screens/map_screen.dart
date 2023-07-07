import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
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

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<NormalPost> posts = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  double? latitude = 0;
  double? longitude = 0;
  final loger = Logger();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.4219983, -122.084),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onTap: (position) {
          UiUtilities.push(
              context,
              PostSwipeScreen(
                posts: posts,
              ));
          UiUtilities.showToast(
              message: 'coordinates copied', toast: Toast.LENGTH_LONG);
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
        onPressed: () {
          UiUtilities.push(context, CreateDeliveryPostScreen());
        },
        // onPressed: _goToTheLake,
        label: const Text('Go to my location'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    Position position = await Services().getUserCoordinate();
    final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(position.latitude, position.longitude),
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
