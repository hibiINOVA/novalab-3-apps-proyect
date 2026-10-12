// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderStatusUpdateRequest extends OrderStatusUpdateRequest {
  @override
  final OrderStatus status;

  factory _$OrderStatusUpdateRequest(
          [void Function(OrderStatusUpdateRequestBuilder)? updates]) =>
      (OrderStatusUpdateRequestBuilder()..update(updates))._build();

  _$OrderStatusUpdateRequest._({required this.status}) : super._();
  @override
  OrderStatusUpdateRequest rebuild(
          void Function(OrderStatusUpdateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderStatusUpdateRequestBuilder toBuilder() =>
      OrderStatusUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderStatusUpdateRequest && status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderStatusUpdateRequest')
          ..add('status', status))
        .toString();
  }
}

class OrderStatusUpdateRequestBuilder
    implements
        Builder<OrderStatusUpdateRequest, OrderStatusUpdateRequestBuilder> {
  _$OrderStatusUpdateRequest? _$v;

  OrderStatus? _status;
  OrderStatus? get status => _$this._status;
  set status(OrderStatus? status) => _$this._status = status;

  OrderStatusUpdateRequestBuilder() {
    OrderStatusUpdateRequest._defaults(this);
  }

  OrderStatusUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderStatusUpdateRequest other) {
    _$v = other as _$OrderStatusUpdateRequest;
  }

  @override
  void update(void Function(OrderStatusUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderStatusUpdateRequest build() => _build();

  _$OrderStatusUpdateRequest _build() {
    final _$result = _$v ??
        _$OrderStatusUpdateRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'OrderStatusUpdateRequest', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
