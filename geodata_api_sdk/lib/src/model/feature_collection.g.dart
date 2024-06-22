// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_collection.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FeatureCollectionTypeEnum _$featureCollectionTypeEnum_featureCollection =
    const FeatureCollectionTypeEnum._('featureCollection');

FeatureCollectionTypeEnum _$featureCollectionTypeEnumValueOf(String name) {
  switch (name) {
    case 'featureCollection':
      return _$featureCollectionTypeEnum_featureCollection;
    default:
      return _$featureCollectionTypeEnum_featureCollection;
  }
}

final BuiltSet<FeatureCollectionTypeEnum> _$featureCollectionTypeEnumValues =
    new BuiltSet<FeatureCollectionTypeEnum>(const <FeatureCollectionTypeEnum>[
  _$featureCollectionTypeEnum_featureCollection,
]);

Serializer<FeatureCollectionTypeEnum> _$featureCollectionTypeEnumSerializer =
    new _$FeatureCollectionTypeEnumSerializer();

class _$FeatureCollectionTypeEnumSerializer
    implements PrimitiveSerializer<FeatureCollectionTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'featureCollection': 'FeatureCollection',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FeatureCollection': 'featureCollection',
  };

  @override
  final Iterable<Type> types = const <Type>[FeatureCollectionTypeEnum];
  @override
  final String wireName = 'FeatureCollectionTypeEnum';

  @override
  Object serialize(Serializers serializers, FeatureCollectionTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeatureCollectionTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeatureCollectionTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FeatureCollection extends FeatureCollection {
  @override
  final FeatureCollectionTypeEnum type;
  @override
  final BuiltList<Feature> features;

  factory _$FeatureCollection(
          [void Function(FeatureCollectionBuilder)? updates]) =>
      (new FeatureCollectionBuilder()..update(updates))._build();

  _$FeatureCollection._({required this.type, required this.features})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'FeatureCollection', 'type');
    BuiltValueNullFieldError.checkNotNull(
        features, r'FeatureCollection', 'features');
  }

  @override
  FeatureCollection rebuild(void Function(FeatureCollectionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeatureCollectionBuilder toBuilder() =>
      new FeatureCollectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeatureCollection &&
        type == other.type &&
        features == other.features;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, features.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeatureCollection')
          ..add('type', type)
          ..add('features', features))
        .toString();
  }
}

class FeatureCollectionBuilder
    implements Builder<FeatureCollection, FeatureCollectionBuilder> {
  _$FeatureCollection? _$v;

  FeatureCollectionTypeEnum? _type;
  FeatureCollectionTypeEnum? get type => _$this._type;
  set type(FeatureCollectionTypeEnum? type) => _$this._type = type;

  ListBuilder<Feature>? _features;
  ListBuilder<Feature> get features =>
      _$this._features ??= new ListBuilder<Feature>();
  set features(ListBuilder<Feature>? features) => _$this._features = features;

  FeatureCollectionBuilder() {
    FeatureCollection._defaults(this);
  }

  FeatureCollectionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _features = $v.features.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeatureCollection other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FeatureCollection;
  }

  @override
  void update(void Function(FeatureCollectionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeatureCollection build() => _build();

  _$FeatureCollection _build() {
    _$FeatureCollection _$result;
    try {
      _$result = _$v ??
          new _$FeatureCollection._(
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'FeatureCollection', 'type'),
              features: features.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'features';
        features.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FeatureCollection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
