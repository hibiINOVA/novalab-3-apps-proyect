import 'package:test/test.dart';
import 'package:novalab_api/novalab_api.dart';

/// tests for PrintJobsApi
void main() {
  final instance = NovalabApi().getPrintJobsApi();

  group(PrintJobsApi, () {
    // Marca un job como terminado
    //
    //Future<PrintJob> completePrintJob(int jobId) async
    test('test completePrintJob', () async {
      // TODO
    });

    // Marca un job como fallido y registra el motivo
    //
    //Future<PrintJob> failPrintJob(int jobId, PrintJobFailRequest printJobFailRequest) async
    test('test failPrintJob', () async {
      // TODO
    });

    // Crea un nuevo job para reimprimir un item fallido
    //
    //Future<PrintJob> reprintJob(int jobId) async
    test('test reprintJob', () async {
      // TODO
    });

    // Confirma e inicia la impresión de un item (BE-05)
    //
    // Requiere confirmación explícita del operador (\"cama libre y filamento correcto\"). Nunca inicia impresiones de forma automática.
    //
    //Future<PrintJob> startPrintJob(PrintJobStartRequest printJobStartRequest) async
    test('test startPrintJob', () async {
      // TODO
    });
  });
}
