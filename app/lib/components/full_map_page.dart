import 'package:app/components/flutter_map_page/building_layer.dart';
import 'package:app/components/flutter_map_page/level_layer.dart';
import 'package:app/components/flutter_map_page/room_name_layer.dart';
import 'package:app/components/level_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'flutter_map_page/room_layer.dart';
import 'flutter_map_page/search_bar_layer.dart';


class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {

  static const _initialCameraPosition = LatLng(48.14312046865786, 11.56879682080509);
  static const _initialCameraZoom = 17.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LevelSelector(),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: _initialCameraPosition,
          initialZoom: _initialCameraZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://a.tile.openstreetmap.org/{z}/{x}/{y}.png',
            tileSize: 256,
            maxZoom: 19,
          ),
          const BuildingLayer(),
          const LevelLayer(),
          const RoomLayer(),
          const RoomNameLayer(),
          const SearchBarLayer(),
        ],
      ),
    );
  }
}
