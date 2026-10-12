// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_reorder_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueueReorderEntry extends QueueReorderEntry {
  @override
  final int id;
  @override
  final int position;
  @override
  final int? printerId;

  factory _$QueueReorderEntry(
          [void Function(QueueReorderEntryBuilder)? updates]) =>
      (QueueReorderEntryBuilder()..update(updates))._build();

  _$QueueReorderEntry._(
      {required this.id, required this.position, this.printerId})
      : super._();
  @override
  QueueReorderEntry rebuild(void Function(QueueReorderEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueueReorderEntryBuilder toBuilder() =>
      QueueReorderEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueueReorderEntry &&
        id == other.id &&
        position == other.position &&
        printerId == other.printerId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, printerId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueueReorderEntry')
          ..add('id', id)
          ..add('position', position)
          ..add('printerId', printerId))
        .toString();
  }
}

class QueueReorderEntryBuilder
    implements Builder<QueueReorderEntry, QueueReorderEntryBuilder> {
  _$QueueReorderEntry? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _position;
  int? get position => _$this._position;
  set position(int? position) => _$this._position = position;

  int? _printerId;
  int? get printerId => _$this._printerId;
  set printerId(int? printerId) => _$this._printerId = printerId;

  QueueReorderEntryBuilder() {
    QueueReorderEntry._defaults(this);
  }

  QueueReorderEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _position = $v.position;
      _printerId = $v.printerId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueueReorderEntry other) {
    _$v = other as _$QueueReorderEntry;
  }

  @override
  void update(void Function(QueueReorderEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueueReorderEntry build() => _build();

  _$QueueReorderEntry _build() {
    final _$result = _$v ??
        _$QueueReorderEntry._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'QueueReorderEntry', 'id'),
          position: BuiltValueNullFieldError.checkNotNull(
              position, r'QueueReorderEntry', 'position'),
          printerId: printerId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
