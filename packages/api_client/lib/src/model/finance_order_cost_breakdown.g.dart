// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_order_cost_breakdown.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceOrderCostBreakdown extends FinanceOrderCostBreakdown {
  @override
  final num material;
  @override
  final num light;
  @override
  final num packaging;
  @override
  final num shipping;
  @override
  final num commissions;
  @override
  final num other;

  factory _$FinanceOrderCostBreakdown(
          [void Function(FinanceOrderCostBreakdownBuilder)? updates]) =>
      (FinanceOrderCostBreakdownBuilder()..update(updates))._build();

  _$FinanceOrderCostBreakdown._(
      {required this.material,
      required this.light,
      required this.packaging,
      required this.shipping,
      required this.commissions,
      required this.other})
      : super._();
  @override
  FinanceOrderCostBreakdown rebuild(
          void Function(FinanceOrderCostBreakdownBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinanceOrderCostBreakdownBuilder toBuilder() =>
      FinanceOrderCostBreakdownBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceOrderCostBreakdown &&
        material == other.material &&
        light == other.light &&
        packaging == other.packaging &&
        shipping == other.shipping &&
        commissions == other.commissions &&
        this.other == other.other;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, material.hashCode);
    _$hash = $jc(_$hash, light.hashCode);
    _$hash = $jc(_$hash, packaging.hashCode);
    _$hash = $jc(_$hash, shipping.hashCode);
    _$hash = $jc(_$hash, commissions.hashCode);
    _$hash = $jc(_$hash, other.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceOrderCostBreakdown')
          ..add('material', material)
          ..add('light', light)
          ..add('packaging', packaging)
          ..add('shipping', shipping)
          ..add('commissions', commissions)
          ..add('other', other))
        .toString();
  }
}

class FinanceOrderCostBreakdownBuilder
    implements
        Builder<FinanceOrderCostBreakdown, FinanceOrderCostBreakdownBuilder> {
  _$FinanceOrderCostBreakdown? _$v;

  num? _material;
  num? get material => _$this._material;
  set material(num? material) => _$this._material = material;

  num? _light;
  num? get light => _$this._light;
  set light(num? light) => _$this._light = light;

  num? _packaging;
  num? get packaging => _$this._packaging;
  set packaging(num? packaging) => _$this._packaging = packaging;

  num? _shipping;
  num? get shipping => _$this._shipping;
  set shipping(num? shipping) => _$this._shipping = shipping;

  num? _commissions;
  num? get commissions => _$this._commissions;
  set commissions(num? commissions) => _$this._commissions = commissions;

  num? _other;
  num? get other => _$this._other;
  set other(num? other) => _$this._other = other;

  FinanceOrderCostBreakdownBuilder() {
    FinanceOrderCostBreakdown._defaults(this);
  }

  FinanceOrderCostBreakdownBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _material = $v.material;
      _light = $v.light;
      _packaging = $v.packaging;
      _shipping = $v.shipping;
      _commissions = $v.commissions;
      _other = $v.other;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceOrderCostBreakdown other) {
    _$v = other as _$FinanceOrderCostBreakdown;
  }

  @override
  void update(void Function(FinanceOrderCostBreakdownBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceOrderCostBreakdown build() => _build();

  _$FinanceOrderCostBreakdown _build() {
    final _$result = _$v ??
        _$FinanceOrderCostBreakdown._(
          material: BuiltValueNullFieldError.checkNotNull(
              material, r'FinanceOrderCostBreakdown', 'material'),
          light: BuiltValueNullFieldError.checkNotNull(
              light, r'FinanceOrderCostBreakdown', 'light'),
          packaging: BuiltValueNullFieldError.checkNotNull(
              packaging, r'FinanceOrderCostBreakdown', 'packaging'),
          shipping: BuiltValueNullFieldError.checkNotNull(
              shipping, r'FinanceOrderCostBreakdown', 'shipping'),
          commissions: BuiltValueNullFieldError.checkNotNull(
              commissions, r'FinanceOrderCostBreakdown', 'commissions'),
          other: BuiltValueNullFieldError.checkNotNull(
              other, r'FinanceOrderCostBreakdown', 'other'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
