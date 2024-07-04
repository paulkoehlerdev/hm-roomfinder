import 'package:hm_roomfinder/components/flutter_map_page/touchable_polygon_layer.dart';
import 'package:hm_roomfinder/providers/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../providers/polygon_touch_provider.dart';
import '../../util/globals.dart';
import '../../util/polygon_style_extension.dart';

class RoomLayer extends StatelessWidget {
  const RoomLayer({super.key});

  static _polygonStyle(ThemeData theme) => PolygonStyle(
        color: theme.colorScheme.primaryContainer,
        borderStrokeWidth: 1.0,
        borderColor: theme.colorScheme.onPrimaryContainer,
        labelStyle: TextStyle(
          color: theme.colorScheme.onPrimaryContainer,
          fontSize: 10,
        ),
        labelPlacement: PolygonLabelPlacement.polylabel,
        label: true,
        rotateLabel: true,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (BuildContext context, RoomProvider value, Widget? child) {
        return TouchablePolygonLayer(
          polygons: value.polygons.withStyle(_polygonStyle(lightTheme)),
          onTap: (value) {
            Provider.of<PolygonTouchProvider>(context, listen: false).value =
                value;
          },
        );
      },
    );
  }
}
