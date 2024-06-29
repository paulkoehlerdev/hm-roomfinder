import 'package:flutter/material.dart';
import 'package:hm_roomfinder/providers/current_location_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationPermissonRequester extends StatelessWidget {
  final Widget child;
  final Widget? loadingChild;

  const LocationPermissonRequester(
      {super.key, required this.child, this.loadingChild});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: requestLocationPermission(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return child;
        } else {
          return Scaffold(
            body: loadingChild ??
                const Center(
                  child: CircularProgressIndicator(),
                ),
          );
        }
      },
    );
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location service is not enabled");
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is not granted");
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      print("Location changed: ${currentLocation.latitude}, ${currentLocation.longitude}");

      if (currentLocation.latitude == null || currentLocation.longitude == null) {
        return;
      }

      var provider = Provider.of<CurrentLocationProvider>(context, listen: false);

      provider.currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
    await location.enableBackgroundMode();

    print("Location permission is granted");
  }
}
