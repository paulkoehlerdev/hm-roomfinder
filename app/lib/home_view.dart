import 'package:app/components/search_bar_component.dart';
import 'package:app/components/full_map_page.dart';
import 'package:app/components/level_selector.dart';
import 'package:app/providers/visible_geodata_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  SearchBarComponent(),
                ],
              ),
            ),
          );
        }));
  }
}