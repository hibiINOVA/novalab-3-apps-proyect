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

  // Organización: identidad (visión/misión/descripción), logo, miembros
  static const String orgDescriptionLabel = 'Descripción';
  static const String orgDescriptionHint = '¿A qué se dedica el taller?';
  static const String orgVisionLabel = 'Visión';
  static const String orgVisionHint = '¿A dónde quiere llegar el negocio?';
  static const String orgMissionLabel = 'Misión';
  static const String orgMissionHint = '¿Cómo lo va a lograr?';
  static const String orgEditTooltip = 'Editar organización';
  static const String orgMembersTooltip = 'Miembros de la organización';
  static const String orgEditTitle = 'Editar organización';
  static const String orgMembersTitle = 'Miembros';
  static const String orgMembersEmpty = 'Aún no hay miembros activos.';
  static const String orgMembersLoadError =
      'No se pudieron cargar los miembros.';
  static const String orgSaved = 'Organización actualizada.';
  static const String orgErrorSave = 'No se pudieron guardar los cambios.';
  static const String orgUploadLogo = 'Subir logo';
  static const String orgRemoveLogo = 'Quitar logo';
  static const String orgLogoUpdated = 'Logo actualizado.';
  static const String orgLogoRemoved = 'Logo eliminado.';
  static const String orgLogoError = 'No se pudo cargar el logo.';
  static const String orgLogoHint = 'PNG, JPG o WebP de máximo 5 MB.';
  static const String orgMemberRoleOwner = 'Dueño';
  static const String orgMemberRoleOperator = 'Operador';
  static const String close = 'Cerrar';

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
  static const String printAttachGcode = 'Adjuntar G-code (opcional)';
  static const String printGcodeAttached = 'G-code seleccionado';
  static const String printGcodeClear = 'Quitar G-code';
  static const String printGcodePickError = 'No se pudo leer el archivo.';
  static const String printGcodeExtError =
      'Formato no válido: usa .gcode, .gco o .g';
  static const String printStartedWithGcode =
      'Impresión iniciada con G-code adjunto.';
  static const String printGcodeUploadError =
      'La impresión inició, pero el G-code no se pudo subir.';

  // Impresoras CRUD
  static const String printerAdd = 'Agregar impresora';
  static const String printerEdit = 'Editar impresora';
  static const String printerDelete = 'Eliminar impresora';
  static const String printerDeleteConfirm =
      '¿Deseas eliminar esta impresora? Las piezas en cola se moverán a sin asignar.';
  static const String printerNameLabel = 'Nombre de la impresora';
  static const String printerNameHint = 'Ej. Ender 3 V3 Plus Eco';
  static const String printerModelLabel = 'Modelo (opcional)';
  static const String printerModelHint =
      'Ej. Prusa MK4, Creality Ender 3 V3, Bambu Lab A1…';
  static const String printerModelHelper =
      'Escribe o elige un modelo conocido.';
  static const String printerOctoprintUrl =
      'URL de OctoPrint / Klipper (opcional)';
  static const String printerApiKey = 'API Key (opcional)';
  static const String printerBedWidth = 'Ancho de cama en mm (opcional)';
  static const String printerBedDepth = 'Profundidad de cama en mm (opcional)';
  static const String printerCameraHas = 'Tiene cámara disponible';
  static const String printerCamerasLabel = 'URLs de cámara (snapshot)';
  static const String printerCamerasHint =
      'Una URL por línea. Ej. http://127.0.0.1:8080/?action=snapshot';
  static const String printerCamerasHelper =
      'La primera es la principal; el backend las consume (BE-07).';
  static const String printerTestConnection = 'Probar conexión';
  static const String printerTestConnectionOk =
      'Conexión exitosa con OctoPrint.';
  static const String printerTestConnectionIdle =
      'Ingresa la URL de OctoPrint para probar la conexión.';
  static const String printerSaved = 'Impresora guardada con éxito.';
  static const String printerDeleted = 'Impresora eliminada.';
  static const String printerErrorSave = 'No se pudo guardar la impresora.';
  static const String printerErrorDelete = 'No se pudo eliminar la impresora.';

  // Pedidos y Clientes (P-09 / CRUD)
  static const String orderNew = 'Nueva impresión / Pedido';
  static const String orderEditStatus = 'Cambiar estado';
  static const String orderCustomer = 'Cliente';
  static const String orderCustomerSearchHint =
      'Ingresa el ID o nombre del cliente';
  static const String orderCustomerFound = 'Cliente encontrado';
  static const String orderCustomerNotFound =
      'Cliente no encontrado por ese ID';
  static const String orderCustomerSearch = 'Buscar cliente por ID';
  static const String orderCustomerCreateNew = 'Crear cliente nuevo';
  static const String orderCustomerName = 'Nombre del cliente';
  static const String orderCustomerPhone = 'Teléfono';
  static const String orderCustomerEmail = 'Correo electrónico';
  static const String orderCustomerNotes = 'Notas del cliente';
  static const String orderPromisedDate = 'Fecha prometida de entrega';
  static const String orderNotes = 'Notas del pedido';
  static const String orderProduct = 'Producto';
  static const String orderQuantity = 'Cantidad';
  static const String orderColor = 'Color / Material';
  static const String orderAddItem = 'Agregar pieza';
  static const String orderRemoveItem = 'Quitar';
  static const String orderTotal = 'Total';
  static const String orderSubmit = 'Mandar a producción';
  static const String orderSuccess = '¡Impresión/pedido mandado con éxito!';
  static const String orderError = 'No se pudo crear el pedido.';
  static const String orderMustHaveItems =
      'Agrega al menos una pieza para imprimir.';

  // Generales
  static const String retry = 'Reintentar';
  static const String loading = 'Cargando…';
  static const String comingSoon = 'Próximamente';
  static const String save = 'Guardar';
  static const String delete = 'Eliminar';
  static const String cancel = 'Cancelar';
  static const String search = 'Buscar';
}
