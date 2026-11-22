import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/daos.dart';
import '../database/database.dart';
import '../models/orden_detalle.dart';
import '../providers/data_providers.dart';
import '../providers/database_provider.dart';

/// Acciones sobre una orden. La pantalla no toca la base de datos directamente.
class OrdenDetalleViewModel {
  final OrdenesDao _dao;
  const OrdenDetalleViewModel(this._dao);

  Future<void> cambiarEstado(int ordenId, EstadoOrden estado) =>
      _dao.cambiarEstado(ordenId, estado);

  Future<void> asignarTecnico(int ordenId, int tecnicoId) =>
      _dao.asignarTecnico(ordenId, tecnicoId);

  Future<void> agregarTrabajo(int ordenId, String descripcion, double costo) =>
      _dao.agregarTrabajo(ordenId, descripcion, costo);

  Future<void> eliminarTrabajo(int trabajoId) => _dao.eliminarTrabajo(trabajoId);

  /// Agrega el repuesto y descuenta el stock automáticamente.
  Future<void> agregarRepuesto(int ordenId, int repuestoId, int cantidad) =>
      _dao.agregarRepuesto(ordenId, repuestoId, cantidad);

  /// Quita el repuesto y devuelve el stock.
  Future<void> quitarRepuesto(int usoId) => _dao.quitarRepuesto(usoId);

  /// Elimina la orden (y sus trabajos y repuestos) de la app.
  Future<void> eliminarOrden(int ordenId) => _dao.eliminarOrden(ordenId);
}

final ordenDetalleViewModelProvider = Provider<OrdenDetalleViewModel>(
  (ref) => OrdenDetalleViewModel(ref.watch(ordenesDaoProvider)),
);

/// Costo total de una orden = mano de obra + repuestos.
class ResumenCosto {
  final double manoObra;
  final double repuestos;

  const ResumenCosto({required this.manoObra, required this.repuestos});

  double get total => manoObra + repuestos;
}

final resumenCostoProvider =
    Provider.autoDispose.family<ResumenCosto, int>((ref, ordenId) {
  final trabajos =
      ref.watch(trabajosProvider(ordenId)).value ?? const <TrabajoRealizado>[];
  final usos = ref.watch(repuestosUsadosProvider(ordenId)).value ??
      const <RepuestoUsadoDetalle>[];
  return ResumenCosto(
    manoObra: trabajos.fold<double>(0, (suma, t) => suma + t.costoManoObra),
    repuestos: usos.fold<double>(0, (suma, u) => suma + u.subtotal),
  );
});
