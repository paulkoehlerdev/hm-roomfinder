// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_geometry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FeatureGeometryTypeEnum _$featureGeometryTypeEnum_point =
    const FeatureGeometryTypeEnum._('point');
const FeatureGeometryTypeEnum _$featureGeometryTypeEnum_polygon =
    const FeatureGeometryTypeEnum._('polygon');

FeatureGeometryTypeEnum _$featureGeometryTypeEnumValueOf(String name) {
  switch (name) {
    case 'point':
      return _$featureGeometryTypeEnum_point;
    case 'polygon':
      return _$featureGeometryTypeEnum_polygon;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<FeatureGeometryTypeEnum> _$featureGeometryTypeEnumValues =
    new BuiltSet<FeatureGeometryTypeEnum>(const <FeatureGeometryTypeEnum>[
  _$featureGeometryTypeEnum_point,
  _$featureGeometryTypeEnum_polygon,
]);

Serializer<FeatureGeometryTypeEnum> _$featureGeometryTypeEnumSerializer =
    new _$FeatureGeometryTypeEnumSerializer();

class _$FeatureGeometryTypeEnumSerializer
    implements PrimitiveSerializer<FeatureGeometryTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'point': 'Point',
    'polygon': 'Polygon',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Point': 'point',
    'Polygon': 'polygon',
  };

  @override
  final Iterable<Type> types = const <Type>[FeatureGeometryTypeEnum];
  @override
  final String wireName = 'FeatureGeometryTypeEnum';

  @override
  Object serialize(Serializers serializers, FeatureGeometryTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeatureGeometryTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeatureGeometryTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FeatureGeometry extends FeatureGeometry {
  @override
  final OneOf oneOf;

  factory _$FeatureGeometry([void Function(FeatureGeometryBuilder)? updates]) =>
      (new FeatureGeometryBuilder()..update(updates))._build();

  _$FeatureGeometry._({required this.oneOf}) : super._() {
    BuiltValueNullFieldError.checkNotNull(oneOf, r'FeatureGeometry', 'oneOf');
  }

  @override
  FeatureGeometry rebuild(void Function(FeatureGeometryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeatureGeometryBuilder toBuilder() =>
      new FeatureGeometryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeatureGeometry && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeatureGeometry')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FeatureGeometryBuilder
    implements Builder<FeatureGeometry, FeatureGeometryBuilder> {
  _$FeatureGeometry? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FeatureGeometryBuilder() {
    FeatureGeometry._defaults(this);
  }

  FeatureGeometryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeatureGeometry other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FeatureGeometry;
  }

  @override
  void update(void Function(FeatureGeometryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeatureGeometry build() => _build();

  _$FeatureGeometry _build() {
    final _$result = _$v ??
        new _$FeatureGeometry._(
            oneOf: BuiltValueNullFieldError.checkNotNull(
                oneOf, r'FeatureGeometry', 'oneOf'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
