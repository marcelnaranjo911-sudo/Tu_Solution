// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daos.dart';

// ignore_for_file: type=lint
mixin _$TecnicosDaoMixin on DatabaseAccessor<AppDatabase> {
  $TecnicosTable get tecnicos => attachedDatabase.tecnicos;
  TecnicosDaoManager get managers => TecnicosDaoManager(this);
}

class TecnicosDaoManager {
  final _$TecnicosDaoMixin _db;
  TecnicosDaoManager(this._db);
  $$TecnicosTableTableManager get tecnicos =>
      $$TecnicosTableTableManager(_db.attachedDatabase, _db.tecnicos);
}

mixin _$InventarioDaoMixin on DatabaseAccessor<AppDatabase> {
  $RepuestosTable get repuestos => attachedDatabase.repuestos;
  InventarioDaoManager get managers => InventarioDaoManager(this);
}

class InventarioDaoManager {
  final _$InventarioDaoMixin _db;
  InventarioDaoManager(this._db);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db.attachedDatabase, _db.repuestos);
}

mixin _$OrdenesDaoMixin on DatabaseAccessor<AppDatabase> {
  $TecnicosTable get tecnicos => attachedDatabase.tecnicos;
  $EquiposTable get equipos => attachedDatabase.equipos;
  $OrdenesReparacionTable get ordenesReparacion =>
      attachedDatabase.ordenesReparacion;
  $RepuestosTable get repuestos => attachedDatabase.repuestos;
  $RepuestosUsadosTable get repuestosUsados => attachedDatabase.repuestosUsados;
  $TrabajosRealizadosTable get trabajosRealizados =>
      attachedDatabase.trabajosRealizados;
  OrdenesDaoManager get managers => OrdenesDaoManager(this);
}

class OrdenesDaoManager {
  final _$OrdenesDaoMixin _db;
  OrdenesDaoManager(this._db);
  $$TecnicosTableTableManager get tecnicos =>
      $$TecnicosTableTableManager(_db.attachedDatabase, _db.tecnicos);
  $$EquiposTableTableManager get equipos =>
      $$EquiposTableTableManager(_db.attachedDatabase, _db.equipos);
  $$OrdenesReparacionTableTableManager get ordenesReparacion =>
      $$OrdenesReparacionTableTableManager(
          _db.attachedDatabase, _db.ordenesReparacion);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db.attachedDatabase, _db.repuestos);
  $$RepuestosUsadosTableTableManager get repuestosUsados =>
      $$RepuestosUsadosTableTableManager(
          _db.attachedDatabase, _db.repuestosUsados);
  $$TrabajosRealizadosTableTableManager get trabajosRealizados =>
      $$TrabajosRealizadosTableTableManager(
          _db.attachedDatabase, _db.trabajosRealizados);
}

mixin _$EquiposDaoMixin on DatabaseAccessor<AppDatabase> {
  $TecnicosTable get tecnicos => attachedDatabase.tecnicos;
  $EquiposTable get equipos => attachedDatabase.equipos;
  $OrdenesReparacionTable get ordenesReparacion =>
      attachedDatabase.ordenesReparacion;
  $RepuestosTable get repuestos => attachedDatabase.repuestos;
  $RepuestosUsadosTable get repuestosUsados => attachedDatabase.repuestosUsados;
  $TrabajosRealizadosTable get trabajosRealizados =>
      attachedDatabase.trabajosRealizados;
  EquiposDaoManager get managers => EquiposDaoManager(this);
}

class EquiposDaoManager {
  final _$EquiposDaoMixin _db;
  EquiposDaoManager(this._db);
  $$TecnicosTableTableManager get tecnicos =>
      $$TecnicosTableTableManager(_db.attachedDatabase, _db.tecnicos);
  $$EquiposTableTableManager get equipos =>
      $$EquiposTableTableManager(_db.attachedDatabase, _db.equipos);
  $$OrdenesReparacionTableTableManager get ordenesReparacion =>
      $$OrdenesReparacionTableTableManager(
          _db.attachedDatabase, _db.ordenesReparacion);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db.attachedDatabase, _db.repuestos);
  $$RepuestosUsadosTableTableManager get repuestosUsados =>
      $$RepuestosUsadosTableTableManager(
          _db.attachedDatabase, _db.repuestosUsados);
  $$TrabajosRealizadosTableTableManager get trabajosRealizados =>
      $$TrabajosRealizadosTableTableManager(
          _db.attachedDatabase, _db.trabajosRealizados);
}
