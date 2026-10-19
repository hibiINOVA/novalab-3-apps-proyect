import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../core/config/app_providers.dart';
import '../auth/auth_providers.dart';

/// Estado y controlador de la organización actual del usuario.
final organizationStatusProvider =
    AsyncNotifierProvider<OrganizationStatusNotifier, UserOrganizationStatus>(
      OrganizationStatusNotifier.new,
    );

class OrganizationStatusNotifier extends AsyncNotifier<UserOrganizationStatus> {
  @override
  Future<UserOrganizationStatus> build() async {
    final auth = ref.watch(authControllerProvider);
    if (auth.user == null) {
      return UserOrganizationStatus(
        (b) => b..membershipStatus = MembershipStatus.none,
      );
    }
    return _fetchStatus();
  }

  Future<UserOrganizationStatus> _fetchStatus() async {
    final response = await ref
        .read(novalabApiProvider)
        .getOrganizationsApi()
        .getCurrentOrganization();
    return response.data ??
        UserOrganizationStatus(
          (b) => b..membershipStatus = MembershipStatus.none,
        );
  }

  Future<Organization?> createOrganization(
    String name, {
    String? description,
    String? vision,
    String? mission,
  }) async {
    final response = await ref
        .read(novalabApiProvider)
        .getOrganizationsApi()
        .createOrganization(
          organizationCreateRequest: OrganizationCreateRequest(
            (b) => b
              ..name = name
              ..description = description
              ..vision = vision
              ..mission = mission,
          ),
        );
    final org = response.data;
    if (org != null) {
      ref.invalidateSelf();
      // Refrescar también el usuario en AuthController si aplica
      await ref.read(authControllerProvider.notifier).refreshSessionUser();
    }
    return org;
  }

  /// PATCH /api/organizations (solo dueño). Envía los 4 campos siempre
  /// (vacío → null en el backend) para poder limpiar valores.
  Future<Organization?> updateOrganization({
    required String name,
    String? description,
    String? vision,
    String? mission,
  }) async {
    final response = await ref
        .read(novalabApiProvider)
        .getOrganizationsApi()
        .updateOrganization(
          organizationUpdateRequest: OrganizationUpdateRequest(
            (b) => b
              ..name = name
              ..description = description ?? ''
              ..vision = vision ?? ''
              ..mission = mission ?? '',
          ),
        );
    final org = response.data;
    if (org != null) {
      ref.invalidateSelf();
      ref.invalidate(organizationLogoProvider);
      await ref.read(authControllerProvider.notifier).refreshSessionUser();
    }
    return org;
  }

  /// POST /api/organizations/logo (multipart, solo dueño).
  Future<bool> uploadLogo({
    required Uint8List bytes,
    required String filename,
  }) async {
    try {
      await ref
          .read(novalabApiProvider)
          .getOrganizationsApi()
          .uploadOrganizationLogo(
            file: MultipartFile.fromBytes(bytes, filename: filename),
          );
      ref.invalidateSelf();
      ref.invalidate(organizationLogoProvider);
      await ref.read(authControllerProvider.notifier).refreshSessionUser();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// DELETE /api/organizations/logo (solo dueño).
  Future<bool> deleteLogo() async {
    try {
      await ref
          .read(novalabApiProvider)
          .getOrganizationsApi()
          .deleteOrganizationLogo();
      ref.invalidateSelf();
      ref.invalidate(organizationLogoProvider);
      await ref.read(authControllerProvider.notifier).refreshSessionUser();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> joinOrganization(String code) async {
    try {
      final response = await ref
          .read(novalabApiProvider)
          .getOrganizationsApi()
          .joinOrganization(
            joinOrganizationRequest: JoinOrganizationRequest(
              (b) => b..organizationCode = code,
            ),
          );
      final status = response.data;
      if (status != null) {
        state = AsyncData(status);
        await ref.read(authControllerProvider.notifier).refreshSessionUser();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchStatus);
    await ref.read(authControllerProvider.notifier).refreshSessionUser();
  }
}

/// Proveedor de solicitudes pendientes para el dueño.
final pendingRequestsProvider =
    AsyncNotifierProvider<PendingRequestsNotifier, List<OrganizationMember>>(
      PendingRequestsNotifier.new,
    );

class PendingRequestsNotifier extends AsyncNotifier<List<OrganizationMember>> {
  @override
  Future<List<OrganizationMember>> build() async {
    final auth = ref.watch(authControllerProvider);
    if (auth.user?.role != Role.owner) {
      return const <OrganizationMember>[];
    }
    return _fetchRequests();
  }

  Future<List<OrganizationMember>> _fetchRequests() async {
    final response = await ref
        .read(novalabApiProvider)
        .getOrganizationsApi()
        .listOrganizationRequests();
    return response.data?.toList() ?? <OrganizationMember>[];
  }

  Future<bool> approve(int requestId) async {
    try {
      await ref
          .read(novalabApiProvider)
          .getOrganizationsApi()
          .approveOrganizationRequest(requestId: requestId);
      ref.invalidateSelf();
      ref.invalidate(organizationStatusProvider);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> reject(int requestId) async {
    try {
      await ref
          .read(novalabApiProvider)
          .getOrganizationsApi()
          .rejectOrganizationRequest(requestId: requestId);
      ref.invalidateSelf();
      ref.invalidate(organizationStatusProvider);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchRequests);
  }
}

/// Miembros activos de la organización (solo dueño; contrato
/// `GET /api/organizations/members`).
final organizationMembersProvider = FutureProvider<List<OrganizationMember>>((
  ref,
) async {
  final auth = ref.watch(authControllerProvider);
  if (auth.user?.role != Role.owner) {
    return const <OrganizationMember>[];
  }
  final response = await ref
      .watch(novalabApiProvider)
      .getOrganizationsApi()
      .listOrganizationMembers();
  return response.data?.toList() ?? <OrganizationMember>[];
});

/// Bytes del logo de la organización (`null` si no hay logo).
final organizationLogoProvider = FutureProvider<Uint8List?>((ref) async {
  final org = ref.watch(organizationStatusProvider).value?.organization;
  if (org == null || org.hasLogo != true) return null;
  try {
    final response = await ref
        .watch(novalabApiProvider)
        .getOrganizationsApi()
        .downloadOrganizationLogo();
    return response.data;
  } on DioException catch (error) {
    if (error.response?.statusCode == 404) return null;
    rethrow;
  }
});
