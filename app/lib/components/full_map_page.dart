import 'package:app/components/level_selector.dart';
import 'package:app/map/debouncer.dart';
import 'package:app/map/layer_manager.dart';
import 'package:app/providers/visible_geodata_provider.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';

import 'package:app/map/manage_buildings.dart';

import '../map/manage_levels.dart';
import '../map/manage_rooms.dart';

class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  late final ManageBuildings manageBuildings;
  late final ManageLevels manageLevels;
  late final ManageRooms manageRooms;

  static const _styleUrl =
      'https://raw.githubusercontent.com/go2garret/maps/main/src/assets/json/openStreetMap.json';

  // static const _initialCameraPosition = CameraPosition(
  //     bearing: 0.0, target: LatLng(51.8, 9.7), tilt: 0.0, zoom: 5.5);

  static const _initialCameraPosition = CameraPosition(bearing: -0.0, target: LatLng(48.14312046865786, 11.56879682080509), tilt: 0.0, zoom: 16.681204475015875);

  static const _cameraDebounceMs = 100;

  static const _levelZoomThreshold = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LevelSelector(),
            FloatingActionButton(
              onPressed: () {
                // TODO: implement my location button
              },
              child: const Icon(Icons.my_location),
            ),
          ],
        ),
        body: MapLibreMap(
          tiltGesturesEnabled: false,
          myLocationEnabled: true,
          //myLocationTrackingMode: MyLocationTrackingMode.trackingCompass,
          myLocationRenderMode: MyLocationRenderMode.compass,
          styleString: _styleUrl,
          initialCameraPosition: _initialCameraPosition,
          trackCameraPosition: true,
          onMapCreated: _onMapCreated,
        ));
  }

  _cameraUpdater(CameraPosition position, LatLngBounds bounds) {
    manageBuildings.updateCamera(bounds);

    final levelProvider =
        Provider.of<VisibleGeodataProvider>(context, listen: false);

    if (position.zoom < _levelZoomThreshold) {
      levelProvider.setCurrentLevel(null);
      return;
    }

    if (levelProvider.currentLevel == null) {
      levelProvider.setCurrentLevel("EG");
    }
  }

  _onMapCreated(MapLibreMapController controller) {
    final cameraDebouncer = Debouncer(milliseconds: _cameraDebounceMs);

    controller.addListener(() {
      if (controller.cameraPosition != null) {
        cameraDebouncer.debounce(() async {
          _cameraUpdater(controller.cameraPosition!, await controller.getVisibleRegion());
        });
      }
    });

    // zoom in on user's location
    controller.requestMyLocationLatLng().then((value) => value != null
        ? controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: value, zoom: 17.0)))
        : null);

    final layerManager = LayerManager(mapController: controller);
    manageBuildings = ManageBuildings(
        provider: Provider.of<VisibleGeodataProvider>(context, listen: false),
        manager: layerManager);
    manageLevels = ManageLevels(
        provider: Provider.of<VisibleGeodataProvider>(context, listen: false),
        manager: layerManager);
    manageRooms = ManageRooms(
        provider: Provider.of<VisibleGeodataProvider>(context, listen: false),
        manager: layerManager);
  }
}
