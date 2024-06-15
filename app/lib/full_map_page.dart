import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'dart:math';

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

void cameraListener(controller) {
    LatLng oldCameraPose = LatLng(0.0, 0.0);
    controller!.addListener(() {
      if (controller!.cameraPosition != null){
      if (pythLatLong(oldCameraPose, controller!.cameraPosition!.target) > 0.1 && controller!.cameraPosition!.zoom > 12.0){
        oldCameraPose = controller!.cameraPosition!.target;
        print('Camera moved to pose ${controller!.cameraPosition!.target}');
      }}
    });
}

  @override
  Widget build(BuildContext context) {
    const styleUrl =
        'https://raw.githubusercontent.com/go2garret/maps/main/src/assets/json/openStreetMap.json';

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
        cameraListener(controller);
            controller.requestMyLocationLatLng().then((value)
              => value != null ? controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: value, zoom: 17.0))) : null);
          },
    ));
  }
}
