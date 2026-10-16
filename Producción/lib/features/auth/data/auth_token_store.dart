import 'dart:convert';

import 'package:novalab_api/novalab_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_state.dart';

/// Almacenamiento de la sesión (P-01: sesión persistente en el dispositivo).
///
/// En web respalda en `localStorage` a través de SharedPreferences. No guarda
/// contraseñas; solo tokens y datos mínimos del usuario.
abstract interface class AuthTokenStore {
  /// Devuelve la sesión guardada, o `null` si no hay o está corrupta.
  Future<AuthState?> read();

  Future<void> save(AuthState state);

  Future<void> clear();
}

class SharedPreferencesAuthTokenStore implements AuthTokenStore {
  SharedPreferencesAuthTokenStore(this._prefs);

  final SharedPreferences _prefs;

  static const String _accessKey = 'auth.access_token';
  static const String _refreshKey = 'auth.refresh_token';
  static const String _userKey = 'auth.user';

  @override
  Future<AuthState?> read() async {
    final accessToken = _prefs.getString(_accessKey);
    final refreshToken = _prefs.getString(_refreshKey);
    if (accessToken == null || accessToken.isEmpty) return null;

    return AuthState(
      status: AuthStatus.authenticated,
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: _decodeUser(_prefs.getString(_userKey)),
    );
  }

  @override
  Future<void> save(AuthState state) async {
    final accessToken = state.accessToken;
    if (accessToken == null || accessToken.isEmpty) return;
    await _prefs.setString(_accessKey, accessToken);
    if (state.refreshToken != null) {
      await _prefs.setString(_refreshKey, state.refreshToken!);
    }
    if (state.user != null) {
      await _prefs.setString(_userKey, _encodeUser(state.user!));
    }
  }

  @override
  Future<void> clear() async {
    await _prefs.remove(_accessKey);
    await _prefs.remove(_refreshKey);
    await _prefs.remove(_userKey);
  }

  String _encodeUser(User user) => jsonEncode(<String, Object?>{
    'id': user.id,
    'name': user.name,
    'email': user.email,
    'role': user.role == Role.owner ? 'owner' : 'operator',
  });

  User? _decodeUser(String? raw) {
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return User(
        (b) => b
          ..id = map['id'] as int
          ..name = map['name'] as String
          ..email = map['email'] as String
          ..role = map['role'] == 'owner' ? Role.owner : Role.operator_,
      );
    } catch (_) {
      return null;
    }
  }
}

/// Implementación en memoria para pruebas.
class InMemoryAuthTokenStore implements AuthTokenStore {
  AuthState? _state;

  @override
  Future<AuthState?> read() async => _state;

  @override
  Future<void> save(AuthState state) async => _state = state;

  @override
  Future<void> clear() async => _state = null;
}
