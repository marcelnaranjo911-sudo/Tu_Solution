import '../database/database.dart';

extension RepuestoX on Repuesto {
  /// Alerta: el stock llegó (o bajó de) el mínimo.
  bool get bajoStock => stock <= stockMinimo;
}

String formatoMoneda(double valor) => '\$${valor.toStringAsFixed(2)}';

String formatoFecha(DateTime f) {
  String dos(int n) => n.toString().padLeft(2, '0');
  return '${dos(f.day)}/${dos(f.month)}/${f.year} ${dos(f.hour)}:${dos(f.minute)}';
}
