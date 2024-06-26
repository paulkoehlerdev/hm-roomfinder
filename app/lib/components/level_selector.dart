import 'package:hm_roomfinder/providers/level_provider.dart';
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
    return Consumer<LevelProvider>(
        builder: (context, levelProvider, child) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              // if there is no current level, the width is set to 0 --> the level selector is not visible
              width: levelProvider.currentLevelId == null ? 0 : width * min(0.1 * levelProvider.levelNames.length, 0.5),
              height: height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.background,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: levelProvider.levelNames.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        levelProvider.selectLevel(levelProvider.levelNames.values.toList()[index]);
                      },
                      child: Container(
                        width: width * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: levelProvider.currentLevelId == levelProvider.levelNames.values.toList()[index]
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background),
                        child: Center(
                            child: Text(levelProvider.levelNames.keys.toList()[index],
                                style: TextStyle(
                                    color: levelProvider.currentLevelId == levelProvider.levelNames.values.toList()[index]
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
