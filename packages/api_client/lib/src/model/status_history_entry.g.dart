// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_history_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatusHistoryEntry extends StatusHistoryEntry {
  @override
  final String status;
  @override
  final DateTime occurredAt;
  @override
  final String? previousStatus;
  @override
  final String? userName;

  factory _$StatusHistoryEntry(
          [void Function(StatusHistoryEntryBuilder)? updates]) =>
      (StatusHistoryEntryBuilder()..update(updates))._build();

  _$StatusHistoryEntry._(
      {required this.status,
      required this.occurredAt,
      this.previousStatus,
      this.userName})
      : super._();
  @override
  StatusHistoryEntry rebuild(
          void Function(StatusHistoryEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatusHistoryEntryBuilder toBuilder() =>
      StatusHistoryEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatusHistoryEntry &&
        status == other.status &&
        occurredAt == other.occurredAt &&
        previousStatus == other.previousStatus &&
        userName == other.userName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jc(_$hash, previousStatus.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StatusHistoryEntry')
          ..add('status', status)
          ..add('occurredAt', occurredAt)
          ..add('previousStatus', previousStatus)
          ..add('userName', userName))
        .toString();
  }
}

class StatusHistoryEntryBuilder
    implements Builder<StatusHistoryEntry, StatusHistoryEntryBuilder> {
  _$StatusHistoryEntry? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  String? _previousStatus;
  String? get previousStatus => _$this._previousStatus;
  set previousStatus(String? previousStatus) =>
      _$this._previousStatus = previousStatus;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  StatusHistoryEntryBuilder() {
    StatusHistoryEntry._defaults(this);
  }

  StatusHistoryEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _occurredAt = $v.occurredAt;
      _previousStatus = $v.previousStatus;
      _userName = $v.userName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatusHistoryEntry other) {
    _$v = other as _$StatusHistoryEntry;
  }

  @override
  void update(void Function(StatusHistoryEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StatusHistoryEntry build() => _build();

  _$StatusHistoryEntry _build() {
    final _$result = _$v ??
        _$StatusHistoryEntry._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'StatusHistoryEntry', 'status'),
          occurredAt: BuiltValueNullFieldError.checkNotNull(
              occurredAt, r'StatusHistoryEntry', 'occurredAt'),
          previousStatus: previousStatus,
          userName: userName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
