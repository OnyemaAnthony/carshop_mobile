import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/blocs/map/map_states.dart';
import 'package:carshop_mobile/screens/post_swipe_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  GoogleMapController? _controller;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.4219983, -122.084),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    MapBloc bloc = context.read<MapBloc>();
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state is LocationLoading) {
          bloc.add(GetCurrentLocationEvent(after: _goToLocation));
        }
        if (state is PostsReady) {
          UiUtilities.push(
              context,
              PostSwipeScreen(
                posts: state.posts!,
              ));
          UiUtilities.showToast(
              message: 'coordinates copied', toast: Toast.LENGTH_LONG);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LocationLoading:
          case CurrLocationUpdated:
            return Scaffold(
              body: GoogleMap(
                onTap: (position) {
                  bloc.add(FetchPostsEvent(
                      location: Coordination(
                          lat: position.latitude, lng: position.longitude)));
                },
                mapToolbarEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  print(state.runtimeType);
                  _goToLocation(state.currentLocation!);
                },
                // onPressed: _goToTheLake,
                label: const Text('Go to my location'),
                icon: const Icon(Icons.add),
              ),
            );
          case PostsReady:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return const Center(
              child: Text('Something went wrong'),
            );
        }
      },
    );
  }

  Future<void> _goToLocation(Coordination location) async {
    final CameraPosition camerPos = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(location.lat, location.lng),
        tilt: 59.440717697143555,
        zoom: 14);

    _controller!.animateCamera(CameraUpdate.newCameraPosition(camerPos));
  }
}
