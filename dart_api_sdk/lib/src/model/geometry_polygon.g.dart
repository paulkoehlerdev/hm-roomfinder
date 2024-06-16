// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geometry_polygon.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GeometryPolygonTypeEnum _$geometryPolygonTypeEnum_polygon =
    const GeometryPolygonTypeEnum._('polygon');

GeometryPolygonTypeEnum _$geometryPolygonTypeEnumValueOf(String name) {
  switch (name) {
    case 'polygon':
      return _$geometryPolygonTypeEnum_polygon;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GeometryPolygonTypeEnum> _$geometryPolygonTypeEnumValues =
    new BuiltSet<GeometryPolygonTypeEnum>(const <GeometryPolygonTypeEnum>[
  _$geometryPolygonTypeEnum_polygon,
]);

Serializer<GeometryPolygonTypeEnum> _$geometryPolygonTypeEnumSerializer =
    new _$GeometryPolygonTypeEnumSerializer();

class _$GeometryPolygonTypeEnumSerializer
    implements PrimitiveSerializer<GeometryPolygonTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'polygon': 'Polygon',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Polygon': 'polygon',
  };

  @override
  final Iterable<Type> types = const <Type>[GeometryPolygonTypeEnum];
  @override
  final String wireName = 'GeometryPolygonTypeEnum';

  @override
  Object serialize(Serializers serializers, GeometryPolygonTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GeometryPolygonTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GeometryPolygonTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$GeometryPolygon extends GeometryPolygon {
  @override
  final GeometryPolygonTypeEnum type;
  @override
  final BuiltList<BuiltList<BuiltList<double>>> coordinates;

  factory _$GeometryPolygon([void Function(GeometryPolygonBuilder)? updates]) =>
      (new GeometryPolygonBuilder()..update(updates))._build();

  _$GeometryPolygon._({required this.type, required this.coordinates})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'GeometryPolygon', 'type');
    BuiltValueNullFieldError.checkNotNull(
        coordinates, r'GeometryPolygon', 'coordinates');
  }

  @override
  GeometryPolygon rebuild(void Function(GeometryPolygonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeometryPolygonBuilder toBuilder() =>
      new GeometryPolygonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeometryPolygon &&
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
    return (newBuiltValueToStringHelper(r'GeometryPolygon')
          ..add('type', type)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class GeometryPolygonBuilder
    implements Builder<GeometryPolygon, GeometryPolygonBuilder> {
  _$GeometryPolygon? _$v;

  GeometryPolygonTypeEnum? _type;
  GeometryPolygonTypeEnum? get type => _$this._type;
  set type(GeometryPolygonTypeEnum? type) => _$this._type = type;

  ListBuilder<BuiltList<BuiltList<double>>>? _coordinates;
  ListBuilder<BuiltList<BuiltList<double>>> get coordinates =>
      _$this._coordinates ??= new ListBuilder<BuiltList<BuiltList<double>>>();
  set coordinates(ListBuilder<BuiltList<BuiltList<double>>>? coordinates) =>
      _$this._coordinates = coordinates;

  GeometryPolygonBuilder() {
    GeometryPolygon._defaults(this);
  }

  GeometryPolygonBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _coordinates = $v.coordinates.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeometryPolygon other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GeometryPolygon;
  }

  @override
  void update(void Function(GeometryPolygonBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeometryPolygon build() => _build();

  _$GeometryPolygon _build() {
    _$GeometryPolygon _$result;
    try {
      _$result = _$v ??
          new _$GeometryPolygon._(
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'GeometryPolygon', 'type'),
              coordinates: coordinates.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coordinates';
        coordinates.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GeometryPolygon', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
