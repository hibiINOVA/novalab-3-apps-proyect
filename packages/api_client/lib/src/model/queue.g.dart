// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Queue extends Queue {
  @override
  final BuiltList<QueueItem> unassigned;
  @override
  final BuiltMap<String, BuiltList<QueueItem>> byPrinter;
  @override
  final int version;

  factory _$Queue([void Function(QueueBuilder)? updates]) =>
      (QueueBuilder()..update(updates))._build();

  _$Queue._(
      {required this.unassigned,
      required this.byPrinter,
      required this.version})
      : super._();
  @override
  Queue rebuild(void Function(QueueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueueBuilder toBuilder() => QueueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Queue &&
        unassigned == other.unassigned &&
        byPrinter == other.byPrinter &&
        version == other.version;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, unassigned.hashCode);
    _$hash = $jc(_$hash, byPrinter.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Queue')
          ..add('unassigned', unassigned)
          ..add('byPrinter', byPrinter)
          ..add('version', version))
        .toString();
  }
}

class QueueBuilder implements Builder<Queue, QueueBuilder> {
  _$Queue? _$v;

  ListBuilder<QueueItem>? _unassigned;
  ListBuilder<QueueItem> get unassigned =>
      _$this._unassigned ??= ListBuilder<QueueItem>();
  set unassigned(ListBuilder<QueueItem>? unassigned) =>
      _$this._unassigned = unassigned;

  MapBuilder<String, BuiltList<QueueItem>>? _byPrinter;
  MapBuilder<String, BuiltList<QueueItem>> get byPrinter =>
      _$this._byPrinter ??= MapBuilder<String, BuiltList<QueueItem>>();
  set byPrinter(MapBuilder<String, BuiltList<QueueItem>>? byPrinter) =>
      _$this._byPrinter = byPrinter;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  QueueBuilder() {
    Queue._defaults(this);
  }

  QueueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _unassigned = $v.unassigned.toBuilder();
      _byPrinter = $v.byPrinter.toBuilder();
      _version = $v.version;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Queue other) {
    _$v = other as _$Queue;
  }

  @override
  void update(void Function(QueueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Queue build() => _build();

  _$Queue _build() {
    _$Queue _$result;
    try {
      _$result = _$v ??
          _$Queue._(
            unassigned: unassigned.build(),
            byPrinter: byPrinter.build(),
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'Queue', 'version'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'unassigned';
        unassigned.build();
        _$failedField = 'byPrinter';
        byPrinter.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'Queue', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
