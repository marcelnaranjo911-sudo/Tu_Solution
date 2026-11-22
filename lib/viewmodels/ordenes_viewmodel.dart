import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/orden_detalle.dart';
import '../providers/data_providers.dart';

/// Filtro de estado seleccionado en la lista de órdenes (null = todas).
class FiltroEstadoNotifier extends Notifier<EstadoOrden?> {
  @override
  EstadoOrden? build() => null;

  void seleccionar(EstadoOrden? estado) => state = estado;
}

final filtroEstadoProvider =
    NotifierProvider<FiltroEstadoNotifier, EstadoOrden?>(
        FiltroEstadoNotifier.new);

final ordenesFiltradasProvider =
    Provider<AsyncValue<List<OrdenDetalle>>>((ref) {
  final filtro = ref.watch(filtroEstadoProvider);
  return ref.watch(ordenesProvider).whenData(
        (lista) => filtro == null
            ? lista
            : lista.where((o) => o.orden.estado == filtro).toList(),
      );
});
