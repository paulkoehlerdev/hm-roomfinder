import 'package:app/api/bounds_extension.dart';
import 'package:app/map/layer_manager.dart';
import 'package:app/util/hm_main_color.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../api/geodata.dart';
import '../api/json_extension.dart';
import '../providers/visible_geodata_provider.dart';
import 'bounds.dart';
import 'auto_painter.dart';

class ManageBuildings extends AutoPainter<VisibleGeodataProvider> {
  final Map<int, LatLngBounds> _buildingBounds = {};

  ManageBuildings({required super.provider, required super.manager});

  updateCamera(LatLngBounds bounds) {
    for (var building in _buildingBounds.entries) {
      if (bounds.intersects(building.value)) {
        if (!provider.addVisibleBuilding(building.key)) {
          continue;
        }
        ;

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
    if (provider.hasCurrentLevel) {
      manager.setLayerInvisible(LayerType.building);
      return;
    }

    var api = GeodataRepository(api: GeodataApiSdk());

    var resBuildings = await api.buildingGet();

    if (resBuildings.data == null) {
      return;
    }

    for (var feature in resBuildings.data!.features) {
      _buildingBounds[feature.properties['id']!.asNum.toInt()] =
          feature.bounds!;
    }

    manager.setLayerVisible(LayerType.building);
    manager.setLayer(LayerType.building, resBuildings.data!.toJson());
  }
}
