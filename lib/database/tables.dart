import 'package:drift/drift.dart';

/// Estados por los que pasa una orden de reparación.
enum EstadoOrden { recibida, enReparacion, lista, entregada, cancelada }

extension EstadoOrdenX on EstadoOrden {
  String get etiqueta => switch (this) {
        EstadoOrden.recibida => 'Recibida',
        EstadoOrden.enReparacion => 'En reparación',
        EstadoOrden.lista => 'Lista',
        EstadoOrden.entregada => 'Entregada',
        EstadoOrden.cancelada => 'Cancelada',
      };

  /// Orden que todavía no se cerró (se puede editar y bloquea un equipo duplicado).
  bool get abierta =>
      this == EstadoOrden.recibida ||
      this == EstadoOrden.enReparacion ||
      this == EstadoOrden.lista;

  /// Trabajo pendiente para el técnico.
  bool get enCurso =>
      this == EstadoOrden.recibida || this == EstadoOrden.enReparacion;

  /// Trabajo terminado por el técnico.
  bool get terminada =>
      this == EstadoOrden.lista || this == EstadoOrden.entregada;
}

@DataClassName('Tecnico')
class Tecnicos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 80)();
}

@DataClassName('Equipo')
class Equipos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipo => text()();
  TextColumn get marca => text()();
  TextColumn get modelo => text()();
  TextColumn get numeroSerie => text().unique()();
  TextColumn get nombreDueno => text()();
  TextColumn get telefonoDueno => text()();
  TextColumn get fallaReportada => text()();
}

@DataClassName('OrdenReparacion')
class OrdenesReparacion extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get equipoId => integer().references(Equipos, #id)();
  IntColumn get tecnicoId => integer().references(Tecnicos, #id)();
  IntColumn get estado => intEnum<EstadoOrden>()();
  RealColumn get costoManoObra => real().withDefault(const Constant(0))();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Repuesto')
class Repuestos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get codigo => text().unique()();
  RealColumn get precio => real()();
  IntColumn get stock => integer()();
  IntColumn get stockMinimo => integer()();
}

@DataClassName('RepuestoUsado')
class RepuestosUsados extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(OrdenesReparacion, #id)();
  IntColumn get repuestoId => integer().references(Repuestos, #id)();
  IntColumn get cantidad => integer()();
}

@DataClassName('TrabajoRealizado')
class TrabajosRealizados extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(OrdenesReparacion, #id)();
  TextColumn get descripcion => text()();
  RealColumn get costoManoObra => real()();
}
