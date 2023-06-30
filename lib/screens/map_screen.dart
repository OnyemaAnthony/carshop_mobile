import 'dart:async';
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
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  double? latitude = 0;
  double? longitude = 0;
  final loger = Logger();

  getLocation()async{
    Services service = Services();
   Position position =  await service.getUserCoordinate();
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
    final CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(6.866825682560999, 7.411526295850305),
   // target: LatLng(latitude!, longitude!),
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
        onTap: (position){
          UiUtilities.showToast(message: 'codinates copied', toast: Toast.LENGTH_LONG);
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
            markers[MarkerId('place_name')] = marker;
          });
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

  Future<void> _moveCamera() async {
    final GoogleMapController controller = await _controller.future;

    await controller.moveCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }





  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  //
  // void _add() {
  //   var markerIdVal = MyWayToGenerateId();
  //   final MarkerId markerId = MarkerId(markerIdVal);
  //
  //   // creating a new MARKER
  //   final Marker marker = Marker(
  //     markerId: markerId,
  //     position: LatLng(
  //       center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
  //       center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
  //     ),
  //     infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
  //     onTap: () {
  //       _onMarkerTapped(markerId);
  //     },
  //   );
  //
  //   setState(() {
  //     // adding a new marker to map
  //     markers[markerId] = marker;
  //   });
  // }

}

