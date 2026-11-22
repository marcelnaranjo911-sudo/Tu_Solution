import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/orden_detalle.dart';
import 'database_provider.dart';

final tecnicosProvider = StreamProvider<List<Tecnico>>(
  (ref) => ref.watch(tecnicosDaoProvider).observarTodos(),
);

final ordenesProvider = StreamProvider<List<OrdenDetalle>>(
  (ref) => ref.watch(ordenesDaoProvider).observarOrdenes(),
);

final repuestosProvider = StreamProvider<List<Repuesto>>(
  (ref) => ref.watch(inventarioDaoProvider).observarRepuestos(),
);

final ordenProvider = StreamProvider.autoDispose.family<OrdenDetalle?, int>(
  (ref, ordenId) => ref.watch(ordenesDaoProvider).observarOrden(ordenId),
);

final ordenesDeTecnicoProvider =
    StreamProvider.autoDispose.family<List<OrdenDetalle>, int>(
  (ref, tecnicoId) =>
      ref.watch(ordenesDaoProvider).observarOrdenesDeTecnico(tecnicoId),
);

final trabajosProvider =
    StreamProvider.autoDispose.family<List<TrabajoRealizado>, int>(
  (ref, ordenId) => ref.watch(ordenesDaoProvider).observarTrabajos(ordenId),
);

final repuestosUsadosProvider =
    StreamProvider.autoDispose.family<List<RepuestoUsadoDetalle>, int>(
  (ref, ordenId) =>
      ref.watch(ordenesDaoProvider).observarRepuestosUsados(ordenId),
);
