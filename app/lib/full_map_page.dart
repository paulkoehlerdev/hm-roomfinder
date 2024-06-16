import 'package:app/providers.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'dart:math';
import 'package:provider/provider.dart';

Map<String,dynamic> geojson = {
"type": "FeatureCollection",
"name": "example_geojson",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [
{ "type": "Feature", "properties": { "pk": 1, "name": "F0.02", "storey_id": 1 }, "geometry": { "type": "Polygon", "coordinates": [ [ [ 11.568194183434708, 48.142868235160421 ], [ 11.568301598509459, 48.142837212756163 ], [ 11.568232379769954, 48.142731154911601 ], [ 11.568124770805175, 48.142762565095914 ], [ 11.568194183434708, 48.142868235160421 ] ] ] } },
{ "type": "Feature", "properties": { "pk": 2, "name": "F0.01a", "storey_id": 1 }, "geometry": { "type": "Polygon", "coordinates": [ [ [ 11.568193989544682, 48.142868429050452 ], [ 11.568301210729405, 48.142837406646187 ], [ 11.568320793622096, 48.142869204610555 ], [ 11.568290934557995, 48.142877541881703 ], [ 11.568292485678208, 48.142881419682233 ], [ 11.568216868567823, 48.142902941475192 ], [ 11.568193989544682, 48.142868429050452 ] ] ] } },
]
};

final geojsonSource = GeojsonSourceProperties(
  data: geojson,
);

const fillLayer = FillLayerProperties(
  fillColor: '#ff0000',
  fillOpacity: 0.5,
  fillOutlineColor: '#000000',
);

class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapLibreMapController? mapController;

double pythLatLong(pose1, pose2) {
  return sqrt(pow(pose1.latitude - pose2.latitude, 2) + pow(pose1.longitude - pose2.longitude, 2));
}

void cameraListener(controller, updateZoomLevelProvider) {
    LatLng oldCameraPose = LatLng(0.0, 0.0);
    double oldZoom = 0.0;
    double zoomThreshold = 14.0;
    controller!.addListener(() {
      if (controller!.cameraPosition != null){
      if (pythLatLong(oldCameraPose, controller!.cameraPosition!.target) > 0.1 && controller!.cameraPosition!.zoom > 14.0){
        oldCameraPose = controller!.cameraPosition!.target;
        print('Camera moved to pose ${controller!.cameraPosition!.target}');
        loadRooms(controller!.cameraPosition!.target); 
      }}
      if (oldZoom > zoomThreshold && controller!.cameraPosition!.zoom < zoomThreshold 
        || oldZoom < zoomThreshold && controller!.cameraPosition!.zoom > zoomThreshold){
        oldZoom = controller!.cameraPosition!.zoom;
        updateZoomLevelProvider.updateZoomLevel(controller!.cameraPosition!.zoom > zoomThreshold);
        print('Zoom changed to ${controller!.cameraPosition!.zoom}');
      }
    });
}

void loadRooms(LatLng cameraPosition){
  //example geojson location
  LatLng geojsonLoc = const LatLng(48.142868235160421, 11.568194183434708);
  if (pythLatLong(cameraPosition, geojsonLoc) < 0.1){
    //adding the example geojson
    mapController!.addSource('example_geojson', geojsonSource);
    mapController!.addFillLayer('example_geojson', 'example_geojson', fillLayer);
  }
}

  @override
  Widget build(BuildContext context) {
    const styleUrl =
        'https://raw.githubusercontent.com/go2garret/maps/main/src/assets/json/openStreetMap.json';

    final ZoomLevelProvider updateZoomLevelProvider =
        Provider.of<ZoomLevelProvider>(context, listen: false);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            mapController!.requestMyLocationLatLng().then((value)
              => value != null ? mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: value, zoom: 17.0))) : null);
          },
          child: const Icon(Icons.my_location),
        ),
        body: MapLibreMap(
      myLocationEnabled: true,
      myLocationTrackingMode: MyLocationTrackingMode.trackingCompass,
      myLocationRenderMode: MyLocationRenderMode.compass,
      styleString: styleUrl,
      initialCameraPosition: const CameraPosition(bearing: 0.0, target: LatLng(51.8, 9.7), tilt: 0.0, zoom: 5.5),
      trackCameraPosition: true,
      onMapCreated: (controller) {
        mapController = controller;
        cameraListener(controller, updateZoomLevelProvider);
            controller.requestMyLocationLatLng().then((value)
              => value != null ? controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: value, zoom: 17.0))) : null); 
          },
    ));
  }
}
