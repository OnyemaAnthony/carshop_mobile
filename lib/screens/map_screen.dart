import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart'as geo;

class MapScreen extends StatefulWidget {

  @override
  State createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {

   num? latitude=6.865317876737976;
   num? longitude=7.416827398513871;
  @override
  void initState() {
    getLocation();
    super.initState();
  }
  void getLocation()async{
    geo.Position position =  await UiUtilities.determinePosition();
   setState(() {
     latitude = position.latitude;
     longitude = position.longitude;
     print('lat$latitude long $longitude');
   });
   print('lat $latitude');
  }

  MapboxMap? mapboxMap;
  var isLight = true;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.subscribe(_eventObserver, [
      MapEvents.STYLE_LOADED,
      MapEvents.MAP_LOADED,
      MapEvents.MAP_IDLE,
    ]);
  }

  _eventObserver(Event event) {
    print("Receive event, type: ${event.type}, data: ${event.data}");
  }




  CameraOptions camera = CameraOptions(
      center: Point(
          coordinates: Position(
            7.416827398513871,
            6.865317876737976,
          )).toJson(),
      zoom: 13.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    setState(
                          () => isLight = !isLight,
                    );
                    if (isLight) {
                      mapboxMap?.loadStyleURI(MapboxStyles.LIGHT);
                    } else {
                      mapboxMap?.loadStyleURI(MapboxStyles.DARK);
                    }
                  },
                  child: const Icon(Icons.swap_horiz)),
              const SizedBox(height: 10),
            ],
          ),
        ),
        // coordinates: Position(
        //   6.0033416748046875,
        //   43.70908256335716,
        // )).toJson(),
        body: MapWidget(

          key: const ValueKey("mapWidget"),
          resourceOptions: ResourceOptions(accessToken: ApiKeys.accessToken),
          cameraOptions:camera,
          styleUri: MapboxStyles.LIGHT,
          textureView: true,
          onMapCreated: _onMapCreated,
        ));
  }

}