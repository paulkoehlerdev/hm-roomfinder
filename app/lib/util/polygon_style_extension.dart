import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class PolygonStyle {
  final Color? color;
  final double? borderStrokeWidth;
  final Color? borderColor;

  const PolygonStyle({
    this.color,
    this.borderStrokeWidth,
    this.borderColor,
  });
}

extension PolygonCopyWith on Polygon {
  Polygon copyWith(PolygonStyle style) {
    return Polygon(
      points: points,
      color: style.color ?? color,
      borderStrokeWidth: style.borderStrokeWidth ?? borderStrokeWidth,
      borderColor: style.borderColor ?? borderColor,
    );
  }
}

extension PolygonStyleExtension on List<Polygon> {
  List<Polygon> withStyle(PolygonStyle style) {
    return map((polygon) => polygon.copyWith(style)).toList();
  }
}