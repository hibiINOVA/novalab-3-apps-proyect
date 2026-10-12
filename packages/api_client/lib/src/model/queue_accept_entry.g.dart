// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_accept_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueueAcceptEntry extends QueueAcceptEntry {
  @override
  final int itemId;
  @override
  final int printerId;

  factory _$QueueAcceptEntry(
          [void Function(QueueAcceptEntryBuilder)? updates]) =>
      (QueueAcceptEntryBuilder()..update(updates))._build();

  _$QueueAcceptEntry._({required this.itemId, required this.printerId})
      : super._();
  @override
  QueueAcceptEntry rebuild(void Function(QueueAcceptEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueueAcceptEntryBuilder toBuilder() =>
      QueueAcceptEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueueAcceptEntry &&
        itemId == other.itemId &&
        printerId == other.printerId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, printerId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueueAcceptEntry')
          ..add('itemId', itemId)
          ..add('printerId', printerId))
        .toString();
  }
}

class QueueAcceptEntryBuilder
    implements Builder<QueueAcceptEntry, QueueAcceptEntryBuilder> {
  _$QueueAcceptEntry? _$v;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  int? _printerId;
  int? get printerId => _$this._printerId;
  set printerId(int? printerId) => _$this._printerId = printerId;

  QueueAcceptEntryBuilder() {
    QueueAcceptEntry._defaults(this);
  }

  QueueAcceptEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemId = $v.itemId;
      _printerId = $v.printerId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueueAcceptEntry other) {
    _$v = other as _$QueueAcceptEntry;
  }

  @override
  void update(void Function(QueueAcceptEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueueAcceptEntry build() => _build();

  _$QueueAcceptEntry _build() {
    final _$result = _$v ??
        _$QueueAcceptEntry._(
          itemId: BuiltValueNullFieldError.checkNotNull(
              itemId, r'QueueAcceptEntry', 'itemId'),
          printerId: BuiltValueNullFieldError.checkNotNull(
              printerId, r'QueueAcceptEntry', 'printerId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
