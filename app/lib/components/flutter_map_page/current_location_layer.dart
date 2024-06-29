import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hm_roomfinder/providers/current_location_provider.dart';
import 'package:hm_roomfinder/util/hm_main_color.dart';
import 'package:provider/provider.dart';

class CurrentLocationLayer extends StatelessWidget {
  const CurrentLocationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentLocationProvider>(
      builder:
          (BuildContext context, CurrentLocationProvider value, Widget? child) {
        if (value.currentLocation == null) {
          return const SizedBox();
        }

        MapController.of(context).mapEventStream.listen((event) {
          if (value.tracking &&
              (value.currentLocation == null ||
                  !event.camera.visibleBounds.contains(value.currentLocation!))) {
            value.tracking = false;
          }

        });

        if (value.tracking) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            MapController.of(context).move(value.currentLocation!,
                max(18.0, MapController.of(context).camera.zoom));
          });
        }

        return MarkerLayer(
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: value.currentLocation!,
              child: const Icon(
                Icons.circle_rounded,
                color: HMMainColor(),
                size: 15.0,
              ),
            ),
          ],
        );
      },
    );
  }
}
