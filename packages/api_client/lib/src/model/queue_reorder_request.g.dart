// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_reorder_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueueReorderRequest extends QueueReorderRequest {
  @override
  final int version;
  @override
  final BuiltList<QueueReorderEntry> items;

  factory _$QueueReorderRequest(
          [void Function(QueueReorderRequestBuilder)? updates]) =>
      (QueueReorderRequestBuilder()..update(updates))._build();

  _$QueueReorderRequest._({required this.version, required this.items})
      : super._();
  @override
  QueueReorderRequest rebuild(
          void Function(QueueReorderRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueueReorderRequestBuilder toBuilder() =>
      QueueReorderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueueReorderRequest &&
        version == other.version &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueueReorderRequest')
          ..add('version', version)
          ..add('items', items))
        .toString();
  }
}

class QueueReorderRequestBuilder
    implements Builder<QueueReorderRequest, QueueReorderRequestBuilder> {
  _$QueueReorderRequest? _$v;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  ListBuilder<QueueReorderEntry>? _items;
  ListBuilder<QueueReorderEntry> get items =>
      _$this._items ??= ListBuilder<QueueReorderEntry>();
  set items(ListBuilder<QueueReorderEntry>? items) => _$this._items = items;

  QueueReorderRequestBuilder() {
    QueueReorderRequest._defaults(this);
  }

  QueueReorderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueueReorderRequest other) {
    _$v = other as _$QueueReorderRequest;
  }

  @override
  void update(void Function(QueueReorderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueueReorderRequest build() => _build();

  _$QueueReorderRequest _build() {
    _$QueueReorderRequest _$result;
    try {
      _$result = _$v ??
          _$QueueReorderRequest._(
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'QueueReorderRequest', 'version'),
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'QueueReorderRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
