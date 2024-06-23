import 'package:app/providers/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class RoomNameLayer extends StatelessWidget {
  const RoomNameLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (BuildContext context, RoomProvider value, Widget? child) {
        return MarkerLayer(
          rotate: true,
          markers: _generateMarkers(value.roomNames),
        );
      },
    );
  }

  List<Marker> _generateMarkers(Map<String, LatLng> roomNames) {
    return roomNames.entries.map((entry) {
      return Marker(
        width: 80.0,
        point: entry.value,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            entry.key,
            style: const TextStyle(color: Colors.black, fontSize: 10),
          ),
        ),
      );
    }).toList();
  }
}
