import 'dart:async';
import 'package:carshop_mobile/utilities/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  getLocation()async{
    Services service = Services();
   Position position =  await service.getUserCoordinate();
   print('the lat is ${position.latitude} long is ${position.longitude}');
  }
  @override
  void initState() {

    super.initState();
    getLocation();
  }
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
    final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(6.866825682560999, 7.411526295850305),
    zoom: 10,
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
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label:  Text('To the lake!'),
        icon: Icon(Icons.add),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

