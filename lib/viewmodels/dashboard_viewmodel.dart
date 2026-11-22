import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/extensiones.dart';
import '../models/orden_detalle.dart';
import '../providers/data_providers.dart';
import 'async_utils.dart';
import 'tecnicos_viewmodel.dart';

class DashboardState {
  final int ordenesAbiertas;
  final int recibidas;
  final int enReparacion;
  final int listas;
  final List<Repuesto> bajoStock;
  final List<CargaTecnico> carga;

  const DashboardState({
    required this.ordenesAbiertas,
    required this.recibidas,
    required this.enReparacion,
    required this.listas,
    required this.bajoStock,
    required this.carga,
  });
}

final dashboardProvider =
    Provider.autoDispose<AsyncValue<DashboardState>>((ref) {
  return combinar3<List<OrdenDetalle>, List<Repuesto>, List<CargaTecnico>,
      DashboardState>(
    ref.watch(ordenesProvider),
    ref.watch(repuestosProvider),
    ref.watch(cargaTecnicosProvider),
    (ordenes, repuestos, carga) {
      int contar(EstadoOrden e) =>
          ordenes.where((o) => o.orden.estado == e).length;
      return DashboardState(
        ordenesAbiertas: ordenes.where((o) => o.orden.estado.abierta).length,
        recibidas: contar(EstadoOrden.recibida),
        enReparacion: contar(EstadoOrden.enReparacion),
        listas: contar(EstadoOrden.lista),
        bajoStock: repuestos.where((r) => r.bajoStock).toList(),
        carga: carga,
      );
    },
  );
});
