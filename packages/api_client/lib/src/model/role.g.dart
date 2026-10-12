// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Role _$owner = const Role._('owner');
const Role _$operator_ = const Role._('operator_');

Role _$valueOf(String name) {
  switch (name) {
    case 'owner':
      return _$owner;
    case 'operator_':
      return _$operator_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Role> _$values = BuiltSet<Role>(const <Role>[
  _$owner,
  _$operator_,
]);

class _$RoleMeta {
  const _$RoleMeta();
  Role get owner => _$owner;
  Role get operator_ => _$operator_;
  Role valueOf(String name) => _$valueOf(name);
  BuiltSet<Role> get values => _$values;
}

abstract class _$RoleMixin {
  // ignore: non_constant_identifier_names
  _$RoleMeta get Role => const _$RoleMeta();
}

Serializer<Role> _$roleSerializer = _$RoleSerializer();

class _$RoleSerializer implements PrimitiveSerializer<Role> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'owner': 'owner',
    'operator_': 'operator',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'owner': 'owner',
    'operator': 'operator_',
  };

  @override
  final Iterable<Type> types = const <Type>[Role];
  @override
  final String wireName = 'Role';

  @override
  Object serialize(Serializers serializers, Role object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Role deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Role.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
