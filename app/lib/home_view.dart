import 'package:app/full_map_page.dart';
import 'package:app/level_selector.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FullMap(),
            LevelSelector(),
          ],
      ),
    );
  }
}