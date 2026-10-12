import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for AuthApi
void main() {
  final instance = NovalabApi().getAuthApi();

  group(AuthApi, () {
    // Inicia sesión y devuelve tokens JWT
    //
    //Future<LoginResponse> login(LoginRequest loginRequest) async
    test('test login', () async {
      // TODO
    });

    // Renueva el access token
    //
    //Future<LoginResponse> refreshToken(RefreshRequest refreshRequest) async
    test('test refreshToken', () async {
      // TODO
    });
  });
}
