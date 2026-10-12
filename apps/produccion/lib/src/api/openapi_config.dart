// Openapi Generator last run: : 2026-10-12T13:00:22.792056
// Configuración de generación del cliente Dart desde el contrato OpenAPI.
//
// El contrato único vive en `packages/api-contract/openapi.yaml` (doc §7).
// Regenerar con:
//   flutter pub run build_runner build --delete-conflicting-outputs
//
// La salida es un paquete Dart en `packages/api_client`, consumido por esta app
// vía dependencia de ruta. No editar el código generado a mano.
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'novalab_api',
    pubAuthor: 'NOVALAB',
    pubDescription:
        'Cliente Dart/dio generado desde packages/api-contract/openapi.yaml. No editar a mano.',
  ),
  inputSpec: InputSpec(path: '../../packages/api-contract/openapi.yaml'),
  generatorName: Generator.dio,
  outputDirectory: '../../packages/api_client',
  runSourceGenOnOutput: true,
  fetchDependencies: true,
  // El spec vive fuera del package, así que build_runner no puede detectar sus
  // cambios; forzamos la regeneración en cada corrida (tarda ~1 min).
  forceAlwaysRun: true,
)
class OpenApiClientGenerator {}
