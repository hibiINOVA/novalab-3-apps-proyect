// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ItemState _$pending = const ItemState._('pending');
const ItemState _$queued = const ItemState._('queued');
const ItemState _$printing = const ItemState._('printing');
const ItemState _$printed = const ItemState._('printed');
const ItemState _$failed = const ItemState._('failed');

ItemState _$valueOf(String name) {
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

final BuiltSet<ItemState> _$values = BuiltSet<ItemState>(const <ItemState>[
  _$pending,
  _$queued,
  _$printing,
  _$printed,
  _$failed,
]);

class _$ItemStateMeta {
  const _$ItemStateMeta();
  ItemState get pending => _$pending;
  ItemState get queued => _$queued;
  ItemState get printing => _$printing;
  ItemState get printed => _$printed;
  ItemState get failed => _$failed;
  ItemState valueOf(String name) => _$valueOf(name);
  BuiltSet<ItemState> get values => _$values;
}

abstract class _$ItemStateMixin {
  // ignore: non_constant_identifier_names
  _$ItemStateMeta get ItemState => const _$ItemStateMeta();
}

Serializer<ItemState> _$itemStateSerializer = _$ItemStateSerializer();

class _$ItemStateSerializer implements PrimitiveSerializer<ItemState> {
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
  final Iterable<Type> types = const <Type>[ItemState];
  @override
  final String wireName = 'ItemState';

  @override
  Object serialize(Serializers serializers, ItemState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ItemState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ItemState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
