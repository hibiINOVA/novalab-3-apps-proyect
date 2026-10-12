// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Product extends Product {
  @override
  final int id;
  @override
  final String name;
  @override
  final double basePrice;
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

  factory _$Product([void Function(ProductBuilder)? updates]) =>
      (ProductBuilder()..update(updates))._build();

  _$Product._(
      {required this.id,
      required this.name,
      required this.basePrice,
      this.material,
      this.color,
      this.estimatedWeightG,
      this.estimatedMinutes,
      this.extraCost,
      this.hasGcode})
      : super._();
  @override
  Product rebuild(void Function(ProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductBuilder toBuilder() => ProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Product &&
        id == other.id &&
        name == other.name &&
        basePrice == other.basePrice &&
        material == other.material &&
        color == other.color &&
        estimatedWeightG == other.estimatedWeightG &&
        estimatedMinutes == other.estimatedMinutes &&
        extraCost == other.extraCost &&
        hasGcode == other.hasGcode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, basePrice.hashCode);
    _$hash = $jc(_$hash, material.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, estimatedWeightG.hashCode);
    _$hash = $jc(_$hash, estimatedMinutes.hashCode);
    _$hash = $jc(_$hash, extraCost.hashCode);
    _$hash = $jc(_$hash, hasGcode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Product')
          ..add('id', id)
          ..add('name', name)
          ..add('basePrice', basePrice)
          ..add('material', material)
          ..add('color', color)
          ..add('estimatedWeightG', estimatedWeightG)
          ..add('estimatedMinutes', estimatedMinutes)
          ..add('extraCost', extraCost)
          ..add('hasGcode', hasGcode))
        .toString();
  }
}

class ProductBuilder implements Builder<Product, ProductBuilder> {
  _$Product? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  double? _basePrice;
  double? get basePrice => _$this._basePrice;
  set basePrice(double? basePrice) => _$this._basePrice = basePrice;

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

  ProductBuilder() {
    Product._defaults(this);
  }

  ProductBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _basePrice = $v.basePrice;
      _material = $v.material;
      _color = $v.color;
      _estimatedWeightG = $v.estimatedWeightG;
      _estimatedMinutes = $v.estimatedMinutes;
      _extraCost = $v.extraCost;
      _hasGcode = $v.hasGcode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Product other) {
    _$v = other as _$Product;
  }

  @override
  void update(void Function(ProductBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Product build() => _build();

  _$Product _build() {
    final _$result = _$v ??
        _$Product._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Product', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(name, r'Product', 'name'),
          basePrice: BuiltValueNullFieldError.checkNotNull(
              basePrice, r'Product', 'basePrice'),
          material: material,
          color: color,
          estimatedWeightG: estimatedWeightG,
          estimatedMinutes: estimatedMinutes,
          extraCost: extraCost,
          hasGcode: hasGcode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
