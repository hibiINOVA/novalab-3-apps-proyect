//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_create_request.g.dart';

/// ProductCreateRequest
///
/// Properties:
/// * [name]
/// * [material]
/// * [color]
/// * [estimatedWeightG]
/// * [estimatedMinutes]
/// * [extraCost]
/// * [hasGcode]
/// * [basePrice]
@BuiltValue()
abstract class ProductCreateRequest
    implements Built<ProductCreateRequest, ProductCreateRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'material')
  String? get material;

  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'estimated_weight_g')
  double? get estimatedWeightG;

  @BuiltValueField(wireName: r'estimated_minutes')
  int? get estimatedMinutes;

  @BuiltValueField(wireName: r'extra_cost')
  double? get extraCost;

  @BuiltValueField(wireName: r'has_gcode')
  bool? get hasGcode;

  @BuiltValueField(wireName: r'base_price')
  double? get basePrice;

  ProductCreateRequest._();

  factory ProductCreateRequest([void updates(ProductCreateRequestBuilder b)]) =
      _$ProductCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductCreateRequestBuilder b) => b
    ..hasGcode = false
    ..basePrice = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductCreateRequest> get serializer =>
      _$ProductCreateRequestSerializer();
}

class _$ProductCreateRequestSerializer
    implements PrimitiveSerializer<ProductCreateRequest> {
  @override
  final Iterable<Type> types = const [
    ProductCreateRequest,
    _$ProductCreateRequest
  ];

  @override
  final String wireName = r'ProductCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.material != null) {
      yield r'material';
      yield serializers.serialize(
        object.material,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.estimatedWeightG != null) {
      yield r'estimated_weight_g';
      yield serializers.serialize(
        object.estimatedWeightG,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.estimatedMinutes != null) {
      yield r'estimated_minutes';
      yield serializers.serialize(
        object.estimatedMinutes,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.extraCost != null) {
      yield r'extra_cost';
      yield serializers.serialize(
        object.extraCost,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.hasGcode != null) {
      yield r'has_gcode';
      yield serializers.serialize(
        object.hasGcode,
        specifiedType: const FullType(bool),
      );
    }
    if (object.basePrice != null) {
      yield r'base_price';
      yield serializers.serialize(
        object.basePrice,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductCreateRequest object, {
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
    required ProductCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'material':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.material = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.color = valueDes;
          break;
        case r'estimated_weight_g':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.estimatedWeightG = valueDes;
          break;
        case r'estimated_minutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.estimatedMinutes = valueDes;
          break;
        case r'extra_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.extraCost = valueDes;
          break;
        case r'has_gcode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasGcode = valueDes;
          break;
        case r'base_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.basePrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductCreateRequestBuilder();
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
