
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class PolygonTouchProvider extends ValueNotifier<LayerHitResult<Object>?> {
  Feature? get feature => value?.hitValues.firstOrNull as Feature;

  PolygonTouchProvider() : super(null);
}