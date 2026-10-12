import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../printers_providers.dart';

/// Miniatura de cámara de una impresora (P-02).
///
/// La imagen la sirve el backend (BE-07/08); aquí solo se muestra el último
/// snapshot. Nunca se accede al stream ni a la IP de la impresora.
class PrinterCamera extends ConsumerWidget {
  const PrinterCamera({
    required this.printerId,
    required this.available,
    super.key,
  });

  final int printerId;
  final bool available;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: _content(context, ref),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, WidgetRef ref) {
    if (!available) {
      return const _CameraPlaceholder(icon: Icons.videocam_off_outlined);
    }

    final snapshot = ref.watch(printerCameraSnapshotProvider(printerId));
    return snapshot.when(
      loading: () => const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (_, _) =>
          const _CameraPlaceholder(icon: Icons.broken_image_outlined),
      data: (bytes) {
        if (bytes == null || bytes.isEmpty) {
          return const _CameraPlaceholder(icon: Icons.videocam_off_outlined);
        }
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          gaplessPlayback: true,
          width: double.infinity,
        );
      },
    );
  }
}

class _CameraPlaceholder extends StatelessWidget {
  const _CameraPlaceholder({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: scheme.onSurfaceVariant),
          const SizedBox(height: DesignTokens.spaceXs),
          Text(
            AppStrings.printerCameraUnavailable,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
