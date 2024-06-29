import 'package:hm_roomfinder/providers/building_provider.dart';
import 'package:hm_roomfinder/providers/current_location_provider.dart';
import 'package:hm_roomfinder/providers/level_provider.dart';
import 'package:hm_roomfinder/providers/polygon_touch_provider.dart';
import 'package:hm_roomfinder/providers/room_provider.dart';
import 'package:hm_roomfinder/providers/seach_bar_state_provider.dart';
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
        ChangeNotifierProvider(create: (context) => CurrentLocationProvider()),
      ],
      child: child,
    );
  }
}