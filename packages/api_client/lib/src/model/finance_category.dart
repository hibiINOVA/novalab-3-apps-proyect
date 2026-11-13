//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_category.g.dart';

class FinanceCategory extends EnumClass {
  @BuiltValueEnumConst(wireName: r'luz')
  static const FinanceCategory luz = _$luz;
  @BuiltValueEnumConst(wireName: r'empaque')
  static const FinanceCategory empaque = _$empaque;
  @BuiltValueEnumConst(wireName: r'envio')
  static const FinanceCategory envio = _$envio;
  @BuiltValueEnumConst(wireName: r'comisiones')
  static const FinanceCategory comisiones = _$comisiones;
  @BuiltValueEnumConst(wireName: r'mantenimiento')
  static const FinanceCategory mantenimiento = _$mantenimiento;
  @BuiltValueEnumConst(wireName: r'otro')
  static const FinanceCategory otro = _$otro;

  static Serializer<FinanceCategory> get serializer =>
      _$financeCategorySerializer;

  const FinanceCategory._(String name) : super(name);

  static BuiltSet<FinanceCategory> get values => _$values;
  static FinanceCategory valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FinanceCategoryMixin = Object with _$FinanceCategoryMixin;
