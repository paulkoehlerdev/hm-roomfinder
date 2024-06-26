import 'package:hm_roomfinder/components/flutter_map_page/touchable_polygon_layer.dart';
import 'package:hm_roomfinder/providers/building_provider.dart';
import 'package:hm_roomfinder/providers/level_provider.dart';
import 'package:hm_roomfinder/providers/polygon_touch_provider.dart';
import 'package:hm_roomfinder/util/hm_main_color.dart';
import 'package:hm_roomfinder/util/polygon_style_extension.dart';
import 'package:flutter/material.dart';
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
        return TouchablePolygonLayer(
          polygons: value.polygons.withStyle(_polygonStyle),
          onTap: (value) {
            Provider.of<PolygonTouchProvider>(context, listen: false).value =
                value;
          },
        );
      },
    );
  }
}
