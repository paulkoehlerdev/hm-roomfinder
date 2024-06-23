
import 'package:app/api/bounds_extension.dart';
import 'package:app/api/json_extension.dart';
import 'package:app/map/layer_manager.dart';
import 'package:app/providers/seach_bar_state_provider.dart';
import 'auto_painter.dart';

class ManageSearchResults extends AutoPainter<SearchBarStateProvider> {
  ManageSearchResults({required super.provider, required super.manager});

  @override
  autoPaint(SearchBarStateProvider provider) async {
    if (provider.selectedFeature == null) {
      manager.setLayerInvisible(LayerType.searchResults);
      return;
    }

    manager.setLayer(LayerType.searchResults, provider.selectedFeature!.toFeatureCollectionJson());
    manager.zoomToBounds(provider.selectedFeature!.bounds!);
  }
}
