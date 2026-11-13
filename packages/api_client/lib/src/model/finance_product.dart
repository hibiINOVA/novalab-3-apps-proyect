//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_product.g.dart';

/// FinanceProduct
///
/// Properties:
/// * [productId]
/// * [productName]
/// * [ordersCount]
/// * [income]
/// * [costs]
/// * [profit]
/// * [margin]
@BuiltValue()
abstract class FinanceProduct
    implements Built<FinanceProduct, FinanceProductBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int get productId;

  @BuiltValueField(wireName: r'product_name')
  String get productName;

  @BuiltValueField(wireName: r'orders_count')
  int get ordersCount;

  @BuiltValueField(wireName: r'income')
  num get income;

  @BuiltValueField(wireName: r'costs')
  num get costs;

  @BuiltValueField(wireName: r'profit')
  num get profit;

  @BuiltValueField(wireName: r'margin')
  num get margin;

  FinanceProduct._();

  factory FinanceProduct([void updates(FinanceProductBuilder b)]) =
      _$FinanceProduct;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceProductBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceProduct> get serializer =>
      _$FinanceProductSerializer();
}

class _$FinanceProductSerializer
    implements PrimitiveSerializer<FinanceProduct> {
  @override
  final Iterable<Type> types = const [FinanceProduct, _$FinanceProduct];

  @override
  final String wireName = r'FinanceProduct';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceProduct object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(int),
    );
    yield r'product_name';
    yield serializers.serialize(
      object.productName,
      specifiedType: const FullType(String),
    );
    yield r'orders_count';
    yield serializers.serialize(
      object.ordersCount,
      specifiedType: const FullType(int),
    );
    yield r'income';
    yield serializers.serialize(
      object.income,
      specifiedType: const FullType(num),
    );
    yield r'costs';
    yield serializers.serialize(
      object.costs,
      specifiedType: const FullType(num),
    );
    yield r'profit';
    yield serializers.serialize(
      object.profit,
      specifiedType: const FullType(num),
    );
    yield r'margin';
    yield serializers.serialize(
      object.margin,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceProduct object, {
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
    required FinanceProductBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
          break;
        case r'product_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productName = valueDes;
          break;
        case r'orders_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ordersCount = valueDes;
          break;
        case r'income':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.income = valueDes;
          break;
        case r'costs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.costs = valueDes;
          break;
        case r'profit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.profit = valueDes;
          break;
        case r'margin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.margin = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceProduct deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceProductBuilder();
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
