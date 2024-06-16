//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/geometry_polygon.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/geometry_point.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'feature_geometry.g.dart';

/// FeatureGeometry
///
/// Properties:
/// * [type]
/// * [coordinates]
@BuiltValue()
abstract class FeatureGeometry
    implements Built<FeatureGeometry, FeatureGeometryBuilder> {
  /// One Of [GeometryPoint], [GeometryPolygon]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'type';

  static const Map<String, Type> discriminatorMapping = {
    r'Point': GeometryPoint,
    r'Polygon': GeometryPolygon,
  };

  FeatureGeometry._();

  factory FeatureGeometry([void updates(FeatureGeometryBuilder b)]) =
      _$FeatureGeometry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeatureGeometryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeatureGeometry> get serializer =>
      _$FeatureGeometrySerializer();
}

extension FeatureGeometryDiscriminatorExt on FeatureGeometry {
  String? get discriminatorValue {
    if (this is GeometryPoint) {
      return r'Point';
    }
    if (this is GeometryPolygon) {
      return r'Polygon';
    }
    return null;
  }
}

extension FeatureGeometryBuilderDiscriminatorExt on FeatureGeometryBuilder {
  String? get discriminatorValue {
    if (this is GeometryPointBuilder) {
      return r'Point';
    }
    if (this is GeometryPolygonBuilder) {
      return r'Polygon';
    }
    return null;
  }
}

class _$FeatureGeometrySerializer
    implements PrimitiveSerializer<FeatureGeometry> {
  @override
  final Iterable<Type> types = const [FeatureGeometry, _$FeatureGeometry];

  @override
  final String wireName = r'FeatureGeometry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FeatureGeometry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    FeatureGeometry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FeatureGeometry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FeatureGeometryBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex =
        serializedList.indexOf(FeatureGeometry.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex],
        specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [
      GeometryPoint,
      GeometryPolygon,
    ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'Point':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(GeometryPoint),
        ) as GeometryPoint;
        oneOfType = GeometryPoint;
        break;
      case r'Polygon':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(GeometryPolygon),
        ) as GeometryPolygon;
        oneOfType = GeometryPolygon;
        break;
      default:
        throw UnsupportedError(
            "Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(
        typeIndex: oneOfTypes.indexOf(oneOfType),
        types: oneOfTypes,
        value: oneOfResult);
    return result.build();
  }
}

class FeatureGeometryTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Point')
  static const FeatureGeometryTypeEnum point = _$featureGeometryTypeEnum_point;
  @BuiltValueEnumConst(wireName: r'Polygon')
  static const FeatureGeometryTypeEnum polygon =
      _$featureGeometryTypeEnum_polygon;

  static Serializer<FeatureGeometryTypeEnum> get serializer =>
      _$featureGeometryTypeEnumSerializer;

  const FeatureGeometryTypeEnum._(String name) : super(name);

  static BuiltSet<FeatureGeometryTypeEnum> get values =>
      _$featureGeometryTypeEnumValues;
  static FeatureGeometryTypeEnum valueOf(String name) =>
      _$featureGeometryTypeEnumValueOf(name);
}
