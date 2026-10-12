// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_suggestion.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueueSuggestion extends QueueSuggestion {
  @override
  final int version;
  @override
  final BuiltList<SuggestionAssignment> assignments;
  @override
  final String? summary;
  @override
  final BuiltList<int>? unassignedItemIds;

  factory _$QueueSuggestion([void Function(QueueSuggestionBuilder)? updates]) =>
      (QueueSuggestionBuilder()..update(updates))._build();

  _$QueueSuggestion._(
      {required this.version,
      required this.assignments,
      this.summary,
      this.unassignedItemIds})
      : super._();
  @override
  QueueSuggestion rebuild(void Function(QueueSuggestionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueueSuggestionBuilder toBuilder() => QueueSuggestionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueueSuggestion &&
        version == other.version &&
        assignments == other.assignments &&
        summary == other.summary &&
        unassignedItemIds == other.unassignedItemIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, assignments.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, unassignedItemIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueueSuggestion')
          ..add('version', version)
          ..add('assignments', assignments)
          ..add('summary', summary)
          ..add('unassignedItemIds', unassignedItemIds))
        .toString();
  }
}

class QueueSuggestionBuilder
    implements Builder<QueueSuggestion, QueueSuggestionBuilder> {
  _$QueueSuggestion? _$v;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  ListBuilder<SuggestionAssignment>? _assignments;
  ListBuilder<SuggestionAssignment> get assignments =>
      _$this._assignments ??= ListBuilder<SuggestionAssignment>();
  set assignments(ListBuilder<SuggestionAssignment>? assignments) =>
      _$this._assignments = assignments;

  String? _summary;
  String? get summary => _$this._summary;
  set summary(String? summary) => _$this._summary = summary;

  ListBuilder<int>? _unassignedItemIds;
  ListBuilder<int> get unassignedItemIds =>
      _$this._unassignedItemIds ??= ListBuilder<int>();
  set unassignedItemIds(ListBuilder<int>? unassignedItemIds) =>
      _$this._unassignedItemIds = unassignedItemIds;

  QueueSuggestionBuilder() {
    QueueSuggestion._defaults(this);
  }

  QueueSuggestionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _assignments = $v.assignments.toBuilder();
      _summary = $v.summary;
      _unassignedItemIds = $v.unassignedItemIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueueSuggestion other) {
    _$v = other as _$QueueSuggestion;
  }

  @override
  void update(void Function(QueueSuggestionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueueSuggestion build() => _build();

  _$QueueSuggestion _build() {
    _$QueueSuggestion _$result;
    try {
      _$result = _$v ??
          _$QueueSuggestion._(
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'QueueSuggestion', 'version'),
            assignments: assignments.build(),
            summary: summary,
            unassignedItemIds: _unassignedItemIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assignments';
        assignments.build();

        _$failedField = 'unassignedItemIds';
        _unassignedItemIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'QueueSuggestion', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
