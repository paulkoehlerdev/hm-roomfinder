import 'package:maplibre_gl/maplibre_gl.dart';
import '../providers.dart';
import '../api/json_extension.dart';
import 'auto_painter.dart';
  
  
class ManageLevels extends AutoPainter<VisibleGeodataProvider> {
  ManageLevels({required super.provider, required super.manager});

  static const _roomFillStyleDark = FillLayerProperties(
    fillColor: '#1f1f1f',
    fillOpacity: 0.9,
    fillOutlineColor: '#00000000',
  );

  static const _roomFillStyle = FillLayerProperties(
    fillColor: '#e8e8e8',
    fillOpacity: 0.9,
    fillOutlineColor: '#FF0000FF',
  );

  @override
  autoPaint(VisibleGeodataProvider provider) {
    manager.removeLayers(manager.layers.where((layer) => layer.startsWith('level_')).toList());

    for (int levelId in provider.visibleLevels) {
      final feature = provider.getVisibleLayerGeom(levelId);
      manager.addGeoJsonLayer('level_$levelId', feature!.toFeatureCollectionJson(), _roomFillStyle);
    }
  }
}