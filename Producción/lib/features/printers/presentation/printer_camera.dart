import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/theme/design_tokens.dart';
import '../printers_providers.dart';

/// Miniatura de cámara de una impresora (P-02).
///
/// La imagen la sirve el backend (BE-07/08); aquí solo se muestra el último
/// snapshot. Nunca se accede al stream ni a la IP de la impresora. Mientras
/// la impresora está imprimiendo, refresca el snapshot cada ~12 s (BE-07).
/// Si la impresora tiene varias cámaras, permite cambiar de ángulo (solo la
/// 0 se muestra en el thumbnail de la tarjeta).
class PrinterCamera extends ConsumerStatefulWidget {
  const PrinterCamera({
    required this.printerId,
    required this.available,
    this.cameras = const <String>[],
    this.printing = false,
    super.key,
  });

  final int printerId;
  final bool available;
  final List<String> cameras;
  final bool printing;

  @override
  ConsumerState<PrinterCamera> createState() => _PrinterCameraState();
}

class _PrinterCameraState extends ConsumerState<PrinterCamera> {
  static const _refreshInterval = Duration(seconds: 12);
  int _cameraIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _syncTimer();
  }

  @override
  void didUpdateWidget(covariant PrinterCamera oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.printing != widget.printing) _syncTimer();
    if (_cameraIndex >= widget.cameras.length) _cameraIndex = 0;
  }

  void _syncTimer() {
    _timer?.cancel();
    _timer = null;
    if (widget.printing) {
      _timer = Timer.periodic(
        _refreshInterval,
        (_) => ref.invalidate(
          printerCameraSnapshotProvider((
            printerId: widget.printerId,
            index: _cameraIndex,
          )),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _content(context),
              if (widget.cameras.length > 1) _angleSelector(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    if (!widget.available) {
      return const _CameraPlaceholder(icon: Icons.videocam_off_outlined);
    }

    final key = (printerId: widget.printerId, index: _cameraIndex);
    final snapshot = ref.watch(printerCameraSnapshotProvider(key));
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

  Widget _angleSelector(BuildContext context) {
    return Positioned(
      right: DesignTokens.spaceXs,
      bottom: DesignTokens.spaceXs,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.cameras.length, (i) {
            final selected = i == _cameraIndex;
            return InkWell(
              onTap: () => setState(() => _cameraIndex = i),
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spaceSm,
                  vertical: DesignTokens.spaceXs,
                ),
                child: Text(
                  '${i + 1}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: selected ? DesignTokens.neonGreen : Colors.white70,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
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
