import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novalab_api/novalab_api.dart';
import 'package:produccion/core/api/mock/mock_backend.dart';
import 'package:produccion/features/auth/auth_providers.dart';
import 'package:produccion/features/auth/auth_state.dart';
import 'package:produccion/features/auth/data/auth_token_store.dart';

void main() {
  test('signIn persiste la sesión', () async {
    final store = InMemoryAuthTokenStore();
    final container = ProviderContainer(
      overrides: [authTokenStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);

    final ok = await container
        .read(authControllerProvider.notifier)
        .signIn(email: kMockOwnerEmail, password: kMockPassword);

    expect(ok, isTrue);
    expect(container.read(authControllerProvider).isAuthenticated, isTrue);

    final saved = await store.read();
    expect(saved?.accessToken, isNotEmpty);
    expect(saved?.user?.role, Role.owner);
  });

  test('una sesión guardada se restaura al reiniciar', () async {
    final store = InMemoryAuthTokenStore();

    final firstRun = ProviderContainer(
      overrides: [authTokenStoreProvider.overrideWithValue(store)],
    );
    addTearDown(firstRun.dispose);
    await firstRun
        .read(authControllerProvider.notifier)
        .signIn(email: kMockOwnerEmail, password: kMockPassword);

    final restored = await store.read();
    final secondRun = ProviderContainer(
      overrides: [
        authTokenStoreProvider.overrideWithValue(store),
        initialAuthStateProvider.overrideWithValue(
          restored ?? const AuthState(),
        ),
      ],
    );
    addTearDown(secondRun.dispose);

    expect(secondRun.read(authControllerProvider).isAuthenticated, isTrue);
  });

  test('signOut limpia la sesión persistida', () async {
    final store = InMemoryAuthTokenStore();
    final container = ProviderContainer(
      overrides: [authTokenStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);

    await container
        .read(authControllerProvider.notifier)
        .signIn(email: kMockOwnerEmail, password: kMockPassword);
    container.read(authControllerProvider.notifier).signOut();

    expect(container.read(authControllerProvider).isAuthenticated, isFalse);
    await Future<void>.delayed(Duration.zero);
    expect(await store.read(), isNull);
  });
}
