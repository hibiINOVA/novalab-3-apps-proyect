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

  // Registro de cuenta (decisión v1: registro abierto)
  static const String registerTitle = 'Crear cuenta';
  static const String registerSubtitle =
      'Regístrate para entrar al panel de producción';
  static const String registerName = 'Nombre';
  static const String registerNameRequired = 'Escribe tu nombre';
  static const String registerPasswordConfirm = 'Confirmar contraseña';
  static const String registerPasswordMismatch = 'Las contraseñas no coinciden';
  static const String registerPasswordTooShort = 'Mínimo 8 caracteres';
  static const String registerRole = 'Rol';
  static const String registerRoleOwner = 'Dueño';
  static const String registerRoleOperator = 'Operador';
  static const String registerSubmit = 'Crear cuenta';
  static const String registerEmailTaken =
      'Ese correo ya está registrado. Inicia sesión.';
  static const String registerGenericError =
      'No se pudo crear la cuenta. Intenta de nuevo.';
  static const String registerSuccess = 'Cuenta creada. ¡Bienvenido!';
  static const String registerGoToLogin = '¿Ya tienes cuenta? Inicia sesión';
  static const String loginGoToRegister = '¿No tienes cuenta? Crea una';

  // Organización (Flujo Dueño / Operador)
  static const String orgCreateTitle = 'Crea tu organización';
  static const String orgCreateSubtitle =
      'Como Dueño, asigna un nombre a tu taller para generar tu ID único.';
  static const String orgNameLabel = 'Nombre de la organización';
  static const String orgNameHint = 'Ej. NOVALAB Impresión 3D';
  static const String orgNameRequired = 'Ingresa el nombre de la organización';
  static const String orgNameTooShort = 'Mínimo 2 caracteres';
  static const String orgCreateSubmit = 'Crear organización';
  static const String orgCreatedSuccess = '¡Organización creada exitosamente!';
  static const String orgIdLabel = 'ID de la organización';
  static const String orgIdCopyHint =
      'Comparte este ID con tus operadores para que se unan:';
  static const String orgCopyId = 'Copiar ID';
  static const String orgCopied = 'ID copiado al portapapeles';
  static const String orgGoToDashboard = 'Ir al panel de producción';

  static const String orgJoinTitle = 'Únete a una organización';
  static const String orgJoinSubtitle =
      'Como Operador, ingresa el ID proporcionado por tu Dueño.';
  static const String orgJoinCodeLabel = 'ID de la organización';
  static const String orgJoinCodeHint = 'Ej. ORG-NOVA-8492';
  static const String orgJoinCodeRequired = 'Ingresa el ID de la organización';
  static const String orgJoinSubmit = 'Enviar solicitud';
  static const String orgJoinSent = 'Solicitud enviada al dueño';

  static const String orgPendingTitle = 'Esperando aprobación';
  static const String orgPendingMessage =
      'Tu solicitud para unirte a la organización fue enviada.\nEl dueño debe aceptarla para darte acceso al panel.';
  static const String orgPendingOrgLabel = 'Organización solicitada';
  static const String orgPendingCheckStatus = 'Comprobar si fui aceptado';
  static const String orgPendingStillWaiting =
      'Aún no ha sido aceptada por el dueño.';
  static const String orgPendingApproved =
      '¡Tu solicitud fue aprobada! Bienvenido.';

  static const String orgRequestsTitle = 'Solicitudes de Operadores';
  static const String orgRequestsEmpty = 'No hay solicitudes pendientes';
  static const String orgRequestsApprove = 'Aceptar';
  static const String orgRequestsReject = 'Rechazar';
  static const String orgRequestApprovedToast = 'Operador aceptado';
  static const String orgRequestRejectedToast = 'Solicitud rechazada';
  static const String orgRequestsTooltip = 'Solicitudes de operadores';

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
  static const String queueLoadError = 'No se pudo cargar la cola.';
  static const String queuePieces = 'piezas';
  static const String queueMissing = 'Faltan';
  static const String queueEstimated = 'min';
  static const String queueDelivery = 'Entrega';
  static const String queueStatePending = 'Pendiente';
  static const String queueStateQueued = 'En cola';
  static const String queueStatePrinted = 'Impreso';
  static const String queueStateFailed = 'Falló';

  // Sugerencia de asignación (P-04)
  static const String queueSuggest = 'Sugerir asignación';
  static const String suggestTitle = 'Propuesta de asignación';
  static const String suggestAcceptAll = 'Aceptar todo';
  static const String suggestAcceptSelected = 'Aceptar seleccionados';
  static const String suggestDiscard = 'Descartar';
  static const String suggestEmpty = 'No hay items pendientes por asignar.';
  static const String suggestError = 'No se pudo generar la propuesta.';
  static const String suggestApplied = 'Asignación aplicada.';
  static const String suggestUnassigned = 'Sin asignar';

  // Impresión (P-05 / P-06)
  static const String printStart = 'Iniciar impresión';
  static const String printStartTitle = 'Iniciar impresión';
  static const String printStartConfirm = '¿Cama libre y filamento correcto?';
  static const String printStartWarning =
      'Esta acción envía el gcode a la impresora y la inicia.';
  static const String printCancel = 'Cancelar';
  static const String printConfirm = 'Sí, iniciar';
  static const String printStartError = 'No se pudo iniciar la impresión.';
  static const String printStarted = 'Impresión iniciada.';
  static const String printComplete = 'Marcar como terminado';
  static const String printFail = 'Marcar como fallido';
  static const String printReprint = 'Reimprimir';
  static const String printFailTitle = 'Motivo de falla';
  static const String printFailReasonHint = 'Describe el motivo de la falla';
  static const String printFailRequired = 'El motivo es obligatorio.';
  static const String printFailed = 'Job marcado como fallido.';
  static const String printCompleted = 'Job marcado como terminado.';
  static const String printReprinted = 'Reimpresión creada.';
  static const String printActionError = 'No se pudo completar la acción.';

  // Generales
  static const String retry = 'Reintentar';
  static const String loading = 'Cargando…';
  static const String comingSoon = 'Próximamente';
}
