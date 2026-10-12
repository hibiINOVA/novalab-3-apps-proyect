// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DueState _$none = const DueState._('none');
const DueState _$ok = const DueState._('ok');
const DueState _$dueSoon = const DueState._('dueSoon');
const DueState _$overdue = const DueState._('overdue');

DueState _$valueOf(String name) {
  switch (name) {
    case 'none':
      return _$none;
    case 'ok':
      return _$ok;
    case 'dueSoon':
      return _$dueSoon;
    case 'overdue':
      return _$overdue;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DueState> _$values = BuiltSet<DueState>(const <DueState>[
  _$none,
  _$ok,
  _$dueSoon,
  _$overdue,
]);

class _$DueStateMeta {
  const _$DueStateMeta();
  DueState get none => _$none;
  DueState get ok => _$ok;
  DueState get dueSoon => _$dueSoon;
  DueState get overdue => _$overdue;
  DueState valueOf(String name) => _$valueOf(name);
  BuiltSet<DueState> get values => _$values;
}

abstract class _$DueStateMixin {
  // ignore: non_constant_identifier_names
  _$DueStateMeta get DueState => const _$DueStateMeta();
}

Serializer<DueState> _$dueStateSerializer = _$DueStateSerializer();

class _$DueStateSerializer implements PrimitiveSerializer<DueState> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'none': 'none',
    'ok': 'ok',
    'dueSoon': 'due_soon',
    'overdue': 'overdue',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'none': 'none',
    'ok': 'ok',
    'due_soon': 'dueSoon',
    'overdue': 'overdue',
  };

  @override
  final Iterable<Type> types = const <Type>[DueState];
  @override
  final String wireName = 'DueState';

  @override
  Object serialize(Serializers serializers, DueState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DueState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DueState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
