// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceCategory _$luz = const FinanceCategory._('luz');
const FinanceCategory _$empaque = const FinanceCategory._('empaque');
const FinanceCategory _$envio = const FinanceCategory._('envio');
const FinanceCategory _$comisiones = const FinanceCategory._('comisiones');
const FinanceCategory _$mantenimiento =
    const FinanceCategory._('mantenimiento');
const FinanceCategory _$otro = const FinanceCategory._('otro');

FinanceCategory _$valueOf(String name) {
  switch (name) {
    case 'luz':
      return _$luz;
    case 'empaque':
      return _$empaque;
    case 'envio':
      return _$envio;
    case 'comisiones':
      return _$comisiones;
    case 'mantenimiento':
      return _$mantenimiento;
    case 'otro':
      return _$otro;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceCategory> _$values =
    BuiltSet<FinanceCategory>(const <FinanceCategory>[
  _$luz,
  _$empaque,
  _$envio,
  _$comisiones,
  _$mantenimiento,
  _$otro,
]);

class _$FinanceCategoryMeta {
  const _$FinanceCategoryMeta();
  FinanceCategory get luz => _$luz;
  FinanceCategory get empaque => _$empaque;
  FinanceCategory get envio => _$envio;
  FinanceCategory get comisiones => _$comisiones;
  FinanceCategory get mantenimiento => _$mantenimiento;
  FinanceCategory get otro => _$otro;
  FinanceCategory valueOf(String name) => _$valueOf(name);
  BuiltSet<FinanceCategory> get values => _$values;
}

abstract class _$FinanceCategoryMixin {
  // ignore: non_constant_identifier_names
  _$FinanceCategoryMeta get FinanceCategory => const _$FinanceCategoryMeta();
}

Serializer<FinanceCategory> _$financeCategorySerializer =
    _$FinanceCategorySerializer();

class _$FinanceCategorySerializer
    implements PrimitiveSerializer<FinanceCategory> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'luz': 'luz',
    'empaque': 'empaque',
    'envio': 'envio',
    'comisiones': 'comisiones',
    'mantenimiento': 'mantenimiento',
    'otro': 'otro',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'luz': 'luz',
    'empaque': 'empaque',
    'envio': 'envio',
    'comisiones': 'comisiones',
    'mantenimiento': 'mantenimiento',
    'otro': 'otro',
  };

  @override
  final Iterable<Type> types = const <Type>[FinanceCategory];
  @override
  final String wireName = 'FinanceCategory';

  @override
  Object serialize(Serializers serializers, FinanceCategory object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinanceCategory deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinanceCategory.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
