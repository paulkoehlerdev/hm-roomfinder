import 'package:maplibre_gl/maplibre_gl.dart';

class LayerManager {
  final MapLibreMapController mapController;

  final List<String> _layers = [];

  LayerManager({required this.mapController});

  List<String> get layers => List.unmodifiable(_layers);

  bool containsLayer(String layerId) {
    return _layers.contains(layerId);
  }

  void addGeoJsonLayer(String layerId, Map<String, dynamic> data, FillLayerProperties style) {
    print('add $layerId');

    if (_layers.contains(layerId)) {
      removeLayer(layerId);
    }

    _layers.add(layerId);
    mapController.addGeoJsonSource(layerId, data);
    mapController.addFillLayer(layerId, layerId, style);
  }

  void removeLayer(String layerId) {
    print('delete $layerId');

    if (!_layers.contains(layerId)) {
      return;
    }

    _layers.remove(layerId);
    mapController.removeLayer(layerId);
    mapController.removeSource(layerId);
  }

  void removeLayers(List<String> layerId) {
    for (String id in layerId) {
      removeLayer(id);
    }
  }
}