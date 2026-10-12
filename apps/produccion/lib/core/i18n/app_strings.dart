/// Catálogo de cadenas en `es-MX` (doc §7: textos externalizados).
///
/// Mantener aquí todo texto visible para facilitar la traducción futura. No
/// escribir literales de UI dentro de los widgets.
abstract final class AppStrings {
  static const String appTitle = 'NOVALAB';
  static const String appSubtitle = 'Panel de producción';

  // Autenticación (P-01)
  static const String loginTitle = 'Inicia sesión';
  static const String loginEmail = 'Correo';
  static const String loginPassword = 'Contraseña';
  static const String loginSubmit = 'Entrar';
  static const String loginInvalidEmail = 'Escribe un correo válido';
  static const String loginRequiredField = 'Campo obligatorio';
  static const String loginGenericError =
      'No se pudo iniciar sesión. Intenta de nuevo.';
  static const String loginTooManyAttempts =
      'Demasiados intentos. Espera un momento.';
  static const String loginShowPassword = 'Mostrar contraseña';
  static const String loginHidePassword = 'Ocultar contraseña';
  static const String logout = 'Cerrar sesión';

  // Navegación
  static const String navPrinters = 'Impresoras';
  static const String navQueue = 'Cola';

  // Tablero (P-02)
  static const String dashboardTitle = 'Tablero de impresoras';
  static const String printerStateIdle = 'En reposo';
  static const String printerStatePrinting = 'Imprimiendo';
  static const String printerStatePaused = 'Pausada';
  static const String printerStateOffline = 'Sin conexión';
  static const String printerStateError = 'Error';
  static const String printerDisconnectedHint =
      'Esta impresora no responde. El resto del tablero sigue disponible.';
  static const String printerNoSpool = 'Sin filamento cargado';
  static const String printerNoOrder = 'Sin pedido';
  static const String printerCameraUnavailable = 'Cámara no disponible';
  static const String printerRemaining = 'Restante';
  static const String printersTitle = 'Impresoras';
  static const String printersEmpty = 'Aún no hay impresoras registradas.';
  static const String printersLoadError =
      'No se pudieron cargar las impresoras.';
  static const String printerLive = 'En vivo';
  static const String printerConnecting = 'Conectando…';
  static const String printerNoConnection = 'Sin conexión en vivo';
  static const String printerNozzle = 'Boquilla';
  static const String printerBed = 'Cama';
  static const String printerSpool = 'Filamento';
  static const String printerOrder = 'Pedido';
  static const String printerGramsRemaining = 'g restantes';
  static const String printerFile = 'Archivo';

  // Cola (P-03)
  static const String queueTitle = 'Cola de producción';
  static const String queueUnassigned = 'Sin asignar';
  static const String queueEmptyColumn = 'Sin piezas';
  static const String queueReorderError =
      'No se pudo guardar el orden. Intenta de nuevo.';

  // Generales
  static const String retry = 'Reintentar';
  static const String loading = 'Cargando…';
  static const String comingSoon = 'Próximamente';
}
