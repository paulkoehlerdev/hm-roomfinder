import 'package:app/map/layer_manager.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import '../api/json_extension.dart';
import '../providers/visible_geodata_provider.dart';
import 'auto_painter.dart';
  
  
class ManageLevels extends AutoPainter<VisibleGeodataProvider> {
  ManageLevels({required super.provider, required super.manager});

  @override
  autoPaint(VisibleGeodataProvider provider) {
    if (!provider.hasCurrentLevel) {
      manager.setLayerInvisible(LayerType.level);
      return;
    }

    List<Feature> features = [];
    for (int levelId in provider.visibleLevels) {
      features.add(provider.getVisibleLayerGeom(levelId)!);
    }

    manager.setLayer(LayerType.level, features.toFeatureCollectionJson());
  }
}