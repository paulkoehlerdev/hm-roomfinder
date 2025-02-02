import 'package:hm_roomfinder/providers/level_provider.dart';
import 'package:hm_roomfinder/providers/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hm_roomfinder/util/globals.dart';
import 'package:provider/provider.dart';

import '../../util/polygon_style_extension.dart';

class LevelLayer extends StatelessWidget {
  const LevelLayer({super.key});

  static _polygonStyle(ThemeData theme) =>
      PolygonStyle(
        color: theme.colorScheme.surface,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<LevelProvider>(
      builder: (BuildContext context, LevelProvider value, Widget? child) {
        if (value.currentLevelId != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<RoomProvider>(context, listen: false)
                .loadRooms(value.currentLevelId!);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<RoomProvider>(context, listen: false).clearRooms();
          });
        }

        return PolygonLayer(
          polygons: value.polygons.withStyle(
            _polygonStyle(lightTheme,),),
        );
      },
    );
  }
}
