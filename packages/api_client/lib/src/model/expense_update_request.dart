//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/date.dart';
import 'package:novalab_api/src/model/finance_category.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'expense_update_request.g.dart';

/// ExpenseUpdateRequest
///
/// Properties:
/// * [date]
/// * [category]
/// * [amount]
/// * [orderId]
@BuiltValue()
abstract class ExpenseUpdateRequest
    implements Built<ExpenseUpdateRequest, ExpenseUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'date')
  Date? get date;

  @BuiltValueField(wireName: r'category')
  FinanceCategory? get category;
  // enum categoryEnum {  luz,  empaque,  envio,  comisiones,  mantenimiento,  otro,  };

  @BuiltValueField(wireName: r'amount')
  num? get amount;

  @BuiltValueField(wireName: r'order_id')
  int? get orderId;

  ExpenseUpdateRequest._();

  factory ExpenseUpdateRequest([void updates(ExpenseUpdateRequestBuilder b)]) =
      _$ExpenseUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExpenseUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExpenseUpdateRequest> get serializer =>
      _$ExpenseUpdateRequestSerializer();
}

class _$ExpenseUpdateRequestSerializer
    implements PrimitiveSerializer<ExpenseUpdateRequest> {
  @override
  final Iterable<Type> types = const [
    ExpenseUpdateRequest,
    _$ExpenseUpdateRequest
  ];

  @override
  final String wireName = r'ExpenseUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExpenseUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(Date),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(FinanceCategory),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(num),
      );
    }
    if (object.orderId != null) {
      yield r'order_id';
      yield serializers.serialize(
        object.orderId,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExpenseUpdateRequest object, {
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
    required ExpenseUpdateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.orderId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExpenseUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExpenseUpdateRequestBuilder();
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
