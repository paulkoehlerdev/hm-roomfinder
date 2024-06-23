import 'package:app/providers/visible_geodata_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class LevelSelector extends StatefulWidget {
  const LevelSelector({super.key});

  @override
  State<LevelSelector> createState() => _LevelSelectorState();
}

class _LevelSelectorState extends State<LevelSelector> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Consumer<VisibleGeodataProvider>(
        builder: (context, levelProvider, child) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              // if there is no current level, the width is set to 0 --> the level selector is not visible
              width: levelProvider.currentLevel == null ? 0 : width * min(0.1 * levelProvider.availableLevels.length, 0.5),
              height: height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.background,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: levelProvider.availableLevels.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        levelProvider.setCurrentLevel(levelProvider.availableLevels[index]);
                      },
                      child: Container(
                        width: width * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: levelProvider.currentLevel == levelProvider.availableLevels[index]
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background),
                        child: Center(
                            child: Text(levelProvider.availableLevels[index],
                                style: TextStyle(
                                    color: levelProvider.currentLevel == levelProvider.availableLevels[index]
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}