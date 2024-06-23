import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

enum LayerType {
  building(
    layerName: 'building',
    fillStyle: FillLayerProperties(
      fillColor: "#fc5555",
      fillOpacity: 1,
      fillOutlineColor: '#000000',
    ),
  ),
  level(
    layerName: 'level',
    fillStyle: FillLayerProperties(
      fillColor: '#e8e8e8',
      fillOpacity: 0.9,
      fillOutlineColor: '#FF0000',
    ),
  ),
  room(
    layerName: 'room',
    fillStyle: FillLayerProperties(
      fillColor: '#000000',
      fillOpacity: 0.1,
      fillOutlineColor: '#000000',
    ),
  ),
  searchResults(
    layerName: 'searchResults',
    fillStyle: FillLayerProperties(
      fillColor: "#fc5555",
      fillOpacity: 1,
      fillOutlineColor: '#000000',
    ),
  );

  final String layerName;
  final FillLayerProperties fillStyle;

  const LayerType({required this.layerName, required this.fillStyle});

  String get layerId => layerName;

  String get sourceId => layerName;

  FillLayerProperties get style => fillStyle;
}


class LayerManager {
  final emptyGeoJson = jsonDecode('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[0,0]}}]}');

  final MapLibreMapController _mapController;

  LayerManager({required MapLibreMapController mapController})
      : _mapController = mapController {
    Future.delayed(Duration.zero, generateLayers);
  }

  Future<void> generateLayers() async {
    for (var layer in LayerType.values) {
      if (!(await _mapController.getSourceIds()).whereType<String>().contains(layer.sourceId)) {
        await _mapController.addSource(
          layer.sourceId,
          GeojsonSourceProperties(
            data: emptyGeoJson,
          ),
        );
      } else {
        await _mapController.setGeoJsonSource(layer.sourceId, emptyGeoJson);
      }

      if (!(await _mapController.getLayerIds()).contains(layer.layerId)) {
        await _mapController.addFillLayer(
          layer.sourceId,
          layer.layerId,
          layer.style,
        );
      } else {
        await _mapController.setLayerVisibility(layer.layerId, true);
      }
    }
  }

  Future<void> setLayer(LayerType type, Map<String, dynamic> data) async {
    await _mapController.setGeoJsonSource(type.sourceId, data);
    await setLayerVisible(type);
  }

  Future<void> setLayerInvisible(LayerType layer) async {
    await _mapController.setLayerVisibility(layer.layerId, false);
  }

  Future<void> setLayerVisible(LayerType layer) async {
    await _mapController.setLayerVisibility(layer.layerId, true);
  }

  Future<void> zoomToBounds(LatLngBounds bounds) async {
    await _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        left: 100,
        right: 100,
        top: 100,
        bottom: 100,
      ),
    );
  }
}
