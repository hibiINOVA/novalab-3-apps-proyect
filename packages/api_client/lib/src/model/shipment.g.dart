// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Shipment extends Shipment {
  @override
  final String carrier;
  @override
  final String? trackingNumber;
  @override
  final String? trackingUrl;
  @override
  final Date? shippedAt;
  @override
  final Date? deliveredAt;

  factory _$Shipment([void Function(ShipmentBuilder)? updates]) =>
      (ShipmentBuilder()..update(updates))._build();

  _$Shipment._(
      {required this.carrier,
      this.trackingNumber,
      this.trackingUrl,
      this.shippedAt,
      this.deliveredAt})
      : super._();
  @override
  Shipment rebuild(void Function(ShipmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShipmentBuilder toBuilder() => ShipmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Shipment &&
        carrier == other.carrier &&
        trackingNumber == other.trackingNumber &&
        trackingUrl == other.trackingUrl &&
        shippedAt == other.shippedAt &&
        deliveredAt == other.deliveredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, carrier.hashCode);
    _$hash = $jc(_$hash, trackingNumber.hashCode);
    _$hash = $jc(_$hash, trackingUrl.hashCode);
    _$hash = $jc(_$hash, shippedAt.hashCode);
    _$hash = $jc(_$hash, deliveredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Shipment')
          ..add('carrier', carrier)
          ..add('trackingNumber', trackingNumber)
          ..add('trackingUrl', trackingUrl)
          ..add('shippedAt', shippedAt)
          ..add('deliveredAt', deliveredAt))
        .toString();
  }
}

class ShipmentBuilder implements Builder<Shipment, ShipmentBuilder> {
  _$Shipment? _$v;

  String? _carrier;
  String? get carrier => _$this._carrier;
  set carrier(String? carrier) => _$this._carrier = carrier;

  String? _trackingNumber;
  String? get trackingNumber => _$this._trackingNumber;
  set trackingNumber(String? trackingNumber) =>
      _$this._trackingNumber = trackingNumber;

  String? _trackingUrl;
  String? get trackingUrl => _$this._trackingUrl;
  set trackingUrl(String? trackingUrl) => _$this._trackingUrl = trackingUrl;

  Date? _shippedAt;
  Date? get shippedAt => _$this._shippedAt;
  set shippedAt(Date? shippedAt) => _$this._shippedAt = shippedAt;

  Date? _deliveredAt;
  Date? get deliveredAt => _$this._deliveredAt;
  set deliveredAt(Date? deliveredAt) => _$this._deliveredAt = deliveredAt;

  ShipmentBuilder() {
    Shipment._defaults(this);
  }

  ShipmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _carrier = $v.carrier;
      _trackingNumber = $v.trackingNumber;
      _trackingUrl = $v.trackingUrl;
      _shippedAt = $v.shippedAt;
      _deliveredAt = $v.deliveredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Shipment other) {
    _$v = other as _$Shipment;
  }

  @override
  void update(void Function(ShipmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Shipment build() => _build();

  _$Shipment _build() {
    final _$result = _$v ??
        _$Shipment._(
          carrier: BuiltValueNullFieldError.checkNotNull(
              carrier, r'Shipment', 'carrier'),
          trackingNumber: trackingNumber,
          trackingUrl: trackingUrl,
          shippedAt: shippedAt,
          deliveredAt: deliveredAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
