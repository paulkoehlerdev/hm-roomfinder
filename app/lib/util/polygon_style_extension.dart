import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class PolygonStyle {
  final Color? color;
  final double? borderStrokeWidth;
  final Color? borderColor;
  final TextStyle? labelStyle;
  final PolygonLabelPlacement? labelPlacement;
  final bool label;
  final bool? rotateLabel;

  const PolygonStyle({
    this.color,
    this.borderStrokeWidth,
    this.borderColor,
    this.labelStyle,
    this.labelPlacement,
    this.label = false,
    this.rotateLabel,
  });
}

extension PolygonCopyWith on Polygon {
  Polygon copyWith(PolygonStyle style) {
    return Polygon(
      points: points,
      hitValue: hitValue,
      label: style.label ? label : null,
      labelPlacement: style.labelPlacement ?? labelPlacement,
      labelStyle: style.labelStyle ?? labelStyle,
      rotateLabel: style.rotateLabel ?? rotateLabel,
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