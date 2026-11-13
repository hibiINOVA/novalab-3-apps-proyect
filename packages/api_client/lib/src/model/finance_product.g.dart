// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceProduct extends FinanceProduct {
  @override
  final int productId;
  @override
  final String productName;
  @override
  final int ordersCount;
  @override
  final num income;
  @override
  final num costs;
  @override
  final num profit;
  @override
  final num margin;

  factory _$FinanceProduct([void Function(FinanceProductBuilder)? updates]) =>
      (FinanceProductBuilder()..update(updates))._build();

  _$FinanceProduct._(
      {required this.productId,
      required this.productName,
      required this.ordersCount,
      required this.income,
      required this.costs,
      required this.profit,
      required this.margin})
      : super._();
  @override
  FinanceProduct rebuild(void Function(FinanceProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinanceProductBuilder toBuilder() => FinanceProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceProduct &&
        productId == other.productId &&
        productName == other.productName &&
        ordersCount == other.ordersCount &&
        income == other.income &&
        costs == other.costs &&
        profit == other.profit &&
        margin == other.margin;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, ordersCount.hashCode);
    _$hash = $jc(_$hash, income.hashCode);
    _$hash = $jc(_$hash, costs.hashCode);
    _$hash = $jc(_$hash, profit.hashCode);
    _$hash = $jc(_$hash, margin.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceProduct')
          ..add('productId', productId)
          ..add('productName', productName)
          ..add('ordersCount', ordersCount)
          ..add('income', income)
          ..add('costs', costs)
          ..add('profit', profit)
          ..add('margin', margin))
        .toString();
  }
}

class FinanceProductBuilder
    implements Builder<FinanceProduct, FinanceProductBuilder> {
  _$FinanceProduct? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  int? _ordersCount;
  int? get ordersCount => _$this._ordersCount;
  set ordersCount(int? ordersCount) => _$this._ordersCount = ordersCount;

  num? _income;
  num? get income => _$this._income;
  set income(num? income) => _$this._income = income;

  num? _costs;
  num? get costs => _$this._costs;
  set costs(num? costs) => _$this._costs = costs;

  num? _profit;
  num? get profit => _$this._profit;
  set profit(num? profit) => _$this._profit = profit;

  num? _margin;
  num? get margin => _$this._margin;
  set margin(num? margin) => _$this._margin = margin;

  FinanceProductBuilder() {
    FinanceProduct._defaults(this);
  }

  FinanceProductBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _productName = $v.productName;
      _ordersCount = $v.ordersCount;
      _income = $v.income;
      _costs = $v.costs;
      _profit = $v.profit;
      _margin = $v.margin;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceProduct other) {
    _$v = other as _$FinanceProduct;
  }

  @override
  void update(void Function(FinanceProductBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceProduct build() => _build();

  _$FinanceProduct _build() {
    final _$result = _$v ??
        _$FinanceProduct._(
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'FinanceProduct', 'productId'),
          productName: BuiltValueNullFieldError.checkNotNull(
              productName, r'FinanceProduct', 'productName'),
          ordersCount: BuiltValueNullFieldError.checkNotNull(
              ordersCount, r'FinanceProduct', 'ordersCount'),
          income: BuiltValueNullFieldError.checkNotNull(
              income, r'FinanceProduct', 'income'),
          costs: BuiltValueNullFieldError.checkNotNull(
              costs, r'FinanceProduct', 'costs'),
          profit: BuiltValueNullFieldError.checkNotNull(
              profit, r'FinanceProduct', 'profit'),
          margin: BuiltValueNullFieldError.checkNotNull(
              margin, r'FinanceProduct', 'margin'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
