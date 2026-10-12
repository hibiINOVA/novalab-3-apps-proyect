// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_assignment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SuggestionAssignment extends SuggestionAssignment {
  @override
  final int itemId;
  @override
  final int printerId;
  @override
  final String printerName;
  @override
  final String explanation;
  @override
  final String? orderFolio;
  @override
  final String? productName;
  @override
  final int? estimatedMinutes;

  factory _$SuggestionAssignment(
          [void Function(SuggestionAssignmentBuilder)? updates]) =>
      (SuggestionAssignmentBuilder()..update(updates))._build();

  _$SuggestionAssignment._(
      {required this.itemId,
      required this.printerId,
      required this.printerName,
      required this.explanation,
      this.orderFolio,
      this.productName,
      this.estimatedMinutes})
      : super._();
  @override
  SuggestionAssignment rebuild(
          void Function(SuggestionAssignmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SuggestionAssignmentBuilder toBuilder() =>
      SuggestionAssignmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuggestionAssignment &&
        itemId == other.itemId &&
        printerId == other.printerId &&
        printerName == other.printerName &&
        explanation == other.explanation &&
        orderFolio == other.orderFolio &&
        productName == other.productName &&
        estimatedMinutes == other.estimatedMinutes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, printerId.hashCode);
    _$hash = $jc(_$hash, printerName.hashCode);
    _$hash = $jc(_$hash, explanation.hashCode);
    _$hash = $jc(_$hash, orderFolio.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, estimatedMinutes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SuggestionAssignment')
          ..add('itemId', itemId)
          ..add('printerId', printerId)
          ..add('printerName', printerName)
          ..add('explanation', explanation)
          ..add('orderFolio', orderFolio)
          ..add('productName', productName)
          ..add('estimatedMinutes', estimatedMinutes))
        .toString();
  }
}

class SuggestionAssignmentBuilder
    implements Builder<SuggestionAssignment, SuggestionAssignmentBuilder> {
  _$SuggestionAssignment? _$v;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  int? _printerId;
  int? get printerId => _$this._printerId;
  set printerId(int? printerId) => _$this._printerId = printerId;

  String? _printerName;
  String? get printerName => _$this._printerName;
  set printerName(String? printerName) => _$this._printerName = printerName;

  String? _explanation;
  String? get explanation => _$this._explanation;
  set explanation(String? explanation) => _$this._explanation = explanation;

  String? _orderFolio;
  String? get orderFolio => _$this._orderFolio;
  set orderFolio(String? orderFolio) => _$this._orderFolio = orderFolio;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  int? _estimatedMinutes;
  int? get estimatedMinutes => _$this._estimatedMinutes;
  set estimatedMinutes(int? estimatedMinutes) =>
      _$this._estimatedMinutes = estimatedMinutes;

  SuggestionAssignmentBuilder() {
    SuggestionAssignment._defaults(this);
  }

  SuggestionAssignmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemId = $v.itemId;
      _printerId = $v.printerId;
      _printerName = $v.printerName;
      _explanation = $v.explanation;
      _orderFolio = $v.orderFolio;
      _productName = $v.productName;
      _estimatedMinutes = $v.estimatedMinutes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuggestionAssignment other) {
    _$v = other as _$SuggestionAssignment;
  }

  @override
  void update(void Function(SuggestionAssignmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuggestionAssignment build() => _build();

  _$SuggestionAssignment _build() {
    final _$result = _$v ??
        _$SuggestionAssignment._(
          itemId: BuiltValueNullFieldError.checkNotNull(
              itemId, r'SuggestionAssignment', 'itemId'),
          printerId: BuiltValueNullFieldError.checkNotNull(
              printerId, r'SuggestionAssignment', 'printerId'),
          printerName: BuiltValueNullFieldError.checkNotNull(
              printerName, r'SuggestionAssignment', 'printerName'),
          explanation: BuiltValueNullFieldError.checkNotNull(
              explanation, r'SuggestionAssignment', 'explanation'),
          orderFolio: orderFolio,
          productName: productName,
          estimatedMinutes: estimatedMinutes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
