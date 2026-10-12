//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'branding.g.dart';

/// Branding
///
/// Properties:
/// * [businessName]
/// * [primaryColor] - Color hex, p. ej.
/// * [accentColor] - Color hex, p. ej.
/// * [backgroundColor]
/// * [currency] - Código ISO 4217, p. ej. MXN
/// * [timezone] - Zona IANA, p. ej. America/Mexico_City
/// * [language] - Etiqueta BCP-47, p. ej. es-MX
/// * [logoUrl]
@BuiltValue()
abstract class Branding implements Built<Branding, BrandingBuilder> {
  @BuiltValueField(wireName: r'business_name')
  String get businessName;

  /// Color hex, p. ej.
  @BuiltValueField(wireName: r'primary_color')
  String get primaryColor;

  /// Color hex, p. ej.
  @BuiltValueField(wireName: r'accent_color')
  String get accentColor;

  @BuiltValueField(wireName: r'background_color')
  String get backgroundColor;

  /// Código ISO 4217, p. ej. MXN
  @BuiltValueField(wireName: r'currency')
  String get currency;

  /// Zona IANA, p. ej. America/Mexico_City
  @BuiltValueField(wireName: r'timezone')
  String get timezone;

  /// Etiqueta BCP-47, p. ej. es-MX
  @BuiltValueField(wireName: r'language')
  String get language;

  @BuiltValueField(wireName: r'logo_url')
  String? get logoUrl;

  Branding._();

  factory Branding([void updates(BrandingBuilder b)]) = _$Branding;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BrandingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Branding> get serializer => _$BrandingSerializer();
}

class _$BrandingSerializer implements PrimitiveSerializer<Branding> {
  @override
  final Iterable<Type> types = const [Branding, _$Branding];

  @override
  final String wireName = r'Branding';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Branding object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'business_name';
    yield serializers.serialize(
      object.businessName,
      specifiedType: const FullType(String),
    );
    yield r'primary_color';
    yield serializers.serialize(
      object.primaryColor,
      specifiedType: const FullType(String),
    );
    yield r'accent_color';
    yield serializers.serialize(
      object.accentColor,
      specifiedType: const FullType(String),
    );
    yield r'background_color';
    yield serializers.serialize(
      object.backgroundColor,
      specifiedType: const FullType(String),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(String),
    );
    yield r'timezone';
    yield serializers.serialize(
      object.timezone,
      specifiedType: const FullType(String),
    );
    yield r'language';
    yield serializers.serialize(
      object.language,
      specifiedType: const FullType(String),
    );
    if (object.logoUrl != null) {
      yield r'logo_url';
      yield serializers.serialize(
        object.logoUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Branding object, {
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
    required BrandingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'business_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.businessName = valueDes;
          break;
        case r'primary_color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.primaryColor = valueDes;
          break;
        case r'accent_color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accentColor = valueDes;
          break;
        case r'background_color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.backgroundColor = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
          break;
        case r'timezone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.timezone = valueDes;
          break;
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.language = valueDes;
          break;
        case r'logo_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.logoUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Branding deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BrandingBuilder();
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
