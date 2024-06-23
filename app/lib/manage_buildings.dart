import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'api/geodata.dart';
import 'api/json_extension.dart';
import 'add_layers.dart';


class ManageBuildings{
  AddLayers addLayers = AddLayers();

  Future<List<Map<String, dynamic>>> loadBuildingLayer(MapLibreMapController mapController) async {
    List<Map<String, dynamic>> buildings = [];

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
      addLayers.addLayers('buildings', GeojsonSourceProperties(data: res.data!.toJson()), mapController);
    }
    return buildings;
  }
}