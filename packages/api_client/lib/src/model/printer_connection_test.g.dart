// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_connection_test.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrinterConnectionTest extends PrinterConnectionTest {
  @override
  final bool ok;
  @override
  final String message;
  @override
  final String? version;

  factory _$PrinterConnectionTest(
          [void Function(PrinterConnectionTestBuilder)? updates]) =>
      (PrinterConnectionTestBuilder()..update(updates))._build();

  _$PrinterConnectionTest._(
      {required this.ok, required this.message, this.version})
      : super._();
  @override
  PrinterConnectionTest rebuild(
          void Function(PrinterConnectionTestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrinterConnectionTestBuilder toBuilder() =>
      PrinterConnectionTestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrinterConnectionTest &&
        ok == other.ok &&
        message == other.message &&
        version == other.version;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ok.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrinterConnectionTest')
          ..add('ok', ok)
          ..add('message', message)
          ..add('version', version))
        .toString();
  }
}

class PrinterConnectionTestBuilder
    implements Builder<PrinterConnectionTest, PrinterConnectionTestBuilder> {
  _$PrinterConnectionTest? _$v;

  bool? _ok;
  bool? get ok => _$this._ok;
  set ok(bool? ok) => _$this._ok = ok;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  PrinterConnectionTestBuilder() {
    PrinterConnectionTest._defaults(this);
  }

  PrinterConnectionTestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ok = $v.ok;
      _message = $v.message;
      _version = $v.version;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrinterConnectionTest other) {
    _$v = other as _$PrinterConnectionTest;
  }

  @override
  void update(void Function(PrinterConnectionTestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrinterConnectionTest build() => _build();

  _$PrinterConnectionTest _build() {
    final _$result = _$v ??
        _$PrinterConnectionTest._(
          ok: BuiltValueNullFieldError.checkNotNull(
              ok, r'PrinterConnectionTest', 'ok'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'PrinterConnectionTest', 'message'),
          version: version,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
