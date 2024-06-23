import 'package:app/providers/building_provider.dart';
import 'package:app/providers/level_provider.dart';
import 'package:app/util/hm_main_color.dart';
import 'package:app/util/polygon_style_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class BuildingLayer extends StatelessWidget {
  const BuildingLayer({super.key});

  static const _zoomThreshold = 17.0;

  static const _polygonStyle = PolygonStyle(
    color: HMMainColor(),
  );

  @override
  Widget build(BuildContext context) {
    int last = 0;
    MapController.of(context).mapEventStream.listen((event) {
      int now = DateTime.now().millisecondsSinceEpoch;
      if (now - last < 100) return;
      last = now;

      final levelProvider = Provider.of<LevelProvider>(context, listen: false);
      final buildingProvider =
          Provider.of<BuildingProvider>(context, listen: false);

      if (event.camera.zoom < _zoomThreshold) {
        levelProvider.clearLevels();
        return;
      }

      final buildings = (buildingProvider.bounds
            ..removeWhere((key, value) =>
                !event.camera.visibleBounds.isOverlapping(value)))
          .keys;

      if (buildings.isEmpty) return;

      // TODO: Add building selection in view, if multiple buildings are visible.
      levelProvider.loadLevels(buildings.first);
    });

    return Consumer<BuildingProvider>(
      builder: (BuildContext context, BuildingProvider value, Widget? child) {
        return PolygonLayer(polygons: value.polygons.withStyle(_polygonStyle));
      },
    );
  }
}
