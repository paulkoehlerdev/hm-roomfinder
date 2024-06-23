import 'package:app/map/auto_painter.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../api/geodata.dart';
import '../api/json_extension.dart';
import '../providers/visible_geodata_provider.dart';


class ManageRooms extends AutoPainter<VisibleGeodataProvider> {

  ManageRooms({required super.provider, required super.manager});

  static const _roomFillStyleDark = FillLayerProperties(
    fillColor: '#000000',
    fillOpacity: 0.1,
    fillOutlineColor: '#000000CC',
  );

  static const _roomFillStyle = FillLayerProperties(
    fillColor: '#000000',
    fillOpacity: 0.1,
    fillOutlineColor: '#000000FF',
  );

  @override
  autoPaint(VisibleGeodataProvider provider) async {
    Map<int, FeatureCollection> features = {};
    for (int levelId in provider.visibleLevels) {
      var api = GeodataRepository(api: GeodataApiSdk());
      var res = await api.roomGet(levelId);
      if (res.data == null) {
        return;
      }

      features[levelId] = res.data!;
    }

    manager.removeLayers(manager.layers.where((layer) => layer.startsWith('rooms_')).toList());

    for (var feature in features.entries) {
      manager.addGeoJsonLayer('rooms_${feature.key}', feature.value.toJson(), _roomFillStyle);
    }
  }
}