//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_failure.g.dart';

/// FinanceFailure
///
/// Properties:
/// * [month]
/// * [failedJobsCount]
/// * [gramsLost]
/// * [moneyLost] - material + luz de los jobs fallidos (§3.8)
@BuiltValue()
abstract class FinanceFailure
    implements Built<FinanceFailure, FinanceFailureBuilder> {
  @BuiltValueField(wireName: r'month')
  String get month;

  @BuiltValueField(wireName: r'failed_jobs_count')
  int get failedJobsCount;

  @BuiltValueField(wireName: r'grams_lost')
  num get gramsLost;

  /// material + luz de los jobs fallidos (§3.8)
  @BuiltValueField(wireName: r'money_lost')
  num get moneyLost;

  FinanceFailure._();

  factory FinanceFailure([void updates(FinanceFailureBuilder b)]) =
      _$FinanceFailure;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceFailureBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceFailure> get serializer =>
      _$FinanceFailureSerializer();
}

class _$FinanceFailureSerializer
    implements PrimitiveSerializer<FinanceFailure> {
  @override
  final Iterable<Type> types = const [FinanceFailure, _$FinanceFailure];

  @override
  final String wireName = r'FinanceFailure';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceFailure object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'failed_jobs_count';
    yield serializers.serialize(
      object.failedJobsCount,
      specifiedType: const FullType(int),
    );
    yield r'grams_lost';
    yield serializers.serialize(
      object.gramsLost,
      specifiedType: const FullType(num),
    );
    yield r'money_lost';
    yield serializers.serialize(
      object.moneyLost,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceFailure object, {
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
    required FinanceFailureBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.month = valueDes;
          break;
        case r'failed_jobs_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.failedJobsCount = valueDes;
          break;
        case r'grams_lost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.gramsLost = valueDes;
          break;
        case r'money_lost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.moneyLost = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceFailure deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceFailureBuilder();
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
