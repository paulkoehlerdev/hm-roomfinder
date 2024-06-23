import 'package:app/providers/level_provider.dart';
import 'package:app/providers/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../util/polygon_style_extension.dart';

class RoomLayer extends StatelessWidget {
  const RoomLayer({super.key});

  static final _polygonStyle = PolygonStyle(
    color: Colors.grey,
    borderStrokeWidth: 2.0,
    borderColor: Colors.grey.shade800,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (BuildContext context, RoomProvider value, Widget? child) {
        return PolygonLayer(polygons: value.polygons.withStyle(_polygonStyle));
      },
    );
  }
}
