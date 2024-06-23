import 'package:app/util/hm_main_color.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../api/geodata.dart';
import '../api/json_extension.dart';
import '../providers/visible_geodata_provider.dart';
import 'bounds.dart';
import 'auto_painter.dart';


class ManageBuildings extends AutoPainter<VisibleGeodataProvider>{

  final Map<int, LatLngBounds> _buildingBounds = {};

  ManageBuildings({required super.provider, required super.manager});

  final _roomFillStyle = FillLayerProperties(
    fillColor: const HMMainColor().toHexStringRGB(),
    fillOpacity: 1,
    fillOutlineColor: '#00000000',
  );

  updateCamera(LatLngBounds bounds) {
    for (var building in _buildingBounds.entries) {
      if (bounds.intersects(building.value)) {
        if (!provider.addVisibleBuilding(building.key)) {
          continue;
        };

        _handleLoadingLevels(building.key);
      } else {
        provider.removeVisibleBuilding(building.key);
      }
    }
  }

  _handleLoadingLevels(int buildingId) async {
    var api = GeodataRepository(api: GeodataApiSdk());

    var res = await api.levelGet(buildingId);

    if (res.data == null) {
      return;
    }

    final levels = res.data!.features;

    for (var level in levels) {
      final levelId = level.properties['id']!.asNum.toInt();
      final name = level.properties['name']!.asString;
      provider.addVisibleLayer(name, levelId, buildingId, level);
    }
  }

  @override
  autoPaint(VisibleGeodataProvider provider) async {
    var api = GeodataRepository(api: GeodataApiSdk());

    var resBuildings = await api.buildingGet();

    if (resBuildings.data == null) {
      return;
    }

    for (var feature in resBuildings.data!.features) {
      final buildingBounds = feature.bound.coordinates.asList();
      _buildingBounds[feature.properties['id']!.asNum.toInt()] = LatLngBounds(
          southwest: LatLng(buildingBounds[0][0][1], buildingBounds[0][0][0]),
          northeast: LatLng(buildingBounds[0][2][1], buildingBounds[0][2][0]));
    }

    manager.removeLayer('buildings');

    if (!provider.hasCurrentLevel) {
      manager.addGeoJsonLayer('buildings', resBuildings.data!.toJson(), _roomFillStyle);
    }
  }
}