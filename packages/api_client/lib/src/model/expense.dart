//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/date.dart';
import 'package:novalab_api/src/model/finance_category.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'expense.g.dart';

/// Expense
///
/// Properties:
/// * [id]
/// * [date]
/// * [category]
/// * [amount]
/// * [createdAt]
/// * [orderId]
/// * [orderFolio]
@BuiltValue()
abstract class Expense implements Built<Expense, ExpenseBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'date')
  Date get date;

  @BuiltValueField(wireName: r'category')
  FinanceCategory get category;
  // enum categoryEnum {  luz,  empaque,  envio,  comisiones,  mantenimiento,  otro,  };

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'order_id')
  int? get orderId;

  @BuiltValueField(wireName: r'order_folio')
  String? get orderFolio;

  Expense._();

  factory Expense([void updates(ExpenseBuilder b)]) = _$Expense;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExpenseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Expense> get serializer => _$ExpenseSerializer();
}

class _$ExpenseSerializer implements PrimitiveSerializer<Expense> {
  @override
  final Iterable<Type> types = const [Expense, _$Expense];

  @override
  final String wireName = r'Expense';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Expense object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(Date),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(FinanceCategory),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.orderId != null) {
      yield r'order_id';
      yield serializers.serialize(
        object.orderId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.orderFolio != null) {
      yield r'order_folio';
      yield serializers.serialize(
        object.orderFolio,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Expense object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExpenseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.date = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinanceCategory),
          ) as FinanceCategory;
          result.category = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.orderId = valueDes;
          break;
        case r'order_folio':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderFolio = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Expense deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExpenseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
