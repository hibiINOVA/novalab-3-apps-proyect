// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatusEvent extends StatusEvent {
  @override
  final String type;
  @override
  final String entity;
  @override
  final int? entityId;
  @override
  final DateTime occurredAt;
  @override
  final BuiltMap<String, JsonObject?>? payload;

  factory _$StatusEvent([void Function(StatusEventBuilder)? updates]) =>
      (StatusEventBuilder()..update(updates))._build();

  _$StatusEvent._(
      {required this.type,
      required this.entity,
      this.entityId,
      required this.occurredAt,
      this.payload})
      : super._();
  @override
  StatusEvent rebuild(void Function(StatusEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatusEventBuilder toBuilder() => StatusEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatusEvent &&
        type == other.type &&
        entity == other.entity &&
        entityId == other.entityId &&
        occurredAt == other.occurredAt &&
        payload == other.payload;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, entity.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jc(_$hash, payload.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StatusEvent')
          ..add('type', type)
          ..add('entity', entity)
          ..add('entityId', entityId)
          ..add('occurredAt', occurredAt)
          ..add('payload', payload))
        .toString();
  }
}

class StatusEventBuilder implements Builder<StatusEvent, StatusEventBuilder> {
  _$StatusEvent? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _entity;
  String? get entity => _$this._entity;
  set entity(String? entity) => _$this._entity = entity;

  int? _entityId;
  int? get entityId => _$this._entityId;
  set entityId(int? entityId) => _$this._entityId = entityId;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  MapBuilder<String, JsonObject?>? _payload;
  MapBuilder<String, JsonObject?> get payload =>
      _$this._payload ??= MapBuilder<String, JsonObject?>();
  set payload(MapBuilder<String, JsonObject?>? payload) =>
      _$this._payload = payload;

  StatusEventBuilder() {
    StatusEvent._defaults(this);
  }

  StatusEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _entity = $v.entity;
      _entityId = $v.entityId;
      _occurredAt = $v.occurredAt;
      _payload = $v.payload?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatusEvent other) {
    _$v = other as _$StatusEvent;
  }

  @override
  void update(void Function(StatusEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StatusEvent build() => _build();

  _$StatusEvent _build() {
    _$StatusEvent _$result;
    try {
      _$result = _$v ??
          _$StatusEvent._(
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'StatusEvent', 'type'),
            entity: BuiltValueNullFieldError.checkNotNull(
                entity, r'StatusEvent', 'entity'),
            entityId: entityId,
            occurredAt: BuiltValueNullFieldError.checkNotNull(
                occurredAt, r'StatusEvent', 'occurredAt'),
            payload: _payload?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'payload';
        _payload?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StatusEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
