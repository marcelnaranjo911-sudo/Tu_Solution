import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos.dart';
import 'tables.dart';

export 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Tecnicos,
    Equipos,
    OrdenesReparacion,
    Repuestos,
    RepuestosUsados,
    TrabajosRealizados,
  ],
  daos: [TecnicosDao, EquiposDao, OrdenesDao, InventarioDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'tu_solution'));

  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _sembrarDatos();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Fuerza la apertura de la base (y la siembra la primera vez) antes de runApp.
  Future<void> inicializar() async {
    await customSelect('SELECT 1').get();
  }

  /// Datos semilla: se ejecutan una sola vez, cuando la base se crea.
  Future<void> _sembrarDatos() async {
    // Técnicos
    final carlos =
        await into(tecnicos).insert(TecnicosCompanion.insert(nombre: 'Carlos'));
    final ana =
        await into(tecnicos).insert(TecnicosCompanion.insert(nombre: 'Ana'));
    await into(tecnicos).insert(TecnicosCompanion.insert(nombre: 'Luis'));

    // Repuestos (la pantalla ya descuenta 1 por la orden semilla en reparación)
    final pantalla = await into(repuestos).insert(RepuestosCompanion.insert(
      nombre: 'Pantalla OLED 6.5"',
      codigo: 'PAN-001',
      precio: 85.0,
      stock: 5,
      stockMinimo: 3,
    ));
    await batch((b) {
      b.insertAll(repuestos, [
        RepuestosCompanion.insert(
          nombre: 'Batería Li-ion 4000 mAh',
          codigo: 'BAT-002',
          precio: 25.0,
          stock: 10,
          stockMinimo: 4,
        ),
        RepuestosCompanion.insert(
          nombre: 'Conector de carga USB-C',
          codigo: 'CON-003',
          precio: 8.0,
          stock: 2,
          stockMinimo: 3,
        ),
        RepuestosCompanion.insert(
          nombre: 'Módulo de cámara trasera',
          codigo: 'CAM-004',
          precio: 40.0,
          stock: 4,
          stockMinimo: 2,
        ),
        RepuestosCompanion.insert(
          nombre: 'Teclado de laptop',
          codigo: 'TEC-005',
          precio: 30.0,
          stock: 3,
          stockMinimo: 3,
        ),
        RepuestosCompanion.insert(
          nombre: 'Pasta térmica',
          codigo: 'PAS-006',
          precio: 5.0,
          stock: 15,
          stockMinimo: 5,
        ),
      ]);
    });

    // Equipos
    final celular = await into(equipos).insert(EquiposCompanion.insert(
      tipo: 'Celular',
      marca: 'Samsung',
      modelo: 'Galaxy A52',
      numeroSerie: 'SN-A52-0001',
      nombreDueno: 'Marta Pérez',
      telefonoDueno: '5555 1111',
      fallaReportada: 'Pantalla rota y no carga',
    ));
    final laptop = await into(equipos).insert(EquiposCompanion.insert(
      tipo: 'Laptop',
      marca: 'Lenovo',
      modelo: 'IdeaPad 3',
      numeroSerie: 'SN-LEN-0002',
      nombreDueno: 'Jorge Díaz',
      telefonoDueno: '5555 2222',
      fallaReportada: 'No enciende',
    ));

    // Órdenes: una en reparación (Carlos) y una recibida (Ana)
    final ordenEnReparacion =
        await into(ordenesReparacion).insert(OrdenesReparacionCompanion.insert(
      equipoId: celular,
      tecnicoId: carlos,
      estado: EstadoOrden.enReparacion,
      costoManoObra: const Value(15.0),
      fecha: Value(DateTime.now().subtract(const Duration(days: 2))),
    ));
    await into(ordenesReparacion).insert(OrdenesReparacionCompanion.insert(
      equipoId: laptop,
      tecnicoId: ana,
      estado: EstadoOrden.recibida,
    ));

    await into(trabajosRealizados).insert(TrabajosRealizadosCompanion.insert(
      ordenId: ordenEnReparacion,
      descripcion: 'Diagnóstico y cambio de pantalla',
      costoManoObra: 15.0,
    ));
    await into(repuestosUsados).insert(RepuestosUsadosCompanion.insert(
      ordenId: ordenEnReparacion,
      repuestoId: pantalla,
      cantidad: 1,
    ));
  }
}
