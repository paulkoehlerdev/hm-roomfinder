import 'package:flutter/material.dart';

class LevelSelector extends StatefulWidget {
  const LevelSelector({super.key});

  @override
  State<LevelSelector> createState() => _LevelSelectorState();
}

final showLevels = ['ug', 'eg', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
int currentLevel = 0;


class _LevelSelectorState extends State<LevelSelector> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: height*0.06),
      child: Container(
        width: width * 0.5,
        height: height*0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: showLevels.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    currentLevel = index;
                  });
                },
                child: Container(
                  width: width * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentLevel == index ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background),
                  child: Center(child: Text(showLevels[index], style: TextStyle(color: currentLevel == index ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface, fontSize: 20, fontWeight: FontWeight.bold))),
                ),
              );
          }),
      ),
    );
  }
}