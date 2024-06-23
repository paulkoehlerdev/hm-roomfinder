import 'package:app/providers.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

import 'api/geodata.dart';
import 'api/json_extension.dart';
import 'manage_levels.dart';


class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapLibreMapController? mapController;

  ManageLevels manageLevels = ManageLevels();

  void cameraListener(controller, updateZoomLevelProvider, UpdateLevelProvider updateLevelProvider) {
    int oldTime = 0;
    double zoomThreshold = 15.0;
    int timeThresholdMs = 100;
    controller!.addListener(() {
      if (controller!.cameraPosition != null) {
        // to prevent the function from running too often
        if (DateTime.now().millisecondsSinceEpoch - oldTime > timeThresholdMs) {
          // if zooming in/ zoomed in
          if (controller!.cameraPosition!.zoom > zoomThreshold) {
            manageLevels.getIntersectingBuildings(controller!.cameraPosition!.target)
                .then((newLayersInScreen) => {
                      // if new layers are in the screen
                      if (newLayersInScreen['new']!)
                        {
                          updateZoomLevelProvider.updateZoomLevel(true),
                          manageLevels.paintLevel(0),
                          updateLevelProvider.setAvailableLevels(newLayersInScreen['availableLevels']!.toList()),
                        }
                      else if (!newLayersInScreen['total']!)
                        {
                          // if no layers are in the screen
                          levels.clear(),
                          loadedLevels.clear(),
                          manageLevels.delAllLevel(),
                          updateZoomLevelProvider.updateZoomLevel(false)
                        }
                    });
            // if zooming out
          } else {
            levels.clear();
            loadedLevels.clear();
            manageLevels.delAllLevel();
            updateZoomLevelProvider.updateZoomLevel(false);
          }
          oldTime = DateTime.now().millisecondsSinceEpoch;
        }
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    const styleUrl =
        'https://raw.githubusercontent.com/go2garret/maps/main/src/assets/json/openStreetMap.json';

    final ZoomLevelProvider updateZoomLevelProvider =
        Provider.of<ZoomLevelProvider>(context, listen: false);

    return Consumer<UpdateLevelProvider>(
        builder: (context, updateLevelProvider, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              mapController!.requestMyLocationLatLng().then((value) => value !=
                      null
                  ? mapController!.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(target: value, zoom: 17.0)))
                  : null);
            },
            child: const Icon(Icons.my_location),
          ),
          body: MapLibreMap(
            tiltGesturesEnabled: false,
            myLocationEnabled: true,
            //myLocationTrackingMode: MyLocationTrackingMode.trackingCompass,
            myLocationRenderMode: MyLocationRenderMode.compass,
            styleString: styleUrl,
            initialCameraPosition: const CameraPosition(
                bearing: 0.0, target: LatLng(51.8, 9.7), tilt: 0.0, zoom: 5.5),
            trackCameraPosition: true,
            onMapCreated: (controller) {
              mapController = controller;
              manageLevels.setMapController(controller);
              cameraListener(controller, updateZoomLevelProvider, updateLevelProvider);
              controller.requestMyLocationLatLng().then((value) => value != null
                  ? controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(target: value, zoom: 17.0)))
                  : null);
              manageLevels.loadBuildingLayer();
              manageLevels.autoPaint(updateLevelProvider);
            },
          ));
    });
  }
}
