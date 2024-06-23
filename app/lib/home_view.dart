import 'package:app/components/search_bar_component.dart';
import 'package:app/components/full_map_page.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Material(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FullMap(),
            SearchBarComponent(),
          ],
        ),
      ),
    );
  }
}