import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/orden_detalle.dart';
import '../providers/data_providers.dart';
import '../providers/database_provider.dart';

/// Texto escrito en el buscador (número de serie o teléfono).
class BusquedaHistorialNotifier extends Notifier<String> {
  @override
  String build() => '';

  void actualizar(String texto) => state = texto;
}

final busquedaHistorialProvider =
    NotifierProvider<BusquedaHistorialNotifier, String>(
        BusquedaHistorialNotifier.new);

/// Resultado de la búsqueda con todas las órdenes pasadas de cada equipo.
final historialProvider =
    FutureProvider.autoDispose<List<HistorialEquipo>>((ref) async {
  final texto = ref.watch(busquedaHistorialProvider).trim();
  // Se vuelve a calcular cuando cambian órdenes o stock (repuestos usados).
  ref.watch(ordenesProvider);
  ref.watch(repuestosProvider);
  if (texto.length < 2) return const <HistorialEquipo>[];
  return ref.watch(equiposDaoProvider).buscarConHistorial(texto);
});
