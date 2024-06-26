import 'dart:math';

import 'package:hm_roomfinder/api/bounds_extension.dart';
import 'package:hm_roomfinder/providers/level_provider.dart';
import 'package:hm_roomfinder/providers/seach_bar_state_provider.dart';
import 'package:hm_roomfinder/util/polygon_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class SearchBarLayer extends StatelessWidget {
  const SearchBarLayer({super.key});

  _polygonStyle(ThemeData theme) => PolygonStyle(
        color: theme.colorScheme.primary,
        borderColor: theme.colorScheme.onPrimary,
        borderStrokeWidth: 2.0,
        label: true,
        labelStyle: TextStyle(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        rotateLabel: true,
        labelPlacement: PolygonLabelPlacement.polylabel,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarStateProvider>(
      builder:
          (BuildContext context, SearchBarStateProvider value, Widget? child) {
        if (value.selectedFeature == null) return const SizedBox();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final mapcontroller = MapController.of(context);

          final zoom = mapcontroller.camera.zoom;

          mapcontroller.move(
              value.selectedFeature!.bounds!.center, max(zoom, 16.0));

          //TODO: Add way to select correct level in a building.
        });

        return PolygonLayer(
          polygons: [value.polygon!.copyWith(_polygonStyle(Theme.of(context)))],
        );
      },
    );
  }
}
