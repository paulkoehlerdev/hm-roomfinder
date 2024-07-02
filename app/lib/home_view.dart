import 'package:hm_roomfinder/components/search_bar_component.dart';
import 'package:hm_roomfinder/components/full_map_page.dart';
import 'package:flutter/material.dart';
import 'util/globals.dart' as globals;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            globals.testMode ? Container() : const FullMap(),
            const SearchBarComponent(),
          ],
        ),
      ),
    );
  }
}