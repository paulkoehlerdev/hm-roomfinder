//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'geometry_point.g.dart';

/// GeometryPoint
///
/// Properties:
/// * [type]
/// * [coordinates]
@BuiltValue()
abstract class GeometryPoint
    implements Built<GeometryPoint, GeometryPointBuilder> {
  @BuiltValueField(wireName: r'type')
  GeometryPointTypeEnum get type;
  // enum typeEnum {  Point,  };

  @BuiltValueField(wireName: r'coordinates')
  BuiltList<double> get coordinates;

  GeometryPoint._();

  factory GeometryPoint([void updates(GeometryPointBuilder b)]) =
      _$GeometryPoint;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GeometryPointBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GeometryPoint> get serializer =>
      _$GeometryPointSerializer();
}

class _$GeometryPointSerializer implements PrimitiveSerializer<GeometryPoint> {
  @override
  final Iterable<Type> types = const [GeometryPoint, _$GeometryPoint];

  @override
  final String wireName = r'GeometryPoint';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GeometryPoint object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(GeometryPointTypeEnum),
    );
    yield r'coordinates';
    yield serializers.serialize(
      object.coordinates,
      specifiedType: const FullType(BuiltList, [FullType(double)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GeometryPoint object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GeometryPointBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GeometryPointTypeEnum),
          ) as GeometryPointTypeEnum;
          result.type = valueDes;
          break;
        case r'coordinates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(double)]),
          ) as BuiltList<double>;
          result.coordinates.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GeometryPoint deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GeometryPointBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class GeometryPointTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Point', fallback: true)
  static const GeometryPointTypeEnum point = _$geometryPointTypeEnum_point;

  static Serializer<GeometryPointTypeEnum> get serializer =>
      _$geometryPointTypeEnumSerializer;

  const GeometryPointTypeEnum._(String name) : super(name);

  static BuiltSet<GeometryPointTypeEnum> get values =>
      _$geometryPointTypeEnumValues;
  static GeometryPointTypeEnum valueOf(String name) =>
      _$geometryPointTypeEnumValueOf(name);
}
