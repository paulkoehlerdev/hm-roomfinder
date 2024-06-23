import 'package:app/full_map_page.dart';
import 'package:app/level_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => VisibleGeodataProvider()),
        ],
        child: Consumer<VisibleGeodataProvider>(
            builder: (context, levelsProvider, child) {
          return Scaffold(
            body: Material(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FullMap(),
                  levelsProvider.hasCurrentLevel
                      ? const LevelSelector()
                      : Container(),
                ],
              ),
            ),
          );
        }));
  }
}
