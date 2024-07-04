import 'dart:math';

import 'package:hm_roomfinder/api/bounds_extension.dart';
import 'package:hm_roomfinder/api/properties_extension.dart';
import 'package:hm_roomfinder/providers/level_provider.dart';
import 'package:hm_roomfinder/providers/seach_bar_state_provider.dart';
import 'package:hm_roomfinder/util/globals.dart';
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
      builder: (BuildContext context,
          SearchBarStateProvider searchBarStateProvider, Widget? child) {
        if (searchBarStateProvider.selectedFeature == null)
          return const SizedBox();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final mapcontroller = MapController.of(context);

          mapcontroller.fitCamera(
            CameraFit.bounds(
              bounds: searchBarStateProvider.selectedFeature!.bounds!,
              padding: const EdgeInsets.all(80.0),
            ),
          );

          var levelId =
              searchBarStateProvider.selectedFeature?.searchResultLevelId;
          if (levelId != null) {
            var levelProvider =
                Provider.of<LevelProvider>(context, listen: false);
            levelProvider.selectLevelByLevelId(levelId);
          }
        });

        return Consumer<LevelProvider>(builder:
            (BuildContext context, LevelProvider levelProvider, Widget? child) {
          if (!(levelProvider.currentLevelId?.contains(searchBarStateProvider
                  .selectedFeature?.searchResultLevelId) ??
              false)) {
            return const SizedBox();
          }

          return PolygonLayer(
            polygons: [
              searchBarStateProvider.polygon!
                  .copyWith(_polygonStyle(lightTheme))
            ],
          );
        });
      },
    );
  }
}
