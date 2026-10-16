import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'features/auth/auth_providers.dart';
import 'features/auth/auth_state.dart';
import 'features/auth/data/auth_token_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final tokenStore = SharedPreferencesAuthTokenStore(preferences);
  final restoredSession = await tokenStore.read();

  runApp(
    ProviderScope(
      overrides: [
        authTokenStoreProvider.overrideWithValue(tokenStore),
        initialAuthStateProvider.overrideWithValue(
          restoredSession ?? const AuthState(),
        ),
      ],
      child: const NovalabApp(),
    ),
  );
}
