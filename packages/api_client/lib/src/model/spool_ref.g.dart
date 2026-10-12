// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spool_ref.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SpoolRef extends SpoolRef {
  @override
  final int id;
  @override
  final String material;
  @override
  final String color;
  @override
  final double? gramsRemaining;

  factory _$SpoolRef([void Function(SpoolRefBuilder)? updates]) =>
      (SpoolRefBuilder()..update(updates))._build();

  _$SpoolRef._(
      {required this.id,
      required this.material,
      required this.color,
      this.gramsRemaining})
      : super._();
  @override
  SpoolRef rebuild(void Function(SpoolRefBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SpoolRefBuilder toBuilder() => SpoolRefBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SpoolRef &&
        id == other.id &&
        material == other.material &&
        color == other.color &&
        gramsRemaining == other.gramsRemaining;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, material.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, gramsRemaining.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SpoolRef')
          ..add('id', id)
          ..add('material', material)
          ..add('color', color)
          ..add('gramsRemaining', gramsRemaining))
        .toString();
  }
}

class SpoolRefBuilder implements Builder<SpoolRef, SpoolRefBuilder> {
  _$SpoolRef? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _material;
  String? get material => _$this._material;
  set material(String? material) => _$this._material = material;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  double? _gramsRemaining;
  double? get gramsRemaining => _$this._gramsRemaining;
  set gramsRemaining(double? gramsRemaining) =>
      _$this._gramsRemaining = gramsRemaining;

  SpoolRefBuilder() {
    SpoolRef._defaults(this);
  }

  SpoolRefBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _material = $v.material;
      _color = $v.color;
      _gramsRemaining = $v.gramsRemaining;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SpoolRef other) {
    _$v = other as _$SpoolRef;
  }

  @override
  void update(void Function(SpoolRefBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SpoolRef build() => _build();

  _$SpoolRef _build() {
    final _$result = _$v ??
        _$SpoolRef._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SpoolRef', 'id'),
          material: BuiltValueNullFieldError.checkNotNull(
              material, r'SpoolRef', 'material'),
          color: BuiltValueNullFieldError.checkNotNull(
              color, r'SpoolRef', 'color'),
          gramsRemaining: gramsRemaining,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
