import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPermissonRequester extends StatelessWidget {
  final Widget child;
  final Widget? loadingChild;

  const LocationPermissonRequester(
      {super.key, required this.child, this.loadingChild});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: requestLocationPermission(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return this.child;
        } else {
          return Scaffold(
            body: this.loadingChild ??
                const Center(
                  child: CircularProgressIndicator(),
                ),
          );
        }
      },
    );
  }

  Future<void> requestLocationPermission() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
