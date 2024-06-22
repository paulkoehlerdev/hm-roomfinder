import 'package:app/providers.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'dart:math';
import 'dart:convert';

import 'api/geodata.dart';
import 'api/json_extension.dart';

List<Map<String, dynamic>> buildings = [];
List<Map<String, dynamic>> levels = [];
List loadedLevels = [];

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
    return sqrt(pow(pose1.latitude - pose2.latitude, 2) +
        pow(pose1.longitude - pose2.longitude, 2));
  }

  void cameraListener(controller, updateZoomLevelProvider) {
    LatLng oldCameraPose = LatLng(0.0, 0.0);
    double oldZoom = 0.0;
    double zoomThreshold = 15.0;
    double locationThreshold = 0.00001;
    bool zoomChanged = false;
    bool locationChanged = false;
    controller!.addListener(() {
      if (controller!.cameraPosition != null) {
        zoomChanged = oldZoom > zoomThreshold &&
                controller!.cameraPosition!.zoom < zoomThreshold ||
            oldZoom < zoomThreshold &&
                controller!.cameraPosition!.zoom > zoomThreshold;
        locationChanged =
            pythLatLong(oldCameraPose, controller!.cameraPosition!.target) >
                locationThreshold;
        if (locationChanged || zoomChanged) {
          // if zooming in
          if (controller!.cameraPosition!.zoom > zoomThreshold) {
            oldCameraPose = controller!.cameraPosition!.target;
            getIntersectingBuildings(controller!.cameraPosition!.target).then((layersInScreenChanged) => {
              if (layersInScreenChanged) {
                updateZoomLevelProvider.updateZoomLevel(
                controller!.cameraPosition!.zoom > zoomThreshold),
                paintLevel(0)
              } else {
                levels.clear(),
                loadedLevels.clear(),
                delAllLevel(),
                updateZoomLevelProvider.updateZoomLevel(false)
              }
            });
            oldZoom = controller!.cameraPosition!.zoom;
            zoomChanged = false;
            locationChanged = false;
            // if zooming out
          } else {
            oldCameraPose = controller!.cameraPosition!.target;
            levels.clear();
            loadedLevels.clear();
            delAllLevel();
            oldZoom = controller!.cameraPosition!.zoom;
            updateZoomLevelProvider.updateZoomLevel(
                controller!.cameraPosition!.zoom > zoomThreshold);
            zoomChanged = false;
            locationChanged = false;
          }
        }
      }
    });
  }

  paintLevel(int level) async{
    print('level: $level painted');
    await delAllLevel();
    for (Map level in levels) {
      if (level['level'] == level) {
        addLayers(level['layer_id'], GeojsonSourceProperties(data: level['data']));
      }
    }
  }

  Future<void> loadLevel(id) async{
    var api = GeodataRepository(api: GeodataApiSdk());
    var res = await api.levelGet(id);

    Set availableLevels = {};
    if (res.data != null) {
      res.data!.features.forEach((element) {
        num levelId = element.properties['id']!.asNum;
        loadedLevels.add(id);
        levels.add({'level': levelId, 'building_id': id, 'layer_id': 'level_${id}_$levelId', 'data': element.toJson()});
        availableLevels.add(levelId.toString());
      });
      Provider.of<UpdateLevelProvider>(context, listen: false).setAvailableLevels(availableLevels.toList());
    }
  }

  bool isBuildingIntersect(LatLngBounds screenBounds, List buildingBounds) {
    LatLngBounds building = LatLngBounds(
        southwest: LatLng(buildingBounds[0][0][1], buildingBounds[0][0][0]),
        northeast: LatLng(buildingBounds[0][2][1], buildingBounds[0][2][0]));

    if (screenBounds.northeast.latitude > building.southwest.latitude &&
        screenBounds.southwest.latitude < building.southwest.latitude &&
        screenBounds.northeast.longitude > building.southwest.longitude &&
        screenBounds.southwest.longitude < building.southwest.longitude) {
      return true;
    }
    if (screenBounds.northeast.latitude > building.northeast.latitude &&
        screenBounds.southwest.latitude < building.northeast.latitude &&
        screenBounds.northeast.longitude > building.northeast.longitude &&
        screenBounds.southwest.longitude < building.northeast.longitude) {
      return true;
    }
    if (screenBounds.northeast.latitude > building.southwest.latitude &&
        screenBounds.southwest.latitude < building.southwest.latitude &&
        screenBounds.northeast.longitude > building.northeast.longitude &&
        screenBounds.southwest.longitude < building.northeast.longitude) {
      return true;
    }
    if (screenBounds.northeast.latitude > building.northeast.latitude &&
        screenBounds.southwest.latitude < building.northeast.latitude &&
        screenBounds.northeast.longitude > building.southwest.longitude &&
        screenBounds.southwest.longitude < building.southwest.longitude) {
      return true;
    }
    return false;
  }
  
  Future<bool> getIntersectingBuildings (LatLng cameraPosition) async {
    bool layersInScreenChanged = false;
    LatLngBounds visable =  await mapController!.getVisibleRegion();
    for (Map building in buildings) {
      if (!loadedLevels.contains(building['id'])){ // if the building is not already loaded
        if (isBuildingIntersect(visable, building['bounds'])) { // if the building is in the screen
            layersInScreenChanged = true;
            await loadLevel(building['id']);
        }
      }
    }
    return layersInScreenChanged;
  }

  void addLayers(String layerId, GeojsonSourceProperties geojsonSource){
    String sourceId = layerId;
    mapController!.getSourceIds().then((sourceIds) {
        if (!sourceIds.contains(sourceId)) {
          mapController!.addSource(sourceId, geojsonSource);
        }
      });
      mapController!.getLayerIds().then((layerIds) {
        if (!layerIds.contains(layerId)) {
          mapController!.addFillLayer(
              layerId, layerId, fillLayer);
        }
      });
  }

  Future<void> delAllLevel() async {
    mapController!.getLayerIds().then((layerIds) {
      //example geojson
      for (String layer in layerIds) {
        if (layer.length >= 4) {
          if (layer.substring(0, 5) == 'level') {
            mapController!.removeLayer(layer);
          }
        }
      }
    });
    mapController!.getSourceIds().then((sourceIds) {
      for (String source in sourceIds) {
        if (source.length >= 4) {
          if (source.substring(0, 4) == 'room') {
            mapController!.removeSource(source);
          }
        }
      }
    });
  }

  Future<void> loadBuildingLayer() async {
    var api = GeodataRepository(api: GeodataApiSdk());

    var res = await api.buildingGet();

    if (res.data != null) {
      // adding the buildings and bounds to the list
      for (var feature in res.data!.features) {
        buildings.add({'id': feature.properties['id']!.asNum, 'bounds': feature.bound.coordinates.asList()});
      }
      // displaying the buildings
      addLayers('buildings', GeojsonSourceProperties(data: res.data!.toJson()));
  }
  }

  void AutoPaint(UpdateLevelProvider updateLevelProvider){
    updateLevelProvider.addListener(() {
      paintLevel(updateLevelProvider.currentLevel);
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
            cameraListener(controller, updateZoomLevelProvider);
            controller.requestMyLocationLatLng().then((value) => value != null
                ? controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: value, zoom: 17.0)))
                : null);
            loadBuildingLayer();
            AutoPaint(updateLevelProvider);
          },
        ));
  }
  );}
}