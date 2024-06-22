// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geometry_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GeometryPointTypeEnum _$geometryPointTypeEnum_point =
    const GeometryPointTypeEnum._('point');

GeometryPointTypeEnum _$geometryPointTypeEnumValueOf(String name) {
  switch (name) {
    case 'point':
      return _$geometryPointTypeEnum_point;
    default:
      return _$geometryPointTypeEnum_point;
  }
}

final BuiltSet<GeometryPointTypeEnum> _$geometryPointTypeEnumValues =
    new BuiltSet<GeometryPointTypeEnum>(const <GeometryPointTypeEnum>[
  _$geometryPointTypeEnum_point,
]);

Serializer<GeometryPointTypeEnum> _$geometryPointTypeEnumSerializer =
    new _$GeometryPointTypeEnumSerializer();

class _$GeometryPointTypeEnumSerializer
    implements PrimitiveSerializer<GeometryPointTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'point': 'Point',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Point': 'point',
  };

  @override
  final Iterable<Type> types = const <Type>[GeometryPointTypeEnum];
  @override
  final String wireName = 'GeometryPointTypeEnum';

  @override
  Object serialize(Serializers serializers, GeometryPointTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GeometryPointTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GeometryPointTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$GeometryPoint extends GeometryPoint {
  @override
  final GeometryPointTypeEnum type;
  @override
  final BuiltList<double> coordinates;

  factory _$GeometryPoint([void Function(GeometryPointBuilder)? updates]) =>
      (new GeometryPointBuilder()..update(updates))._build();

  _$GeometryPoint._({required this.type, required this.coordinates})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'GeometryPoint', 'type');
    BuiltValueNullFieldError.checkNotNull(
        coordinates, r'GeometryPoint', 'coordinates');
  }

  @override
  GeometryPoint rebuild(void Function(GeometryPointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeometryPointBuilder toBuilder() => new GeometryPointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeometryPoint &&
        type == other.type &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, coordinates.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GeometryPoint')
          ..add('type', type)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class GeometryPointBuilder
    implements Builder<GeometryPoint, GeometryPointBuilder> {
  _$GeometryPoint? _$v;

  GeometryPointTypeEnum? _type;
  GeometryPointTypeEnum? get type => _$this._type;
  set type(GeometryPointTypeEnum? type) => _$this._type = type;

  ListBuilder<double>? _coordinates;
  ListBuilder<double> get coordinates =>
      _$this._coordinates ??= new ListBuilder<double>();
  set coordinates(ListBuilder<double>? coordinates) =>
      _$this._coordinates = coordinates;

  GeometryPointBuilder() {
    GeometryPoint._defaults(this);
  }

  GeometryPointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _coordinates = $v.coordinates.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeometryPoint other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GeometryPoint;
  }

  @override
  void update(void Function(GeometryPointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeometryPoint build() => _build();

  _$GeometryPoint _build() {
    _$GeometryPoint _$result;
    try {
      _$result = _$v ??
          new _$GeometryPoint._(
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'GeometryPoint', 'type'),
              coordinates: coordinates.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coordinates';
        coordinates.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GeometryPoint', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
