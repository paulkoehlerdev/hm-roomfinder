//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'geometry_polygon.g.dart';

/// GeometryPolygon
///
/// Properties:
/// * [type]
/// * [coordinates]
@BuiltValue()
abstract class GeometryPolygon
    implements Built<GeometryPolygon, GeometryPolygonBuilder> {
  @BuiltValueField(wireName: r'type')
  GeometryPolygonTypeEnum get type;
  // enum typeEnum {  Polygon,  };

  @BuiltValueField(wireName: r'coordinates')
  BuiltList<BuiltList<BuiltList<double>>> get coordinates;

  GeometryPolygon._();

  factory GeometryPolygon([void updates(GeometryPolygonBuilder b)]) =
      _$GeometryPolygon;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GeometryPolygonBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GeometryPolygon> get serializer =>
      _$GeometryPolygonSerializer();
}

class _$GeometryPolygonSerializer
    implements PrimitiveSerializer<GeometryPolygon> {
  @override
  final Iterable<Type> types = const [GeometryPolygon, _$GeometryPolygon];

  @override
  final String wireName = r'GeometryPolygon';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GeometryPolygon object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(GeometryPolygonTypeEnum),
    );
    yield r'coordinates';
    yield serializers.serialize(
      object.coordinates,
      specifiedType: const FullType(BuiltList, [
        FullType(BuiltList, [
          FullType(BuiltList, [FullType(double)])
        ])
      ]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GeometryPolygon object, {
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
    required GeometryPolygonBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GeometryPolygonTypeEnum),
          ) as GeometryPolygonTypeEnum;
          result.type = valueDes;
          break;
        case r'coordinates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltList, [
                FullType(BuiltList, [FullType(double)])
              ])
            ]),
          ) as BuiltList<BuiltList<BuiltList<double>>>;
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
  GeometryPolygon deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GeometryPolygonBuilder();
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

class GeometryPolygonTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Polygon', fallback: true)
  static const GeometryPolygonTypeEnum polygon =
      _$geometryPolygonTypeEnum_polygon;

  static Serializer<GeometryPolygonTypeEnum> get serializer =>
      _$geometryPolygonTypeEnumSerializer;

  const GeometryPolygonTypeEnum._(String name) : super(name);

  static BuiltSet<GeometryPolygonTypeEnum> get values =>
      _$geometryPolygonTypeEnumValues;
  static GeometryPolygonTypeEnum valueOf(String name) =>
      _$geometryPolygonTypeEnumValueOf(name);
}
