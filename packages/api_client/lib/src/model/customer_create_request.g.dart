// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CustomerCreateRequest extends CustomerCreateRequest {
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? notes;

  factory _$CustomerCreateRequest(
          [void Function(CustomerCreateRequestBuilder)? updates]) =>
      (CustomerCreateRequestBuilder()..update(updates))._build();

  _$CustomerCreateRequest._(
      {required this.name, this.phone, this.email, this.notes})
      : super._();
  @override
  CustomerCreateRequest rebuild(
          void Function(CustomerCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CustomerCreateRequestBuilder toBuilder() =>
      CustomerCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomerCreateRequest &&
        name == other.name &&
        phone == other.phone &&
        email == other.email &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CustomerCreateRequest')
          ..add('name', name)
          ..add('phone', phone)
          ..add('email', email)
          ..add('notes', notes))
        .toString();
  }
}

class CustomerCreateRequestBuilder
    implements Builder<CustomerCreateRequest, CustomerCreateRequestBuilder> {
  _$CustomerCreateRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  CustomerCreateRequestBuilder() {
    CustomerCreateRequest._defaults(this);
  }

  CustomerCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _phone = $v.phone;
      _email = $v.email;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CustomerCreateRequest other) {
    _$v = other as _$CustomerCreateRequest;
  }

  @override
  void update(void Function(CustomerCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CustomerCreateRequest build() => _build();

  _$CustomerCreateRequest _build() {
    final _$result = _$v ??
        _$CustomerCreateRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CustomerCreateRequest', 'name'),
          phone: phone,
          email: email,
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
