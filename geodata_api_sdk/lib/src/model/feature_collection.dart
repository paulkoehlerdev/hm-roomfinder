//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:geodata_api_sdk/src/model/feature.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'feature_collection.g.dart';

/// FeatureCollection
///
/// Properties:
/// * [type]
/// * [features]
@BuiltValue()
abstract class FeatureCollection
    implements Built<FeatureCollection, FeatureCollectionBuilder> {
  @BuiltValueField(wireName: r'type')
  FeatureCollectionTypeEnum get type;
  // enum typeEnum {  FeatureCollection,  };

  @BuiltValueField(wireName: r'features')
  BuiltList<Feature> get features;

  FeatureCollection._();

  factory FeatureCollection([void updates(FeatureCollectionBuilder b)]) =
      _$FeatureCollection;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeatureCollectionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeatureCollection> get serializer =>
      _$FeatureCollectionSerializer();
}

class _$FeatureCollectionSerializer
    implements PrimitiveSerializer<FeatureCollection> {
  @override
  final Iterable<Type> types = const [FeatureCollection, _$FeatureCollection];

  @override
  final String wireName = r'FeatureCollection';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FeatureCollection object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(FeatureCollectionTypeEnum),
    );
    yield r'features';
    yield serializers.serialize(
      object.features,
      specifiedType: const FullType(BuiltList, [FullType(Feature)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FeatureCollection object, {
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
    required FeatureCollectionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FeatureCollectionTypeEnum),
          ) as FeatureCollectionTypeEnum;
          result.type = valueDes;
          break;
        case r'features':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Feature)]),
          ) as BuiltList<Feature>;
          result.features.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FeatureCollection deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FeatureCollectionBuilder();
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

class FeatureCollectionTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'FeatureCollection', fallback: true)
  static const FeatureCollectionTypeEnum featureCollection =
      _$featureCollectionTypeEnum_featureCollection;

  static Serializer<FeatureCollectionTypeEnum> get serializer =>
      _$featureCollectionTypeEnumSerializer;

  const FeatureCollectionTypeEnum._(String name) : super(name);

  static BuiltSet<FeatureCollectionTypeEnum> get values =>
      _$featureCollectionTypeEnumValues;
  static FeatureCollectionTypeEnum valueOf(String name) =>
      _$featureCollectionTypeEnumValueOf(name);
}
