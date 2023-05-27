
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  }

  MapboxMap? mapboxMap;
  var isLight = true;

  void loadHeatMap()async{
    var data = await rootBundle.loadString('assets/hitmap.geojson');
    await mapboxMap!.style.addSource(GeoJsonSource(id: "heatmap", data: data));

    // await mapboxMap!.style.addLayer(LineLayer(
    //     id: "line_layer",
    //     sourceId: "line",
    //     lineJoin: LineJoin.ROUND,
    //     lineCap: LineCap.ROUND,
    //     lineOpacity: 0.7,
    //     lineColor: Colors.red.value,
    //     lineWidth: 8.0));
    // final data = await rootBundle.loadString('assets/hitmap.geojson');
    // await mapboxMap?.style
    //     .addSource(GeoJsonSource(id: 'heatmap', data: data));
    //
    //
    await mapboxMap?.style.addLayer(
      HeatmapLayer(
        heatmapRadius: 5.0,
        heatmapWeight: 3.0,
        //heatmapIntensity: 3.0,
        minZoom: 0.0,
        maxZoom: 4.0,
        id: 'heatmap_layer',
        sourceId: 'heatmap',
        heatmapColor:  Colors.red.value,
        heatmapOpacity: 0.5,
      ),
    );
    //
    // await mapboxMap?.style.addLayer(
    //   LineLayer(
    //     lineWidth: 20,
    //     minZoom: 10.7,
    //     id: 'line_layer',
    //     sourceId: 'heatmap',
    //     lineColor: 0xffff0000,
    //   ),
    // );
  }

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
            37.832632,
            -122.489876

          )).toJson(),
      zoom: 2.0);

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
                    loadHeatMap();
                    // setState(
                    //       () => isLight = !isLight,
                    // );
                    // if (isLight) {
                    //   mapboxMap?.loadStyleURI(MapboxStyles.LIGHT);
                    // } else {
                    //   mapboxMap?.loadStyleURI(MapboxStyles.DARK);
                    // }
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

          onMapLoadErrorListener: (map){

          },
          onMapCreated: _onMapCreated,
        ));
  }

}