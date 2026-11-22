import 'package:drift/drift.dart';

import '../models/orden_detalle.dart';
import '../models/taller_exception.dart';
import 'database.dart';
import 'tables.dart';

part 'daos.g.dart';

// ---------------------------------------------------------------------------
// Técnicos
// ---------------------------------------------------------------------------
@DriftAccessor(tables: [Tecnicos])
class TecnicosDao extends DatabaseAccessor<AppDatabase>
    with _$TecnicosDaoMixin {
  TecnicosDao(super.attachedDatabase);

  Stream<List<Tecnico>> observarTodos() {
    return (select(tecnicos)..orderBy([(t) => OrderingTerm.asc(t.nombre)]))
        .watch();
  }
}

// ---------------------------------------------------------------------------
// Inventario
// ---------------------------------------------------------------------------
@DriftAccessor(tables: [Repuestos])
class InventarioDao extends DatabaseAccessor<AppDatabase>
    with _$InventarioDaoMixin {
  InventarioDao(super.attachedDatabase);

  Stream<List<Repuesto>> observarRepuestos() {
    return (select(repuestos)..orderBy([(r) => OrderingTerm.asc(r.nombre)]))
        .watch();
  }

  Future<void> reponerStock(int repuestoId, int cantidad) async {
    if (cantidad <= 0) {
      throw const TallerException('La cantidad a reponer debe ser mayor que cero.');
    }
    await transaction(() async {
      final rep = await (select(repuestos)
            ..where((r) => r.id.equals(repuestoId)))
          .getSingle();
      await (update(repuestos)..where((r) => r.id.equals(repuestoId))).write(
        RepuestosCompanion(stock: Value(rep.stock + cantidad)),
      );
    });
  }
}

// ---------------------------------------------------------------------------
// Órdenes (incluye trabajos y repuestos usados)
// ---------------------------------------------------------------------------
@DriftAccessor(tables: [
  Tecnicos,
  Equipos,
  OrdenesReparacion,
  Repuestos,
  RepuestosUsados,
  TrabajosRealizados,
])
class OrdenesDao extends DatabaseAccessor<AppDatabase> with _$OrdenesDaoMixin {
  OrdenesDao(super.attachedDatabase);

  // ----- Consultas -----

  JoinedSelectStatement<HasResultSet, dynamic> _consultaOrdenes() {
    return select(ordenesReparacion).join([
      innerJoin(equipos, equipos.id.equalsExp(ordenesReparacion.equipoId)),
      innerJoin(tecnicos, tecnicos.id.equalsExp(ordenesReparacion.tecnicoId)),
    ]);
  }

  OrdenDetalle _mapear(TypedResult fila) => OrdenDetalle(
        orden: fila.readTable(ordenesReparacion),
        equipo: fila.readTable(equipos),
        tecnico: fila.readTable(tecnicos),
      );

  Stream<List<OrdenDetalle>> observarOrdenes() {
    final consulta = _consultaOrdenes()
      ..orderBy([
        OrderingTerm.desc(ordenesReparacion.fecha),
        OrderingTerm.desc(ordenesReparacion.id),
      ]);
    return consulta.watch().map((filas) => filas.map(_mapear).toList());
  }

  Stream<List<OrdenDetalle>> observarOrdenesDeTecnico(int tecnicoId) {
    final consulta = _consultaOrdenes()
      ..where(ordenesReparacion.tecnicoId.equals(tecnicoId))
      ..orderBy([
        OrderingTerm.desc(ordenesReparacion.fecha),
        OrderingTerm.desc(ordenesReparacion.id),
      ]);
    return consulta.watch().map((filas) => filas.map(_mapear).toList());
  }

  Stream<OrdenDetalle?> observarOrden(int ordenId) {
    final consulta = _consultaOrdenes()
      ..where(ordenesReparacion.id.equals(ordenId));
    return consulta
        .watchSingleOrNull()
        .map((fila) => fila == null ? null : _mapear(fila));
  }

  Stream<List<TrabajoRealizado>> observarTrabajos(int ordenId) {
    return (select(trabajosRealizados)
          ..where((t) => t.ordenId.equals(ordenId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .watch();
  }

  JoinedSelectStatement<HasResultSet, dynamic> _consultaUsos(int ordenId) {
    return select(repuestosUsados).join([
      innerJoin(
          repuestos, repuestos.id.equalsExp(repuestosUsados.repuestoId)),
    ])
      ..where(repuestosUsados.ordenId.equals(ordenId))
      ..orderBy([OrderingTerm.asc(repuestosUsados.id)]);
  }

  RepuestoUsadoDetalle _mapearUso(TypedResult fila) => RepuestoUsadoDetalle(
        uso: fila.readTable(repuestosUsados),
        repuesto: fila.readTable(repuestos),
      );

  Stream<List<RepuestoUsadoDetalle>> observarRepuestosUsados(int ordenId) {
    return _consultaUsos(ordenId)
        .watch()
        .map((filas) => filas.map(_mapearUso).toList());
  }

  Future<List<RepuestoUsadoDetalle>> repuestosDeOrden(int ordenId) async {
    final filas = await _consultaUsos(ordenId).get();
    return filas.map(_mapearUso).toList();
  }

  // ----- Crear orden -----

  /// Registra el equipo (o reutiliza el existente por número de serie) y crea
  /// la orden en estado "recibida". Si el equipo ya tiene una orden abierta
  /// se rechaza, para evitar que dos técnicos lo tomen a la vez.
  Future<int> crearOrden({
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String nombreDueno,
    required String telefonoDueno,
    required String fallaReportada,
    required int tecnicoId,
  }) {
    return transaction(() async {
      final serie = numeroSerie.trim();
      final existente = await (select(equipos)
            ..where((e) => e.numeroSerie.equals(serie)))
          .getSingleOrNull();

      int equipoId;
      if (existente != null) {
        final filas = await (select(ordenesReparacion).join([
          innerJoin(
              tecnicos, tecnicos.id.equalsExp(ordenesReparacion.tecnicoId)),
        ])
              ..where(ordenesReparacion.equipoId.equals(existente.id)))
            .get();
        for (final fila in filas) {
          final o = fila.readTable(ordenesReparacion);
          if (o.estado.abierta) {
            final responsable = fila.readTable(tecnicos).nombre;
            throw TallerException(
              'El equipo con serie $serie ya tiene la orden #${o.id} abierta '
              '(${o.estado.etiqueta}), a cargo de $responsable.',
            );
          }
        }
        equipoId = existente.id;
        // El equipo vuelve: se actualizan los datos de contacto y la falla.
        await (update(equipos)..where((e) => e.id.equals(existente.id))).write(
          EquiposCompanion(
            tipo: Value(tipo.trim()),
            marca: Value(marca.trim()),
            modelo: Value(modelo.trim()),
            nombreDueno: Value(nombreDueno.trim()),
            telefonoDueno: Value(telefonoDueno.trim()),
            fallaReportada: Value(fallaReportada.trim()),
          ),
        );
      } else {
        equipoId = await into(equipos).insert(EquiposCompanion.insert(
          tipo: tipo.trim(),
          marca: marca.trim(),
          modelo: modelo.trim(),
          numeroSerie: serie,
          nombreDueno: nombreDueno.trim(),
          telefonoDueno: telefonoDueno.trim(),
          fallaReportada: fallaReportada.trim(),
        ));
      }

      return into(ordenesReparacion).insert(OrdenesReparacionCompanion.insert(
        equipoId: equipoId,
        tecnicoId: tecnicoId,
        estado: EstadoOrden.recibida,
      ));
    });
  }

  // ----- Editar y eliminar orden -----

  /// Edita los datos de la orden: datos del equipo y técnico responsable.
  /// Regla: el número de serie no puede pertenecer a otro equipo distinto.
  Future<void> actualizarOrden({
    required int ordenId,
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String nombreDueno,
    required String telefonoDueno,
    required String fallaReportada,
    required int tecnicoId,
  }) {
    return transaction(() async {
      final orden = await (select(ordenesReparacion)
            ..where((o) => o.id.equals(ordenId)))
          .getSingle();
      final serie = numeroSerie.trim();

      final conMismaSerie = await (select(equipos)
            ..where((e) => e.numeroSerie.equals(serie)))
          .getSingleOrNull();
      if (conMismaSerie != null && conMismaSerie.id != orden.equipoId) {
        throw TallerException(
          'Ya existe otro equipo registrado con el número de serie $serie.',
        );
      }

      await (update(equipos)..where((e) => e.id.equals(orden.equipoId))).write(
        EquiposCompanion(
          tipo: Value(tipo.trim()),
          marca: Value(marca.trim()),
          modelo: Value(modelo.trim()),
          numeroSerie: Value(serie),
          nombreDueno: Value(nombreDueno.trim()),
          telefonoDueno: Value(telefonoDueno.trim()),
          fallaReportada: Value(fallaReportada.trim()),
        ),
      );
      await (update(ordenesReparacion)..where((o) => o.id.equals(ordenId)))
          .write(OrdenesReparacionCompanion(tecnicoId: Value(tecnicoId)));
    });
  }

  /// Elimina la orden con sus trabajos y repuestos usados.
  /// - Si la orden NO estaba entregada, las piezas vuelven al inventario.
  /// - Si el equipo se queda sin órdenes, también se elimina (así deja de
  ///   aparecer en el historial y en las sugerencias).
  Future<void> eliminarOrden(int ordenId) {
    return transaction(() async {
      final orden = await (select(ordenesReparacion)
            ..where((o) => o.id.equals(ordenId)))
          .getSingleOrNull();
      if (orden == null) return;

      if (orden.estado != EstadoOrden.entregada) {
        final usos = await (select(repuestosUsados)
              ..where((u) => u.ordenId.equals(ordenId)))
            .get();
        for (final uso in usos) {
          final rep = await (select(repuestos)
                ..where((r) => r.id.equals(uso.repuestoId)))
              .getSingle();
          await (update(repuestos)..where((r) => r.id.equals(rep.id))).write(
            RepuestosCompanion(stock: Value(rep.stock + uso.cantidad)),
          );
        }
      }

      await (delete(repuestosUsados)..where((u) => u.ordenId.equals(ordenId)))
          .go();
      await (delete(trabajosRealizados)
            ..where((t) => t.ordenId.equals(ordenId)))
          .go();
      await (delete(ordenesReparacion)..where((o) => o.id.equals(ordenId)))
          .go();

      final restantes = await (select(ordenesReparacion)
            ..where((o) => o.equipoId.equals(orden.equipoId)))
          .get();
      if (restantes.isEmpty) {
        await (delete(equipos)..where((e) => e.id.equals(orden.equipoId))).go();
      }
    });
  }

  // ----- Estado y responsable -----

  Future<void> cambiarEstado(int ordenId, EstadoOrden estado) async {
    await (update(ordenesReparacion)..where((o) => o.id.equals(ordenId)))
        .write(OrdenesReparacionCompanion(estado: Value(estado)));
  }

  Future<void> asignarTecnico(int ordenId, int tecnicoId) async {
    await (update(ordenesReparacion)..where((o) => o.id.equals(ordenId)))
        .write(OrdenesReparacionCompanion(tecnicoId: Value(tecnicoId)));
  }

  // ----- Trabajos de mano de obra -----

  Future<void> agregarTrabajo(
      int ordenId, String descripcion, double costo) async {
    if (descripcion.trim().isEmpty) {
      throw const TallerException('La descripción del trabajo es obligatoria.');
    }
    if (costo < 0) {
      throw const TallerException('El costo no puede ser negativo.');
    }
    await transaction(() async {
      await into(trabajosRealizados).insert(TrabajosRealizadosCompanion.insert(
        ordenId: ordenId,
        descripcion: descripcion.trim(),
        costoManoObra: costo,
      ));
      await _sincronizarManoObra(ordenId);
    });
  }

  Future<void> eliminarTrabajo(int trabajoId) async {
    await transaction(() async {
      final trabajo = await (select(trabajosRealizados)
            ..where((t) => t.id.equals(trabajoId)))
          .getSingle();
      await (delete(trabajosRealizados)..where((t) => t.id.equals(trabajoId)))
          .go();
      await _sincronizarManoObra(trabajo.ordenId);
    });
  }

  /// Mantiene la columna costoManoObra de la orden igual a la suma de sus trabajos.
  Future<void> _sincronizarManoObra(int ordenId) async {
    final lista = await (select(trabajosRealizados)
          ..where((t) => t.ordenId.equals(ordenId)))
        .get();
    final total = lista.fold<double>(0, (suma, t) => suma + t.costoManoObra);
    await (update(ordenesReparacion)..where((o) => o.id.equals(ordenId)))
        .write(OrdenesReparacionCompanion(costoManoObra: Value(total)));
  }

  // ----- Repuestos usados (descuentan stock) -----

  /// Agrega un repuesto a la orden y RESTA la cantidad del stock, todo en una
  /// sola transacción: o se hacen las dos cosas o ninguna.
  Future<void> agregarRepuesto(
      int ordenId, int repuestoId, int cantidad) async {
    if (cantidad <= 0) {
      throw const TallerException('La cantidad debe ser mayor que cero.');
    }
    await transaction(() async {
      final rep = await (select(repuestos)
            ..where((r) => r.id.equals(repuestoId)))
          .getSingle();
      if (rep.stock < cantidad) {
        throw TallerException(
          'Stock insuficiente de "${rep.nombre}": quedan ${rep.stock} y se piden $cantidad.',
        );
      }

      final existente = await (select(repuestosUsados)
            ..where((u) =>
                u.ordenId.equals(ordenId) & u.repuestoId.equals(repuestoId)))
          .getSingleOrNull();
      if (existente != null) {
        await (update(repuestosUsados)..where((u) => u.id.equals(existente.id)))
            .write(RepuestosUsadosCompanion(
                cantidad: Value(existente.cantidad + cantidad)));
      } else {
        await into(repuestosUsados).insert(RepuestosUsadosCompanion.insert(
          ordenId: ordenId,
          repuestoId: repuestoId,
          cantidad: cantidad,
        ));
      }

      await (update(repuestos)..where((r) => r.id.equals(repuestoId)))
          .write(RepuestosCompanion(stock: Value(rep.stock - cantidad)));
    });
  }

  /// Quita un repuesto de la orden y DEVUELVE la cantidad al stock.
  Future<void> quitarRepuesto(int usoId) async {
    await transaction(() async {
      final uso = await (select(repuestosUsados)
            ..where((u) => u.id.equals(usoId)))
          .getSingle();
      final rep = await (select(repuestos)
            ..where((r) => r.id.equals(uso.repuestoId)))
          .getSingle();
      await (update(repuestos)..where((r) => r.id.equals(rep.id)))
          .write(RepuestosCompanion(stock: Value(rep.stock + uso.cantidad)));
      await (delete(repuestosUsados)..where((u) => u.id.equals(usoId))).go();
    });
  }
}

// ---------------------------------------------------------------------------
// Equipos / historial
// ---------------------------------------------------------------------------
@DriftAccessor(tables: [
  Tecnicos,
  Equipos,
  OrdenesReparacion,
  Repuestos,
  RepuestosUsados,
  TrabajosRealizados,
])
class EquiposDao extends DatabaseAccessor<AppDatabase> with _$EquiposDaoMixin {
  EquiposDao(super.attachedDatabase);

  /// Todos los equipos registrados (sirven para sugerir datos al escribir).
  Stream<List<Equipo>> observarEquipos() {
    return (select(equipos)..orderBy([(e) => OrderingTerm.desc(e.id)])).watch();
  }

  /// Busca equipos por número de serie o teléfono del dueño (coincidencia parcial)
  /// y devuelve cada uno con todas sus órdenes pasadas.
  Future<List<HistorialEquipo>> buscarConHistorial(String texto) async {
    final patron = '%${texto.trim()}%';
    final encontrados = await (select(equipos)
          ..where(
              (e) => e.numeroSerie.like(patron) | e.telefonoDueno.like(patron))
          ..orderBy([(e) => OrderingTerm.asc(e.id)]))
        .get();

    final resultado = <HistorialEquipo>[];
    for (final eq in encontrados) {
      resultado.add(
          HistorialEquipo(equipo: eq, ordenes: await _historialDe(eq)));
    }
    return resultado;
  }

  Future<List<HistorialOrden>> _historialDe(Equipo eq) async {
    final filas = await (select(ordenesReparacion).join([
      innerJoin(tecnicos, tecnicos.id.equalsExp(ordenesReparacion.tecnicoId)),
    ])
          ..where(ordenesReparacion.equipoId.equals(eq.id))
          ..orderBy([
            OrderingTerm.desc(ordenesReparacion.fecha),
            OrderingTerm.desc(ordenesReparacion.id),
          ]))
        .get();

    final historial = <HistorialOrden>[];
    for (final fila in filas) {
      final orden = fila.readTable(ordenesReparacion);
      final trabajos = await (select(trabajosRealizados)
            ..where((t) => t.ordenId.equals(orden.id))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();
      final usos = await attachedDatabase.ordenesDao.repuestosDeOrden(orden.id);
      historial.add(HistorialOrden(
        detalle: OrdenDetalle(
          orden: orden,
          equipo: eq,
          tecnico: fila.readTable(tecnicos),
        ),
        trabajos: trabajos,
        repuestos: usos,
      ));
    }
    return historial;
  }
}
