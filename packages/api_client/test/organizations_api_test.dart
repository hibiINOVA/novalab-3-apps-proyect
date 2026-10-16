import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for OrganizationsApi
void main() {
  final instance = NovalabApi().getOrganizationsApi();

  group(OrganizationsApi, () {
    // Dueño acepta la solicitud de un operador
    //
    //Future<OrganizationMember> approveOrganizationRequest(int requestId) async
    test('test approveOrganizationRequest', () async {
      // TODO
    });

    // Crea una organización nueva (Dueño) y genera su ID único
    //
    // Crea una organización asociada al usuario autenticado (debe ser Dueño). Devuelve el código único generado (p. ej. ORG-NOVA-8492) para compartir con operadores.
    //
    //Future<Organization> createOrganization(OrganizationCreateRequest organizationCreateRequest) async
    test('test createOrganization', () async {
      // TODO
    });

    // Obtiene el estado actual de la organización y membresía del usuario
    //
    //Future<UserOrganizationStatus> getCurrentOrganization() async
    test('test getCurrentOrganization', () async {
      // TODO
    });

    // Operador solicita unirse a una organización usando su ID
    //
    //Future<UserOrganizationStatus> joinOrganization(JoinOrganizationRequest joinOrganizationRequest) async
    test('test joinOrganization', () async {
      // TODO
    });

    // Lista de solicitudes pendientes de operadores (Dueño)
    //
    //Future<BuiltList<OrganizationMember>> listOrganizationRequests() async
    test('test listOrganizationRequests', () async {
      // TODO
    });

    // Dueño rechaza la solicitud de un operador
    //
    //Future<OrganizationMember> rejectOrganizationRequest(int requestId) async
    test('test rejectOrganizationRequest', () async {
      // TODO
    });
  });
}
