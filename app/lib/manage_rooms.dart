import 'package:app/add_layers.dart';
import 'package:app/providers.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'api/geodata.dart';
import 'api/json_extension.dart';


class ManageRooms{
  AddLayers addLayers = AddLayers();
  MapLibreMapController? mapController;

  setMapController(MapLibreMapController controller) {
    mapController = controller;
  }

  loadRooms(int levelId) async {
    // load rooms from the server
    var api = GeodataRepository(api: GeodataApiSdk());
    var res = await api.roomGet(levelId);

    // del old rooms
    dellAllRooms();

    if (res.data != null){
      //print(res.data!);
      print('rooms_$levelId');
      addLayers.addLayers('rooms_$levelId', GeojsonSourceProperties(data: res.data!.toJson()), mapController);
    }
  }

  dellAllRooms(){
    // delete all rooms from the map
    mapController!.getLayerIds().then((layerIds) {
      for (String layerId in layerIds){
        if (layerId.contains('rooms_')){
          mapController!.removeLayer(layerId);
        }
      }
    });
    mapController!.getSourceIds().then((sourceIds) {
      for (String sourceId in sourceIds){
        if (sourceId.contains('rooms_')){
          mapController!.removeSource(sourceId);
        }
      }
    });
  }

  autoPaintRooms(UpdateLevelProvider updateLevelProvider){
    // load and paint rooms on the map based on the current level
    updateLevelProvider.addListener((){
        loadRooms(updateLevelProvider.currentLevel); // get real level id?
    });
  }
}