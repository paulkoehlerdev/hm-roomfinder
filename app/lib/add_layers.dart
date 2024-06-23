import 'package:maplibre_gl/maplibre_gl.dart';

const fillLayer = FillLayerProperties(
  fillColor: '#ff0000',
  fillOpacity: 0.5,
  fillOutlineColor: '#000000',
);

class AddLayers {
  void addLayers(String layerId, GeojsonSourceProperties geojsonSource, MapLibreMapController? mapController) {
    String sourceId = layerId;
    mapController!.getSourceIds().then((sourceIds) {
      if (!sourceIds.contains(sourceId)) {
        mapController.addSource(sourceId, geojsonSource);
      }
    });
    mapController.getLayerIds().then((layerIds) {
      if (!layerIds.contains(layerId)) {
        mapController.addFillLayer(layerId, layerId, fillLayer);
      }
    });
  }
}