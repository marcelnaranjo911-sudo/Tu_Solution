import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/orden_detalle.dart';
import '../providers/data_providers.dart';
import 'async_utils.dart';

/// Carga de trabajo de un técnico.
class CargaTecnico {
  final Tecnico tecnico;

  /// Órdenes recibidas o en reparación.
  final int enCurso;

  /// Órdenes listas o entregadas.
  final int terminadas;

  const CargaTecnico({
    required this.tecnico,
    required this.enCurso,
    required this.terminadas,
  });
}

final cargaTecnicosProvider =
    Provider.autoDispose<AsyncValue<List<CargaTecnico>>>((ref) {
  return combinar2<List<Tecnico>, List<OrdenDetalle>, List<CargaTecnico>>(
    ref.watch(tecnicosProvider),
    ref.watch(ordenesProvider),
    (tecnicos, ordenes) => [
      for (final t in tecnicos)
        CargaTecnico(
          tecnico: t,
          enCurso: ordenes
              .where((o) => o.tecnico.id == t.id && o.orden.estado.enCurso)
              .length,
          terminadas: ordenes
              .where((o) => o.tecnico.id == t.id && o.orden.estado.terminada)
              .length,
        ),
    ],
  );
});
