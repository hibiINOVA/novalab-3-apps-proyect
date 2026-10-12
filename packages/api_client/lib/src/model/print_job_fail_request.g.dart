// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_fail_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrintJobFailRequest extends PrintJobFailRequest {
  @override
  final String reason;

  factory _$PrintJobFailRequest(
          [void Function(PrintJobFailRequestBuilder)? updates]) =>
      (PrintJobFailRequestBuilder()..update(updates))._build();

  _$PrintJobFailRequest._({required this.reason}) : super._();
  @override
  PrintJobFailRequest rebuild(
          void Function(PrintJobFailRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrintJobFailRequestBuilder toBuilder() =>
      PrintJobFailRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrintJobFailRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrintJobFailRequest')
          ..add('reason', reason))
        .toString();
  }
}

class PrintJobFailRequestBuilder
    implements Builder<PrintJobFailRequest, PrintJobFailRequestBuilder> {
  _$PrintJobFailRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  PrintJobFailRequestBuilder() {
    PrintJobFailRequest._defaults(this);
  }

  PrintJobFailRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrintJobFailRequest other) {
    _$v = other as _$PrintJobFailRequest;
  }

  @override
  void update(void Function(PrintJobFailRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrintJobFailRequest build() => _build();

  _$PrintJobFailRequest _build() {
    final _$result = _$v ??
        _$PrintJobFailRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'PrintJobFailRequest', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
