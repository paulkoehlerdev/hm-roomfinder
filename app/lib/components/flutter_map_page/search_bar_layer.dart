import 'package:app/api/bounds_extension.dart';
import 'package:app/providers/level_provider.dart';
import 'package:app/providers/seach_bar_state_provider.dart';
import 'package:app/util/polygon_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class SearchBarLayer extends StatelessWidget {
  const SearchBarLayer({super.key});

  _polygonStyle(ThemeData theme) => PolygonStyle(
        color: theme.colorScheme.primary,
        borderColor: theme.colorScheme.onPrimary,
        borderStrokeWidth: 2.0,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarStateProvider>(
      builder:
          (BuildContext context, SearchBarStateProvider value, Widget? child) {
        if (value.selectedFeature == null) return const SizedBox();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          MapController.of(context)
              .move(value.selectedFeature!.bounds!.center, 18.5);

          //TODO: Add way to select correct level in a building.
        });

        return PolygonLayer(
          polygons: [value.polygon!.copyWith(_polygonStyle(Theme.of(context)))],
        );
      },
    );
  }
}
