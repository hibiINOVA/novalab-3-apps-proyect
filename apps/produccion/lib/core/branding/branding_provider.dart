import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../config/app_providers.dart';
import '../theme/design_tokens.dart';

/// Marca por defecto (instancia NOVALAB) si el negocio no ha configurado una.
Branding defaultBranding() => Branding(
  (b) => b
    ..businessName = 'NOVALAB'
    ..primaryColor = '#0B132B'
    ..accentColor = '#00FF87'
    ..backgroundColor = '#FFFFFF'
    ..currency = 'MXN'
    ..timezone = 'America/Mexico_City'
    ..language = 'es-MX',
);

/// Marca y configuración visible del negocio (`GET /api/public/branding`).
///
/// Nunca lanza: si el endpoint falla, la app usa [defaultBranding] para no
/// quedar sin tema.
final brandingProvider = FutureProvider<Branding>((ref) async {
  final api = ref.watch(novalabApiProvider);
  try {
    final response = await api.getPublicApi().getBranding();
    final branding = response.data;
    if (branding == null) return defaultBranding();
    // El acento debe tener un color válido para el tema.
    colorFromHex(branding.accentColor, fallback: DesignTokens.neonGreen);
    return branding;
  } catch (_) {
    return defaultBranding();
  }
});
