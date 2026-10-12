// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_item_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const QueueItemState _$pending = const QueueItemState._('pending');
const QueueItemState _$queued = const QueueItemState._('queued');
const QueueItemState _$printing = const QueueItemState._('printing');
const QueueItemState _$printed = const QueueItemState._('printed');
const QueueItemState _$failed = const QueueItemState._('failed');

QueueItemState _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'queued':
      return _$queued;
    case 'printing':
      return _$printing;
    case 'printed':
      return _$printed;
    case 'failed':
      return _$failed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<QueueItemState> _$values =
    BuiltSet<QueueItemState>(const <QueueItemState>[
  _$pending,
  _$queued,
  _$printing,
  _$printed,
  _$failed,
]);

class _$QueueItemStateMeta {
  const _$QueueItemStateMeta();
  QueueItemState get pending => _$pending;
  QueueItemState get queued => _$queued;
  QueueItemState get printing => _$printing;
  QueueItemState get printed => _$printed;
  QueueItemState get failed => _$failed;
  QueueItemState valueOf(String name) => _$valueOf(name);
  BuiltSet<QueueItemState> get values => _$values;
}

abstract class _$QueueItemStateMixin {
  // ignore: non_constant_identifier_names
  _$QueueItemStateMeta get QueueItemState => const _$QueueItemStateMeta();
}

Serializer<QueueItemState> _$queueItemStateSerializer =
    _$QueueItemStateSerializer();

class _$QueueItemStateSerializer
    implements PrimitiveSerializer<QueueItemState> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'queued': 'queued',
    'printing': 'printing',
    'printed': 'printed',
    'failed': 'failed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'queued': 'queued',
    'printing': 'printing',
    'printed': 'printed',
    'failed': 'failed',
  };

  @override
  final Iterable<Type> types = const <Type>[QueueItemState];
  @override
  final String wireName = 'QueueItemState';

  @override
  Object serialize(Serializers serializers, QueueItemState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  QueueItemState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      QueueItemState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
