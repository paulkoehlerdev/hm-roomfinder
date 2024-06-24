import 'package:app/providers/building_provider.dart';
import 'package:app/providers/level_provider.dart';
import 'package:app/providers/polygon_touch_provider.dart';
import 'package:app/providers/room_provider.dart';
import 'package:app/providers/seach_bar_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderInitializerComponent extends StatelessWidget {

  final Widget child;

  const ProviderInitializerComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchBarStateProvider()),
        ChangeNotifierProvider(create: (context) => BuildingProvider()),
        ChangeNotifierProvider(create: (context) => LevelProvider()),
        ChangeNotifierProvider(create: (context) => RoomProvider()),
        ChangeNotifierProvider(create: (context) => PolygonTouchProvider()),
      ],
      child: child,
    );
  }
}