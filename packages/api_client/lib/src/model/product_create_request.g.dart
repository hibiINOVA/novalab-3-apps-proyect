// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductCreateRequest extends ProductCreateRequest {
  @override
  final String name;
  @override
  final String? material;
  @override
  final String? color;
  @override
  final double? estimatedWeightG;
  @override
  final int? estimatedMinutes;
  @override
  final double? extraCost;
  @override
  final bool? hasGcode;
  @override
  final double? basePrice;

  factory _$ProductCreateRequest(
          [void Function(ProductCreateRequestBuilder)? updates]) =>
      (ProductCreateRequestBuilder()..update(updates))._build();

  _$ProductCreateRequest._(
      {required this.name,
      this.material,
      this.color,
      this.estimatedWeightG,
      this.estimatedMinutes,
      this.extraCost,
      this.hasGcode,
      this.basePrice})
      : super._();
  @override
  ProductCreateRequest rebuild(
          void Function(ProductCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductCreateRequestBuilder toBuilder() =>
      ProductCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductCreateRequest &&
        name == other.name &&
        material == other.material &&
        color == other.color &&
        estimatedWeightG == other.estimatedWeightG &&
        estimatedMinutes == other.estimatedMinutes &&
        extraCost == other.extraCost &&
        hasGcode == other.hasGcode &&
        basePrice == other.basePrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, material.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, estimatedWeightG.hashCode);
    _$hash = $jc(_$hash, estimatedMinutes.hashCode);
    _$hash = $jc(_$hash, extraCost.hashCode);
    _$hash = $jc(_$hash, hasGcode.hashCode);
    _$hash = $jc(_$hash, basePrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductCreateRequest')
          ..add('name', name)
          ..add('material', material)
          ..add('color', color)
          ..add('estimatedWeightG', estimatedWeightG)
          ..add('estimatedMinutes', estimatedMinutes)
          ..add('extraCost', extraCost)
          ..add('hasGcode', hasGcode)
          ..add('basePrice', basePrice))
        .toString();
  }
}

class ProductCreateRequestBuilder
    implements Builder<ProductCreateRequest, ProductCreateRequestBuilder> {
  _$ProductCreateRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _material;
  String? get material => _$this._material;
  set material(String? material) => _$this._material = material;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  double? _estimatedWeightG;
  double? get estimatedWeightG => _$this._estimatedWeightG;
  set estimatedWeightG(double? estimatedWeightG) =>
      _$this._estimatedWeightG = estimatedWeightG;

  int? _estimatedMinutes;
  int? get estimatedMinutes => _$this._estimatedMinutes;
  set estimatedMinutes(int? estimatedMinutes) =>
      _$this._estimatedMinutes = estimatedMinutes;

  double? _extraCost;
  double? get extraCost => _$this._extraCost;
  set extraCost(double? extraCost) => _$this._extraCost = extraCost;

  bool? _hasGcode;
  bool? get hasGcode => _$this._hasGcode;
  set hasGcode(bool? hasGcode) => _$this._hasGcode = hasGcode;

  double? _basePrice;
  double? get basePrice => _$this._basePrice;
  set basePrice(double? basePrice) => _$this._basePrice = basePrice;

  ProductCreateRequestBuilder() {
    ProductCreateRequest._defaults(this);
  }

  ProductCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _material = $v.material;
      _color = $v.color;
      _estimatedWeightG = $v.estimatedWeightG;
      _estimatedMinutes = $v.estimatedMinutes;
      _extraCost = $v.extraCost;
      _hasGcode = $v.hasGcode;
      _basePrice = $v.basePrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductCreateRequest other) {
    _$v = other as _$ProductCreateRequest;
  }

  @override
  void update(void Function(ProductCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductCreateRequest build() => _build();

  _$ProductCreateRequest _build() {
    final _$result = _$v ??
        _$ProductCreateRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'ProductCreateRequest', 'name'),
          material: material,
          color: color,
          estimatedWeightG: estimatedWeightG,
          estimatedMinutes: estimatedMinutes,
          extraCost: extraCost,
          hasGcode: hasGcode,
          basePrice: basePrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
