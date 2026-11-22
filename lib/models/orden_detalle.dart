import '../database/database.dart';

/// Orden junto con su equipo y el técnico responsable.
class OrdenDetalle {
  final OrdenReparacion orden;
  final Equipo equipo;
  final Tecnico tecnico;

  const OrdenDetalle({
    required this.orden,
    required this.equipo,
    required this.tecnico,
  });
}

/// Línea de repuesto usado con los datos del repuesto.
class RepuestoUsadoDetalle {
  final RepuestoUsado uso;
  final Repuesto repuesto;

  const RepuestoUsadoDetalle({required this.uso, required this.repuesto});

  double get subtotal => repuesto.precio * uso.cantidad;
}

/// Una visita pasada de un equipo: qué se le hizo y qué piezas se usaron.
class HistorialOrden {
  final OrdenDetalle detalle;
  final List<TrabajoRealizado> trabajos;
  final List<RepuestoUsadoDetalle> repuestos;

  const HistorialOrden({
    required this.detalle,
    required this.trabajos,
    required this.repuestos,
  });

  double get manoObra =>
      trabajos.fold<double>(0, (suma, t) => suma + t.costoManoObra);
  double get costoRepuestos =>
      repuestos.fold<double>(0, (suma, r) => suma + r.subtotal);
  double get total => manoObra + costoRepuestos;
}

class HistorialEquipo {
  final Equipo equipo;
  final List<HistorialOrden> ordenes;

  const HistorialEquipo({required this.equipo, required this.ordenes});
}
