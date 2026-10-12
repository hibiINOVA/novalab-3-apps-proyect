// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branding.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Branding extends Branding {
  @override
  final String businessName;
  @override
  final String primaryColor;
  @override
  final String accentColor;
  @override
  final String backgroundColor;
  @override
  final String currency;
  @override
  final String timezone;
  @override
  final String language;
  @override
  final String? logoUrl;

  factory _$Branding([void Function(BrandingBuilder)? updates]) =>
      (BrandingBuilder()..update(updates))._build();

  _$Branding._(
      {required this.businessName,
      required this.primaryColor,
      required this.accentColor,
      required this.backgroundColor,
      required this.currency,
      required this.timezone,
      required this.language,
      this.logoUrl})
      : super._();
  @override
  Branding rebuild(void Function(BrandingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrandingBuilder toBuilder() => BrandingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Branding &&
        businessName == other.businessName &&
        primaryColor == other.primaryColor &&
        accentColor == other.accentColor &&
        backgroundColor == other.backgroundColor &&
        currency == other.currency &&
        timezone == other.timezone &&
        language == other.language &&
        logoUrl == other.logoUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, businessName.hashCode);
    _$hash = $jc(_$hash, primaryColor.hashCode);
    _$hash = $jc(_$hash, accentColor.hashCode);
    _$hash = $jc(_$hash, backgroundColor.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, timezone.hashCode);
    _$hash = $jc(_$hash, language.hashCode);
    _$hash = $jc(_$hash, logoUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Branding')
          ..add('businessName', businessName)
          ..add('primaryColor', primaryColor)
          ..add('accentColor', accentColor)
          ..add('backgroundColor', backgroundColor)
          ..add('currency', currency)
          ..add('timezone', timezone)
          ..add('language', language)
          ..add('logoUrl', logoUrl))
        .toString();
  }
}

class BrandingBuilder implements Builder<Branding, BrandingBuilder> {
  _$Branding? _$v;

  String? _businessName;
  String? get businessName => _$this._businessName;
  set businessName(String? businessName) => _$this._businessName = businessName;

  String? _primaryColor;
  String? get primaryColor => _$this._primaryColor;
  set primaryColor(String? primaryColor) => _$this._primaryColor = primaryColor;

  String? _accentColor;
  String? get accentColor => _$this._accentColor;
  set accentColor(String? accentColor) => _$this._accentColor = accentColor;

  String? _backgroundColor;
  String? get backgroundColor => _$this._backgroundColor;
  set backgroundColor(String? backgroundColor) =>
      _$this._backgroundColor = backgroundColor;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _timezone;
  String? get timezone => _$this._timezone;
  set timezone(String? timezone) => _$this._timezone = timezone;

  String? _language;
  String? get language => _$this._language;
  set language(String? language) => _$this._language = language;

  String? _logoUrl;
  String? get logoUrl => _$this._logoUrl;
  set logoUrl(String? logoUrl) => _$this._logoUrl = logoUrl;

  BrandingBuilder() {
    Branding._defaults(this);
  }

  BrandingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _businessName = $v.businessName;
      _primaryColor = $v.primaryColor;
      _accentColor = $v.accentColor;
      _backgroundColor = $v.backgroundColor;
      _currency = $v.currency;
      _timezone = $v.timezone;
      _language = $v.language;
      _logoUrl = $v.logoUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Branding other) {
    _$v = other as _$Branding;
  }

  @override
  void update(void Function(BrandingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Branding build() => _build();

  _$Branding _build() {
    final _$result = _$v ??
        _$Branding._(
          businessName: BuiltValueNullFieldError.checkNotNull(
              businessName, r'Branding', 'businessName'),
          primaryColor: BuiltValueNullFieldError.checkNotNull(
              primaryColor, r'Branding', 'primaryColor'),
          accentColor: BuiltValueNullFieldError.checkNotNull(
              accentColor, r'Branding', 'accentColor'),
          backgroundColor: BuiltValueNullFieldError.checkNotNull(
              backgroundColor, r'Branding', 'backgroundColor'),
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'Branding', 'currency'),
          timezone: BuiltValueNullFieldError.checkNotNull(
              timezone, r'Branding', 'timezone'),
          language: BuiltValueNullFieldError.checkNotNull(
              language, r'Branding', 'language'),
          logoUrl: logoUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
