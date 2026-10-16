import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/branding/branding_provider.dart';
import 'core/i18n/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Raíz de la app. Toma el tema de la marca del negocio y configura `es-MX`.
class NovalabApp extends ConsumerWidget {
  const NovalabApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branding = ref.watch(brandingProvider).value ?? defaultBranding();
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.fromBranding(branding),
      locale: const Locale('es', 'MX'),
      supportedLocales: const <Locale>[
        Locale('es', 'MX'),
        Locale('es'),
        Locale('en'),
      ],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
