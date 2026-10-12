import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for PublicApi
void main() {
  final instance = NovalabApi().getPublicApi();

  group(PublicApi, () {
    // Marca y configuración visible del negocio
    //
    //Future<Branding> getBranding() async
    test('test getBranding', () async {
      // TODO
    });
  });
}
