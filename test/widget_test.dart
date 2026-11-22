import 'package:flutter_test/flutter_test.dart';
import 'package:tu_solution/database/tables.dart';

void main() {
  test('las etiquetas y reglas de estado son correctas', () {
    expect(EstadoOrden.enReparacion.etiqueta, 'En reparación');
    expect(EstadoOrden.recibida.abierta, isTrue);
    expect(EstadoOrden.entregada.abierta, isFalse);
    expect(EstadoOrden.cancelada.abierta, isFalse);
  });
}
