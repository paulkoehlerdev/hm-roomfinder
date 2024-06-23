import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

import 'api/geodata.dart';
import 'api/json_extension.dart';
import 'providers.dart';


List<Map<String, dynamic>> buildings = [];
List<Map<String, dynamic>> levels = [];
List loadedLevels = [];

const fillLayer = FillLayerProperties(
  fillColor: '#ff0000',
  fillOpacity: 0.5,
  fillOutlineColor: '#000000',
);
  
  
class ManageLevels {
  MapLibreMapController? mapController;
  ManageLevels({this.mapController});

  void setMapController(MapLibreMapController controller) {
    mapController = controller;
  }

  paintLevel(int level) async {
    await delAllLevel();
    for (Map level in levels) {
      if (level['level'] == level) {
        addLayers(
            level['layer_id'], GeojsonSourceProperties(data: level['data']));
      }
    }
  }

  Future<Set> loadLevel(id) async {
    var api = GeodataRepository(api: GeodataApiSdk());
    var res = await api.levelGet(id);

    Set availableLevels = {};
    if (res.data != null) {
      res.data!.features.forEach((element) {
        num levelId = element.properties['id']!.asNum;
        loadedLevels.add(id);
        levels.add({
          'level': levelId,
          'building_id': id,
          'layer_id': 'level_${id}_$levelId',
          'data': element.toJson()
        });
        availableLevels.add(levelId.toString());
      });
    }
    return availableLevels;
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
    if (screenBounds.northeast.latitude > building.southwest.latitude &&
        screenBounds.southwest.latitude < building.northeast.latitude &&
        screenBounds.northeast.longitude > building.southwest.longitude &&
        screenBounds.southwest.longitude < building.northeast.longitude) {
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>> getIntersectingBuildings(LatLng cameraPosition) async {
    bool newLayersInScreen = false;
    bool layersInScreen = false;
    Set availableLevels = {};
    LatLngBounds visable = await mapController!.getVisibleRegion();
    for (Map building in buildings) {
      if (isBuildingIntersect(visable, building['bounds'])) {
        // if the building is in the screen
        if (!loadedLevels.contains(building['id'])) {
          // if the building is not already loaded
          newLayersInScreen = true;
          layersInScreen = true;
          availableLevels = await loadLevel(building['id']);
        } else {
          // if the building is already loaded and still in the screen
          layersInScreen = true;
        }
      }
    }
    return {'new': newLayersInScreen, 'total': layersInScreen, 'availableLevels': availableLevels};
  }

  void addLayers(String layerId, GeojsonSourceProperties geojsonSource) {
    String sourceId = layerId;
    mapController!.getSourceIds().then((sourceIds) {
      if (!sourceIds.contains(sourceId)) {
        mapController!.addSource(sourceId, geojsonSource);
      }
    });
    mapController!.getLayerIds().then((layerIds) {
      if (!layerIds.contains(layerId)) {
        mapController!.addFillLayer(layerId, layerId, fillLayer);
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
        buildings.add({
          'id': feature.properties['id']!.asNum,
          'bounds': feature.bound.coordinates.asList()
        });
      }
      // displaying the buildings
      addLayers('buildings', GeojsonSourceProperties(data: res.data!.toJson()));
    }
  }

  void autoPaint(UpdateLevelProvider updateLevelProvider) {
    updateLevelProvider.addListener(() {
      paintLevel(updateLevelProvider.currentLevel);
    });
  }

}