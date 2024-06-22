// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Feature.serializer)
      ..add(FeatureCollection.serializer)
      ..add(FeatureCollectionTypeEnum.serializer)
      ..add(FeatureGeometry.serializer)
      ..add(FeatureTypeEnum.serializer)
      ..add(GeometryPoint.serializer)
      ..add(GeometryPointTypeEnum.serializer)
      ..add(GeometryPolygon.serializer)
      ..add(GeometryPolygonTypeEnum.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [
              const FullType(BuiltList, const [const FullType(double)])
            ])
          ]),
          () => new ListBuilder<BuiltList<BuiltList<double>>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(double)])
          ]),
          () => new ListBuilder<BuiltList<double>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Feature)]),
          () => new ListBuilder<Feature>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(double)]),
          () => new ListBuilder<double>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType.nullable(JsonObject)
          ]),
          () => new MapBuilder<String, JsonObject?>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
