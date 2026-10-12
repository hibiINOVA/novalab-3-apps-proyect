// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_accept_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueueAcceptRequest extends QueueAcceptRequest {
  @override
  final int version;
  @override
  final BuiltList<QueueAcceptEntry> assignments;

  factory _$QueueAcceptRequest(
          [void Function(QueueAcceptRequestBuilder)? updates]) =>
      (QueueAcceptRequestBuilder()..update(updates))._build();

  _$QueueAcceptRequest._({required this.version, required this.assignments})
      : super._();
  @override
  QueueAcceptRequest rebuild(
          void Function(QueueAcceptRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueueAcceptRequestBuilder toBuilder() =>
      QueueAcceptRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueueAcceptRequest &&
        version == other.version &&
        assignments == other.assignments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, assignments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueueAcceptRequest')
          ..add('version', version)
          ..add('assignments', assignments))
        .toString();
  }
}

class QueueAcceptRequestBuilder
    implements Builder<QueueAcceptRequest, QueueAcceptRequestBuilder> {
  _$QueueAcceptRequest? _$v;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  ListBuilder<QueueAcceptEntry>? _assignments;
  ListBuilder<QueueAcceptEntry> get assignments =>
      _$this._assignments ??= ListBuilder<QueueAcceptEntry>();
  set assignments(ListBuilder<QueueAcceptEntry>? assignments) =>
      _$this._assignments = assignments;

  QueueAcceptRequestBuilder() {
    QueueAcceptRequest._defaults(this);
  }

  QueueAcceptRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _assignments = $v.assignments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueueAcceptRequest other) {
    _$v = other as _$QueueAcceptRequest;
  }

  @override
  void update(void Function(QueueAcceptRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueueAcceptRequest build() => _build();

  _$QueueAcceptRequest _build() {
    _$QueueAcceptRequest _$result;
    try {
      _$result = _$v ??
          _$QueueAcceptRequest._(
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'QueueAcceptRequest', 'version'),
            assignments: assignments.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assignments';
        assignments.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'QueueAcceptRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
