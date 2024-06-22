// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FeatureTypeEnum _$featureTypeEnum_feature =
    const FeatureTypeEnum._('feature');

FeatureTypeEnum _$featureTypeEnumValueOf(String name) {
  switch (name) {
    case 'feature':
      return _$featureTypeEnum_feature;
    default:
      return _$featureTypeEnum_feature;
  }
}

final BuiltSet<FeatureTypeEnum> _$featureTypeEnumValues =
    new BuiltSet<FeatureTypeEnum>(const <FeatureTypeEnum>[
  _$featureTypeEnum_feature,
]);

Serializer<FeatureTypeEnum> _$featureTypeEnumSerializer =
    new _$FeatureTypeEnumSerializer();

class _$FeatureTypeEnumSerializer
    implements PrimitiveSerializer<FeatureTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'feature': 'Feature',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Feature': 'feature',
  };

  @override
  final Iterable<Type> types = const <Type>[FeatureTypeEnum];
  @override
  final String wireName = 'FeatureTypeEnum';

  @override
  Object serialize(Serializers serializers, FeatureTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeatureTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeatureTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Feature extends Feature {
  @override
  final FeatureTypeEnum type;
  @override
  final BuiltMap<String, JsonObject?> properties;
  @override
  final GeometryPolygon bound;
  @override
  final FeatureGeometry geometry;

  factory _$Feature([void Function(FeatureBuilder)? updates]) =>
      (new FeatureBuilder()..update(updates))._build();

  _$Feature._(
      {required this.type,
      required this.properties,
      required this.bound,
      required this.geometry})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'Feature', 'type');
    BuiltValueNullFieldError.checkNotNull(properties, r'Feature', 'properties');
    BuiltValueNullFieldError.checkNotNull(bound, r'Feature', 'bound');
    BuiltValueNullFieldError.checkNotNull(geometry, r'Feature', 'geometry');
  }

  @override
  Feature rebuild(void Function(FeatureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeatureBuilder toBuilder() => new FeatureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Feature &&
        type == other.type &&
        properties == other.properties &&
        bound == other.bound &&
        geometry == other.geometry;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, properties.hashCode);
    _$hash = $jc(_$hash, bound.hashCode);
    _$hash = $jc(_$hash, geometry.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Feature')
          ..add('type', type)
          ..add('properties', properties)
          ..add('bound', bound)
          ..add('geometry', geometry))
        .toString();
  }
}

class FeatureBuilder implements Builder<Feature, FeatureBuilder> {
  _$Feature? _$v;

  FeatureTypeEnum? _type;
  FeatureTypeEnum? get type => _$this._type;
  set type(FeatureTypeEnum? type) => _$this._type = type;

  MapBuilder<String, JsonObject?>? _properties;
  MapBuilder<String, JsonObject?> get properties =>
      _$this._properties ??= new MapBuilder<String, JsonObject?>();
  set properties(MapBuilder<String, JsonObject?>? properties) =>
      _$this._properties = properties;

  GeometryPolygonBuilder? _bound;
  GeometryPolygonBuilder get bound =>
      _$this._bound ??= new GeometryPolygonBuilder();
  set bound(GeometryPolygonBuilder? bound) => _$this._bound = bound;

  FeatureGeometryBuilder? _geometry;
  FeatureGeometryBuilder get geometry =>
      _$this._geometry ??= new FeatureGeometryBuilder();
  set geometry(FeatureGeometryBuilder? geometry) => _$this._geometry = geometry;

  FeatureBuilder() {
    Feature._defaults(this);
  }

  FeatureBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _properties = $v.properties.toBuilder();
      _bound = $v.bound.toBuilder();
      _geometry = $v.geometry.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Feature other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Feature;
  }

  @override
  void update(void Function(FeatureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Feature build() => _build();

  _$Feature _build() {
    _$Feature _$result;
    try {
      _$result = _$v ??
          new _$Feature._(
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'Feature', 'type'),
              properties: properties.build(),
              bound: bound.build(),
              geometry: geometry.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'properties';
        properties.build();
        _$failedField = 'bound';
        bound.build();
        _$failedField = 'geometry';
        geometry.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Feature', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
