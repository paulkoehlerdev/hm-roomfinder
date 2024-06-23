import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

import 'api/geodata.dart';
import 'api/json_extension.dart';
import 'providers.dart';
import 'add_layers.dart';


List<Map<String, dynamic>> levels = [];
List loadedLevels = [];
  
  
class ManageLevels {
  MapLibreMapController? mapController;
  AddLayers addLayers = AddLayers();
  ManageLevels({this.mapController});

  void setMapController(MapLibreMapController controller) {
    mapController = controller;
  }

  paintLevel(int levelId) async {
    await delAllLevel();
    for (Map level in levels) {
      if (level['level_id'] == levelId) {
        addLayers.addLayers(
            level['layer_id'], GeojsonSourceProperties(data: level['data']), mapController);
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
          'level_id': levelId,
          'building_id': id,
          'layer_id': 'level_${id}_$levelId',
          'data': element.toJson()
        });
        availableLevels.add({
          'level_name': element.properties['name']!.asString,
          'level_id': levelId,
          'building_id': id,
        });
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

  Future<Map<String, dynamic>> getIntersectingBuildings(LatLng cameraPosition, List buildings) async {
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

  void autoPaint(UpdateLevelProvider updateLevelProvider) {
    updateLevelProvider.addListener(() {
      // load and paint levels on the map based on the current level
      List neededLevels = updateLevelProvider.availableLevels[updateLevelProvider.currentLevel];
      // paint the needed levels
      for (Map level in neededLevels) {
        paintLevel(level['level_id']);
      }
    });
  }

}