import 'package:maplibre_gl/maplibre_gl.dart';

class SetUserposition {
  late final MapLibreMapController controller;
  
  void setController(MapLibreMapController controller){
    this.controller = controller;
  }

  void cameraToUserPosition() {
    controller.requestMyLocationLatLng().then((value) => value != null
        ? controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: value, zoom: 17.0)))
        : null);
  }
}