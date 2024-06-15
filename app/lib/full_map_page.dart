import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapLibreMapController? mapController;

  @override
  Widget build(BuildContext context) {
    const styleUrl =
        'https://raw.githubusercontent.com/go2garret/maps/main/src/assets/json/openStreetMap.json';

    return Scaffold(
        body: MapLibreMap(
      myLocationEnabled: true,
      myLocationTrackingMode: MyLocationTrackingMode.trackingCompass,
      myLocationRenderMode: MyLocationRenderMode.compass,
      styleString: styleUrl,
      initialCameraPosition: const CameraPosition(bearing: 0.0, target: LatLng(51.8, 9.7), tilt: 0.0, zoom: 5.5),
      trackCameraPosition: true,
      onMapCreated: (controller) {
            /*controller.addListener(() {
              print(controller.cameraPosition);
            });*/
            controller.requestMyLocationLatLng().then((value)
              => value != null ? controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: value, zoom: 17.0))) : null);
          },
    ));
  }
}
