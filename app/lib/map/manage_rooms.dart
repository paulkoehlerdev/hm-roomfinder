import 'package:app/map/auto_painter.dart';
import 'package:app/map/layer_manager.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

import '../api/geodata.dart';
import '../api/json_extension.dart';
import '../providers/visible_geodata_provider.dart';


class ManageRooms extends AutoPainter<VisibleGeodataProvider> {

  ManageRooms({required super.provider, required super.manager});

  @override
  autoPaint(VisibleGeodataProvider provider) async {
    if (!provider.hasCurrentLevel) {
      manager.setLayerInvisible(LayerType.room);
      return;
    }

    List<Feature> features = [];
    for (int levelId in provider.visibleLevels) {
      var api = GeodataRepository(api: GeodataApiSdk());
      var res = await api.roomGet(levelId);
      if (res.data == null) {
        return;
      }

      features.addAll(res.data!.features);
    }

    manager.setLayer(LayerType.room, features.toFeatureCollectionJson());
  }
}