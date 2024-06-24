import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class TouchablePolygonLayer extends StatelessWidget {
  final List<Polygon> polygons;
  final ValueSetter<LayerHitResult<Object>?>? onTap;

  const TouchablePolygonLayer({super.key, required this.polygons, required this.onTap});

  @override
  Widget build(BuildContext context) {

    final hitNotifier = ValueNotifier<LayerHitResult<Object>?>(null);

    return MouseRegion(
      hitTestBehavior: HitTestBehavior.deferToChild,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap != null ? () {
            onTap!(hitNotifier.value);
        }: null,
        child: PolygonLayer(
          polygons: polygons,
          hitNotifier: hitNotifier,
        ),
      ),
    );
  }
}
