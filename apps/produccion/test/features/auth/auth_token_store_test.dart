import 'package:flutter_test/flutter_test.dart';
import 'package:novalab_api/novalab_api.dart';
import 'package:produccion/features/auth/auth_state.dart';
import 'package:produccion/features/auth/data/auth_token_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('sin datos guardados no hay sesión', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final store = SharedPreferencesAuthTokenStore(
      await SharedPreferences.getInstance(),
    );
    expect(await store.read(), isNull);
  });

  test('guarda y recupera la sesión, y la borra al cerrar', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final store = SharedPreferencesAuthTokenStore(
      await SharedPreferences.getInstance(),
    );

    final user = User(
      (b) => b
        ..id = 1
        ..name = 'Dueño Demo'
        ..email = 'dueno@novalab.mx'
        ..role = Role.owner,
    );
    await store.save(
      AuthState(
        status: AuthStatus.authenticated,
        accessToken: 'token-a',
        refreshToken: 'token-r',
        user: user,
      ),
    );

    final read = await store.read();
    expect(read, isNotNull);
    expect(read!.isAuthenticated, isTrue);
    expect(read.accessToken, 'token-a');
    expect(read.refreshToken, 'token-r');
    expect(read.user?.email, 'dueno@novalab.mx');
    expect(read.user?.role, Role.owner);

    await store.clear();
    expect(await store.read(), isNull);
  });
}
