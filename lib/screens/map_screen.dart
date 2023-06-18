
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});


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
    dynamic position;
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
    await mapboxMap?.style.addLayer(
      HeatmapLayer(
        heatmapRadius: 5.0,
        heatmapWeight: 3.0,
        minZoom: 0.0,
        maxZoom: 4.0,
        id: 'heatmap_layer',
        sourceId: 'heatmap',
        heatmapColor:  Colors.red.value,
        heatmapOpacity: 0.5,
      ),
    );
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
                  },
                  child: const Icon(Icons.swap_horiz)),
              const SizedBox(height: 10),
            ],
          ),
        ),
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