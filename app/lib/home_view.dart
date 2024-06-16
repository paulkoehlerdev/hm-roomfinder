import 'package:app/full_map_page.dart';
import 'package:app/level_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ZoomLevelProvider>(
        create: (context) => ZoomLevelProvider(),
        child: Builder(builder: (BuildContext context) {
          final zoomLevelProvider = Provider.of<ZoomLevelProvider>(context);
          return Material(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FullMap(),
                zoomLevelProvider.zoomLevel ? const LevelSelector() : Container(),
              ],
            ),
          );
        }));
  }
}
