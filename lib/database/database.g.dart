// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TecnicosTable extends Tecnicos with TableInfo<$TecnicosTable, Tecnico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TecnicosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 80),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tecnicos';
  @override
  VerificationContext validateIntegrity(Insertable<Tecnico> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tecnico map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tecnico(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
    );
  }

  @override
  $TecnicosTable createAlias(String alias) {
    return $TecnicosTable(attachedDatabase, alias);
  }
}

class Tecnico extends DataClass implements Insertable<Tecnico> {
  final int id;
  final String nombre;
  const Tecnico({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  TecnicosCompanion toCompanion(bool nullToAbsent) {
    return TecnicosCompanion(
      id: Value(id),
      nombre: Value(nombre),
    );
  }

  factory Tecnico.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tecnico(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Tecnico copyWith({int? id, String? nombre}) => Tecnico(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );
  Tecnico copyWithCompanion(TecnicosCompanion data) {
    return Tecnico(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tecnico(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tecnico && other.id == this.id && other.nombre == this.nombre);
}

class TecnicosCompanion extends UpdateCompanion<Tecnico> {
  final Value<int> id;
  final Value<String> nombre;
  const TecnicosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  TecnicosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Tecnico> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  TecnicosCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return TecnicosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TecnicosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $EquiposTable extends Equipos with TableInfo<$EquiposTable, Equipo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquiposTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
      'marca', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
      'modelo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroSerieMeta =
      const VerificationMeta('numeroSerie');
  @override
  late final GeneratedColumn<String> numeroSerie = GeneratedColumn<String>(
      'numero_serie', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nombreDuenoMeta =
      const VerificationMeta('nombreDueno');
  @override
  late final GeneratedColumn<String> nombreDueno = GeneratedColumn<String>(
      'nombre_dueno', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _telefonoDuenoMeta =
      const VerificationMeta('telefonoDueno');
  @override
  late final GeneratedColumn<String> telefonoDueno = GeneratedColumn<String>(
      'telefono_dueno', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fallaReportadaMeta =
      const VerificationMeta('fallaReportada');
  @override
  late final GeneratedColumn<String> fallaReportada = GeneratedColumn<String>(
      'falla_reportada', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tipo,
        marca,
        modelo,
        numeroSerie,
        nombreDueno,
        telefonoDueno,
        fallaReportada
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipos';
  @override
  VerificationContext validateIntegrity(Insertable<Equipo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
          _marcaMeta, marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta));
    } else if (isInserting) {
      context.missing(_marcaMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(_modeloMeta,
          modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta));
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('numero_serie')) {
      context.handle(
          _numeroSerieMeta,
          numeroSerie.isAcceptableOrUnknown(
              data['numero_serie']!, _numeroSerieMeta));
    } else if (isInserting) {
      context.missing(_numeroSerieMeta);
    }
    if (data.containsKey('nombre_dueno')) {
      context.handle(
          _nombreDuenoMeta,
          nombreDueno.isAcceptableOrUnknown(
              data['nombre_dueno']!, _nombreDuenoMeta));
    } else if (isInserting) {
      context.missing(_nombreDuenoMeta);
    }
    if (data.containsKey('telefono_dueno')) {
      context.handle(
          _telefonoDuenoMeta,
          telefonoDueno.isAcceptableOrUnknown(
              data['telefono_dueno']!, _telefonoDuenoMeta));
    } else if (isInserting) {
      context.missing(_telefonoDuenoMeta);
    }
    if (data.containsKey('falla_reportada')) {
      context.handle(
          _fallaReportadaMeta,
          fallaReportada.isAcceptableOrUnknown(
              data['falla_reportada']!, _fallaReportadaMeta));
    } else if (isInserting) {
      context.missing(_fallaReportadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Equipo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Equipo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      marca: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marca'])!,
      modelo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modelo'])!,
      numeroSerie: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero_serie'])!,
      nombreDueno: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre_dueno'])!,
      telefonoDueno: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono_dueno'])!,
      fallaReportada: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}falla_reportada'])!,
    );
  }

  @override
  $EquiposTable createAlias(String alias) {
    return $EquiposTable(attachedDatabase, alias);
  }
}

class Equipo extends DataClass implements Insertable<Equipo> {
  final int id;
  final String tipo;
  final String marca;
  final String modelo;
  final String numeroSerie;
  final String nombreDueno;
  final String telefonoDueno;
  final String fallaReportada;
  const Equipo(
      {required this.id,
      required this.tipo,
      required this.marca,
      required this.modelo,
      required this.numeroSerie,
      required this.nombreDueno,
      required this.telefonoDueno,
      required this.fallaReportada});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipo'] = Variable<String>(tipo);
    map['marca'] = Variable<String>(marca);
    map['modelo'] = Variable<String>(modelo);
    map['numero_serie'] = Variable<String>(numeroSerie);
    map['nombre_dueno'] = Variable<String>(nombreDueno);
    map['telefono_dueno'] = Variable<String>(telefonoDueno);
    map['falla_reportada'] = Variable<String>(fallaReportada);
    return map;
  }

  EquiposCompanion toCompanion(bool nullToAbsent) {
    return EquiposCompanion(
      id: Value(id),
      tipo: Value(tipo),
      marca: Value(marca),
      modelo: Value(modelo),
      numeroSerie: Value(numeroSerie),
      nombreDueno: Value(nombreDueno),
      telefonoDueno: Value(telefonoDueno),
      fallaReportada: Value(fallaReportada),
    );
  }

  factory Equipo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Equipo(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      marca: serializer.fromJson<String>(json['marca']),
      modelo: serializer.fromJson<String>(json['modelo']),
      numeroSerie: serializer.fromJson<String>(json['numeroSerie']),
      nombreDueno: serializer.fromJson<String>(json['nombreDueno']),
      telefonoDueno: serializer.fromJson<String>(json['telefonoDueno']),
      fallaReportada: serializer.fromJson<String>(json['fallaReportada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'marca': serializer.toJson<String>(marca),
      'modelo': serializer.toJson<String>(modelo),
      'numeroSerie': serializer.toJson<String>(numeroSerie),
      'nombreDueno': serializer.toJson<String>(nombreDueno),
      'telefonoDueno': serializer.toJson<String>(telefonoDueno),
      'fallaReportada': serializer.toJson<String>(fallaReportada),
    };
  }

  Equipo copyWith(
          {int? id,
          String? tipo,
          String? marca,
          String? modelo,
          String? numeroSerie,
          String? nombreDueno,
          String? telefonoDueno,
          String? fallaReportada}) =>
      Equipo(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        marca: marca ?? this.marca,
        modelo: modelo ?? this.modelo,
        numeroSerie: numeroSerie ?? this.numeroSerie,
        nombreDueno: nombreDueno ?? this.nombreDueno,
        telefonoDueno: telefonoDueno ?? this.telefonoDueno,
        fallaReportada: fallaReportada ?? this.fallaReportada,
      );
  Equipo copyWithCompanion(EquiposCompanion data) {
    return Equipo(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      marca: data.marca.present ? data.marca.value : this.marca,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      numeroSerie:
          data.numeroSerie.present ? data.numeroSerie.value : this.numeroSerie,
      nombreDueno:
          data.nombreDueno.present ? data.nombreDueno.value : this.nombreDueno,
      telefonoDueno: data.telefonoDueno.present
          ? data.telefonoDueno.value
          : this.telefonoDueno,
      fallaReportada: data.fallaReportada.present
          ? data.fallaReportada.value
          : this.fallaReportada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Equipo(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('numeroSerie: $numeroSerie, ')
          ..write('nombreDueno: $nombreDueno, ')
          ..write('telefonoDueno: $telefonoDueno, ')
          ..write('fallaReportada: $fallaReportada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tipo, marca, modelo, numeroSerie,
      nombreDueno, telefonoDueno, fallaReportada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Equipo &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.marca == this.marca &&
          other.modelo == this.modelo &&
          other.numeroSerie == this.numeroSerie &&
          other.nombreDueno == this.nombreDueno &&
          other.telefonoDueno == this.telefonoDueno &&
          other.fallaReportada == this.fallaReportada);
}

class EquiposCompanion extends UpdateCompanion<Equipo> {
  final Value<int> id;
  final Value<String> tipo;
  final Value<String> marca;
  final Value<String> modelo;
  final Value<String> numeroSerie;
  final Value<String> nombreDueno;
  final Value<String> telefonoDueno;
  final Value<String> fallaReportada;
  const EquiposCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.marca = const Value.absent(),
    this.modelo = const Value.absent(),
    this.numeroSerie = const Value.absent(),
    this.nombreDueno = const Value.absent(),
    this.telefonoDueno = const Value.absent(),
    this.fallaReportada = const Value.absent(),
  });
  EquiposCompanion.insert({
    this.id = const Value.absent(),
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String nombreDueno,
    required String telefonoDueno,
    required String fallaReportada,
  })  : tipo = Value(tipo),
        marca = Value(marca),
        modelo = Value(modelo),
        numeroSerie = Value(numeroSerie),
        nombreDueno = Value(nombreDueno),
        telefonoDueno = Value(telefonoDueno),
        fallaReportada = Value(fallaReportada);
  static Insertable<Equipo> custom({
    Expression<int>? id,
    Expression<String>? tipo,
    Expression<String>? marca,
    Expression<String>? modelo,
    Expression<String>? numeroSerie,
    Expression<String>? nombreDueno,
    Expression<String>? telefonoDueno,
    Expression<String>? fallaReportada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (marca != null) 'marca': marca,
      if (modelo != null) 'modelo': modelo,
      if (numeroSerie != null) 'numero_serie': numeroSerie,
      if (nombreDueno != null) 'nombre_dueno': nombreDueno,
      if (telefonoDueno != null) 'telefono_dueno': telefonoDueno,
      if (fallaReportada != null) 'falla_reportada': fallaReportada,
    });
  }

  EquiposCompanion copyWith(
      {Value<int>? id,
      Value<String>? tipo,
      Value<String>? marca,
      Value<String>? modelo,
      Value<String>? numeroSerie,
      Value<String>? nombreDueno,
      Value<String>? telefonoDueno,
      Value<String>? fallaReportada}) {
    return EquiposCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      numeroSerie: numeroSerie ?? this.numeroSerie,
      nombreDueno: nombreDueno ?? this.nombreDueno,
      telefonoDueno: telefonoDueno ?? this.telefonoDueno,
      fallaReportada: fallaReportada ?? this.fallaReportada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (numeroSerie.present) {
      map['numero_serie'] = Variable<String>(numeroSerie.value);
    }
    if (nombreDueno.present) {
      map['nombre_dueno'] = Variable<String>(nombreDueno.value);
    }
    if (telefonoDueno.present) {
      map['telefono_dueno'] = Variable<String>(telefonoDueno.value);
    }
    if (fallaReportada.present) {
      map['falla_reportada'] = Variable<String>(fallaReportada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquiposCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('numeroSerie: $numeroSerie, ')
          ..write('nombreDueno: $nombreDueno, ')
          ..write('telefonoDueno: $telefonoDueno, ')
          ..write('fallaReportada: $fallaReportada')
          ..write(')'))
        .toString();
  }
}

class $OrdenesReparacionTable extends OrdenesReparacion
    with TableInfo<$OrdenesReparacionTable, OrdenReparacion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenesReparacionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _equipoIdMeta =
      const VerificationMeta('equipoId');
  @override
  late final GeneratedColumn<int> equipoId = GeneratedColumn<int>(
      'equipo_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tecnicoIdMeta =
      const VerificationMeta('tecnicoId');
  @override
  late final GeneratedColumn<int> tecnicoId = GeneratedColumn<int>(
      'tecnico_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<EstadoOrden, int> estado =
      GeneratedColumn<int>('estado', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<EstadoOrden>($OrdenesReparacionTable.$converterestado);
  static const VerificationMeta _costoManoObraMeta =
      const VerificationMeta('costoManoObra');
  @override
  late final GeneratedColumn<double> costoManoObra = GeneratedColumn<double>(
      'costo_mano_obra', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, equipoId, tecnicoId, estado, costoManoObra, fecha];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordenes_reparacion';
  @override
  VerificationContext validateIntegrity(Insertable<OrdenReparacion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('equipo_id')) {
      context.handle(_equipoIdMeta,
          equipoId.isAcceptableOrUnknown(data['equipo_id']!, _equipoIdMeta));
    } else if (isInserting) {
      context.missing(_equipoIdMeta);
    }
    if (data.containsKey('tecnico_id')) {
      context.handle(_tecnicoIdMeta,
          tecnicoId.isAcceptableOrUnknown(data['tecnico_id']!, _tecnicoIdMeta));
    } else if (isInserting) {
      context.missing(_tecnicoIdMeta);
    }
    if (data.containsKey('costo_mano_obra')) {
      context.handle(
          _costoManoObraMeta,
          costoManoObra.isAcceptableOrUnknown(
              data['costo_mano_obra']!, _costoManoObraMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdenReparacion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdenReparacion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      equipoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}equipo_id'])!,
      tecnicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tecnico_id'])!,
      estado: $OrdenesReparacionTable.$converterestado.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!),
      costoManoObra: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}costo_mano_obra'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
    );
  }

  @override
  $OrdenesReparacionTable createAlias(String alias) {
    return $OrdenesReparacionTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EstadoOrden, int, int> $converterestado =
      const EnumIndexConverter<EstadoOrden>(EstadoOrden.values);
}

class OrdenReparacion extends DataClass implements Insertable<OrdenReparacion> {
  final int id;
  final int equipoId;
  final int tecnicoId;
  final EstadoOrden estado;
  final double costoManoObra;
  final DateTime fecha;
  const OrdenReparacion(
      {required this.id,
      required this.equipoId,
      required this.tecnicoId,
      required this.estado,
      required this.costoManoObra,
      required this.fecha});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['equipo_id'] = Variable<int>(equipoId);
    map['tecnico_id'] = Variable<int>(tecnicoId);
    {
      map['estado'] =
          Variable<int>($OrdenesReparacionTable.$converterestado.toSql(estado));
    }
    map['costo_mano_obra'] = Variable<double>(costoManoObra);
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  OrdenesReparacionCompanion toCompanion(bool nullToAbsent) {
    return OrdenesReparacionCompanion(
      id: Value(id),
      equipoId: Value(equipoId),
      tecnicoId: Value(tecnicoId),
      estado: Value(estado),
      costoManoObra: Value(costoManoObra),
      fecha: Value(fecha),
    );
  }

  factory OrdenReparacion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdenReparacion(
      id: serializer.fromJson<int>(json['id']),
      equipoId: serializer.fromJson<int>(json['equipoId']),
      tecnicoId: serializer.fromJson<int>(json['tecnicoId']),
      estado: $OrdenesReparacionTable.$converterestado
          .fromJson(serializer.fromJson<int>(json['estado'])),
      costoManoObra: serializer.fromJson<double>(json['costoManoObra']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'equipoId': serializer.toJson<int>(equipoId),
      'tecnicoId': serializer.toJson<int>(tecnicoId),
      'estado': serializer
          .toJson<int>($OrdenesReparacionTable.$converterestado.toJson(estado)),
      'costoManoObra': serializer.toJson<double>(costoManoObra),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  OrdenReparacion copyWith(
          {int? id,
          int? equipoId,
          int? tecnicoId,
          EstadoOrden? estado,
          double? costoManoObra,
          DateTime? fecha}) =>
      OrdenReparacion(
        id: id ?? this.id,
        equipoId: equipoId ?? this.equipoId,
        tecnicoId: tecnicoId ?? this.tecnicoId,
        estado: estado ?? this.estado,
        costoManoObra: costoManoObra ?? this.costoManoObra,
        fecha: fecha ?? this.fecha,
      );
  OrdenReparacion copyWithCompanion(OrdenesReparacionCompanion data) {
    return OrdenReparacion(
      id: data.id.present ? data.id.value : this.id,
      equipoId: data.equipoId.present ? data.equipoId.value : this.equipoId,
      tecnicoId: data.tecnicoId.present ? data.tecnicoId.value : this.tecnicoId,
      estado: data.estado.present ? data.estado.value : this.estado,
      costoManoObra: data.costoManoObra.present
          ? data.costoManoObra.value
          : this.costoManoObra,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdenReparacion(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('estado: $estado, ')
          ..write('costoManoObra: $costoManoObra, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, equipoId, tecnicoId, estado, costoManoObra, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdenReparacion &&
          other.id == this.id &&
          other.equipoId == this.equipoId &&
          other.tecnicoId == this.tecnicoId &&
          other.estado == this.estado &&
          other.costoManoObra == this.costoManoObra &&
          other.fecha == this.fecha);
}

class OrdenesReparacionCompanion extends UpdateCompanion<OrdenReparacion> {
  final Value<int> id;
  final Value<int> equipoId;
  final Value<int> tecnicoId;
  final Value<EstadoOrden> estado;
  final Value<double> costoManoObra;
  final Value<DateTime> fecha;
  const OrdenesReparacionCompanion({
    this.id = const Value.absent(),
    this.equipoId = const Value.absent(),
    this.tecnicoId = const Value.absent(),
    this.estado = const Value.absent(),
    this.costoManoObra = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  OrdenesReparacionCompanion.insert({
    this.id = const Value.absent(),
    required int equipoId,
    required int tecnicoId,
    required EstadoOrden estado,
    this.costoManoObra = const Value.absent(),
    this.fecha = const Value.absent(),
  })  : equipoId = Value(equipoId),
        tecnicoId = Value(tecnicoId),
        estado = Value(estado);
  static Insertable<OrdenReparacion> custom({
    Expression<int>? id,
    Expression<int>? equipoId,
    Expression<int>? tecnicoId,
    Expression<int>? estado,
    Expression<double>? costoManoObra,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (equipoId != null) 'equipo_id': equipoId,
      if (tecnicoId != null) 'tecnico_id': tecnicoId,
      if (estado != null) 'estado': estado,
      if (costoManoObra != null) 'costo_mano_obra': costoManoObra,
      if (fecha != null) 'fecha': fecha,
    });
  }

  OrdenesReparacionCompanion copyWith(
      {Value<int>? id,
      Value<int>? equipoId,
      Value<int>? tecnicoId,
      Value<EstadoOrden>? estado,
      Value<double>? costoManoObra,
      Value<DateTime>? fecha}) {
    return OrdenesReparacionCompanion(
      id: id ?? this.id,
      equipoId: equipoId ?? this.equipoId,
      tecnicoId: tecnicoId ?? this.tecnicoId,
      estado: estado ?? this.estado,
      costoManoObra: costoManoObra ?? this.costoManoObra,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (equipoId.present) {
      map['equipo_id'] = Variable<int>(equipoId.value);
    }
    if (tecnicoId.present) {
      map['tecnico_id'] = Variable<int>(tecnicoId.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(
          $OrdenesReparacionTable.$converterestado.toSql(estado.value));
    }
    if (costoManoObra.present) {
      map['costo_mano_obra'] = Variable<double>(costoManoObra.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesReparacionCompanion(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('estado: $estado, ')
          ..write('costoManoObra: $costoManoObra, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $RepuestosTable extends Repuestos
    with TableInfo<$RepuestosTable, Repuesto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
      'precio', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stockMinimoMeta =
      const VerificationMeta('stockMinimo');
  @override
  late final GeneratedColumn<int> stockMinimo = GeneratedColumn<int>(
      'stock_minimo', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, codigo, precio, stock, stockMinimo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos';
  @override
  VerificationContext validateIntegrity(Insertable<Repuesto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(_precioMeta,
          precio.isAcceptableOrUnknown(data['precio']!, _precioMeta));
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
          _stockMinimoMeta,
          stockMinimo.isAcceptableOrUnknown(
              data['stock_minimo']!, _stockMinimoMeta));
    } else if (isInserting) {
      context.missing(_stockMinimoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Repuesto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Repuesto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      precio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}precio'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      stockMinimo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_minimo'])!,
    );
  }

  @override
  $RepuestosTable createAlias(String alias) {
    return $RepuestosTable(attachedDatabase, alias);
  }
}

class Repuesto extends DataClass implements Insertable<Repuesto> {
  final int id;
  final String nombre;
  final String codigo;
  final double precio;
  final int stock;
  final int stockMinimo;
  const Repuesto(
      {required this.id,
      required this.nombre,
      required this.codigo,
      required this.precio,
      required this.stock,
      required this.stockMinimo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['codigo'] = Variable<String>(codigo);
    map['precio'] = Variable<double>(precio);
    map['stock'] = Variable<int>(stock);
    map['stock_minimo'] = Variable<int>(stockMinimo);
    return map;
  }

  RepuestosCompanion toCompanion(bool nullToAbsent) {
    return RepuestosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      codigo: Value(codigo),
      precio: Value(precio),
      stock: Value(stock),
      stockMinimo: Value(stockMinimo),
    );
  }

  factory Repuesto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Repuesto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      codigo: serializer.fromJson<String>(json['codigo']),
      precio: serializer.fromJson<double>(json['precio']),
      stock: serializer.fromJson<int>(json['stock']),
      stockMinimo: serializer.fromJson<int>(json['stockMinimo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'codigo': serializer.toJson<String>(codigo),
      'precio': serializer.toJson<double>(precio),
      'stock': serializer.toJson<int>(stock),
      'stockMinimo': serializer.toJson<int>(stockMinimo),
    };
  }

  Repuesto copyWith(
          {int? id,
          String? nombre,
          String? codigo,
          double? precio,
          int? stock,
          int? stockMinimo}) =>
      Repuesto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        codigo: codigo ?? this.codigo,
        precio: precio ?? this.precio,
        stock: stock ?? this.stock,
        stockMinimo: stockMinimo ?? this.stockMinimo,
      );
  Repuesto copyWithCompanion(RepuestosCompanion data) {
    return Repuesto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      precio: data.precio.present ? data.precio.value : this.precio,
      stock: data.stock.present ? data.stock.value : this.stock,
      stockMinimo:
          data.stockMinimo.present ? data.stockMinimo.value : this.stockMinimo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Repuesto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precio: $precio, ')
          ..write('stock: $stock, ')
          ..write('stockMinimo: $stockMinimo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, codigo, precio, stock, stockMinimo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Repuesto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.codigo == this.codigo &&
          other.precio == this.precio &&
          other.stock == this.stock &&
          other.stockMinimo == this.stockMinimo);
}

class RepuestosCompanion extends UpdateCompanion<Repuesto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> codigo;
  final Value<double> precio;
  final Value<int> stock;
  final Value<int> stockMinimo;
  const RepuestosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.codigo = const Value.absent(),
    this.precio = const Value.absent(),
    this.stock = const Value.absent(),
    this.stockMinimo = const Value.absent(),
  });
  RepuestosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String codigo,
    required double precio,
    required int stock,
    required int stockMinimo,
  })  : nombre = Value(nombre),
        codigo = Value(codigo),
        precio = Value(precio),
        stock = Value(stock),
        stockMinimo = Value(stockMinimo);
  static Insertable<Repuesto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? codigo,
    Expression<double>? precio,
    Expression<int>? stock,
    Expression<int>? stockMinimo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (codigo != null) 'codigo': codigo,
      if (precio != null) 'precio': precio,
      if (stock != null) 'stock': stock,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
    });
  }

  RepuestosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String>? codigo,
      Value<double>? precio,
      Value<int>? stock,
      Value<int>? stockMinimo}) {
    return RepuestosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      codigo: codigo ?? this.codigo,
      precio: precio ?? this.precio,
      stock: stock ?? this.stock,
      stockMinimo: stockMinimo ?? this.stockMinimo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<int>(stockMinimo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precio: $precio, ')
          ..write('stock: $stock, ')
          ..write('stockMinimo: $stockMinimo')
          ..write(')'))
        .toString();
  }
}

class $RepuestosUsadosTable extends RepuestosUsados
    with TableInfo<$RepuestosUsadosTable, RepuestoUsado> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosUsadosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repuestoIdMeta =
      const VerificationMeta('repuestoId');
  @override
  late final GeneratedColumn<int> repuestoId = GeneratedColumn<int>(
      'repuesto_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ordenId, repuestoId, cantidad];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos_usados';
  @override
  VerificationContext validateIntegrity(Insertable<RepuestoUsado> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('repuesto_id')) {
      context.handle(
          _repuestoIdMeta,
          repuestoId.isAcceptableOrUnknown(
              data['repuesto_id']!, _repuestoIdMeta));
    } else if (isInserting) {
      context.missing(_repuestoIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepuestoUsado map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepuestoUsado(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      repuestoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repuesto_id'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
    );
  }

  @override
  $RepuestosUsadosTable createAlias(String alias) {
    return $RepuestosUsadosTable(attachedDatabase, alias);
  }
}

class RepuestoUsado extends DataClass implements Insertable<RepuestoUsado> {
  final int id;
  final int ordenId;
  final int repuestoId;
  final int cantidad;
  const RepuestoUsado(
      {required this.id,
      required this.ordenId,
      required this.repuestoId,
      required this.cantidad});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['repuesto_id'] = Variable<int>(repuestoId);
    map['cantidad'] = Variable<int>(cantidad);
    return map;
  }

  RepuestosUsadosCompanion toCompanion(bool nullToAbsent) {
    return RepuestosUsadosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      repuestoId: Value(repuestoId),
      cantidad: Value(cantidad),
    );
  }

  factory RepuestoUsado.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepuestoUsado(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      repuestoId: serializer.fromJson<int>(json['repuestoId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'repuestoId': serializer.toJson<int>(repuestoId),
      'cantidad': serializer.toJson<int>(cantidad),
    };
  }

  RepuestoUsado copyWith(
          {int? id, int? ordenId, int? repuestoId, int? cantidad}) =>
      RepuestoUsado(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        repuestoId: repuestoId ?? this.repuestoId,
        cantidad: cantidad ?? this.cantidad,
      );
  RepuestoUsado copyWithCompanion(RepuestosUsadosCompanion data) {
    return RepuestoUsado(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      repuestoId:
          data.repuestoId.present ? data.repuestoId.value : this.repuestoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepuestoUsado(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ordenId, repuestoId, cantidad);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepuestoUsado &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.repuestoId == this.repuestoId &&
          other.cantidad == this.cantidad);
}

class RepuestosUsadosCompanion extends UpdateCompanion<RepuestoUsado> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<int> repuestoId;
  final Value<int> cantidad;
  const RepuestosUsadosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.repuestoId = const Value.absent(),
    this.cantidad = const Value.absent(),
  });
  RepuestosUsadosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required int repuestoId,
    required int cantidad,
  })  : ordenId = Value(ordenId),
        repuestoId = Value(repuestoId),
        cantidad = Value(cantidad);
  static Insertable<RepuestoUsado> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<int>? repuestoId,
    Expression<int>? cantidad,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (repuestoId != null) 'repuesto_id': repuestoId,
      if (cantidad != null) 'cantidad': cantidad,
    });
  }

  RepuestosUsadosCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<int>? repuestoId,
      Value<int>? cantidad}) {
    return RepuestosUsadosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      repuestoId: repuestoId ?? this.repuestoId,
      cantidad: cantidad ?? this.cantidad,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (repuestoId.present) {
      map['repuesto_id'] = Variable<int>(repuestoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosUsadosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad')
          ..write(')'))
        .toString();
  }
}

class $TrabajosRealizadosTable extends TrabajosRealizados
    with TableInfo<$TrabajosRealizadosTable, TrabajoRealizado> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrabajosRealizadosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _costoManoObraMeta =
      const VerificationMeta('costoManoObra');
  @override
  late final GeneratedColumn<double> costoManoObra = GeneratedColumn<double>(
      'costo_mano_obra', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ordenId, descripcion, costoManoObra];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trabajos_realizados';
  @override
  VerificationContext validateIntegrity(Insertable<TrabajoRealizado> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('costo_mano_obra')) {
      context.handle(
          _costoManoObraMeta,
          costoManoObra.isAcceptableOrUnknown(
              data['costo_mano_obra']!, _costoManoObraMeta));
    } else if (isInserting) {
      context.missing(_costoManoObraMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrabajoRealizado map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrabajoRealizado(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      costoManoObra: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}costo_mano_obra'])!,
    );
  }

  @override
  $TrabajosRealizadosTable createAlias(String alias) {
    return $TrabajosRealizadosTable(attachedDatabase, alias);
  }
}

class TrabajoRealizado extends DataClass
    implements Insertable<TrabajoRealizado> {
  final int id;
  final int ordenId;
  final String descripcion;
  final double costoManoObra;
  const TrabajoRealizado(
      {required this.id,
      required this.ordenId,
      required this.descripcion,
      required this.costoManoObra});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['descripcion'] = Variable<String>(descripcion);
    map['costo_mano_obra'] = Variable<double>(costoManoObra);
    return map;
  }

  TrabajosRealizadosCompanion toCompanion(bool nullToAbsent) {
    return TrabajosRealizadosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      descripcion: Value(descripcion),
      costoManoObra: Value(costoManoObra),
    );
  }

  factory TrabajoRealizado.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrabajoRealizado(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      costoManoObra: serializer.fromJson<double>(json['costoManoObra']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'descripcion': serializer.toJson<String>(descripcion),
      'costoManoObra': serializer.toJson<double>(costoManoObra),
    };
  }

  TrabajoRealizado copyWith(
          {int? id,
          int? ordenId,
          String? descripcion,
          double? costoManoObra}) =>
      TrabajoRealizado(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        descripcion: descripcion ?? this.descripcion,
        costoManoObra: costoManoObra ?? this.costoManoObra,
      );
  TrabajoRealizado copyWithCompanion(TrabajosRealizadosCompanion data) {
    return TrabajoRealizado(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      costoManoObra: data.costoManoObra.present
          ? data.costoManoObra.value
          : this.costoManoObra,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrabajoRealizado(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costoManoObra: $costoManoObra')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ordenId, descripcion, costoManoObra);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrabajoRealizado &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.descripcion == this.descripcion &&
          other.costoManoObra == this.costoManoObra);
}

class TrabajosRealizadosCompanion extends UpdateCompanion<TrabajoRealizado> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<String> descripcion;
  final Value<double> costoManoObra;
  const TrabajosRealizadosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.costoManoObra = const Value.absent(),
  });
  TrabajosRealizadosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required String descripcion,
    required double costoManoObra,
  })  : ordenId = Value(ordenId),
        descripcion = Value(descripcion),
        costoManoObra = Value(costoManoObra);
  static Insertable<TrabajoRealizado> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<String>? descripcion,
    Expression<double>? costoManoObra,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (descripcion != null) 'descripcion': descripcion,
      if (costoManoObra != null) 'costo_mano_obra': costoManoObra,
    });
  }

  TrabajosRealizadosCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<String>? descripcion,
      Value<double>? costoManoObra}) {
    return TrabajosRealizadosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      descripcion: descripcion ?? this.descripcion,
      costoManoObra: costoManoObra ?? this.costoManoObra,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (costoManoObra.present) {
      map['costo_mano_obra'] = Variable<double>(costoManoObra.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrabajosRealizadosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costoManoObra: $costoManoObra')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TecnicosTable tecnicos = $TecnicosTable(this);
  late final $EquiposTable equipos = $EquiposTable(this);
  late final $OrdenesReparacionTable ordenesReparacion =
      $OrdenesReparacionTable(this);
  late final $RepuestosTable repuestos = $RepuestosTable(this);
  late final $RepuestosUsadosTable repuestosUsados =
      $RepuestosUsadosTable(this);
  late final $TrabajosRealizadosTable trabajosRealizados =
      $TrabajosRealizadosTable(this);
  late final TecnicosDao tecnicosDao = TecnicosDao(this as AppDatabase);
  late final EquiposDao equiposDao = EquiposDao(this as AppDatabase);
  late final OrdenesDao ordenesDao = OrdenesDao(this as AppDatabase);
  late final InventarioDao inventarioDao = InventarioDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        tecnicos,
        equipos,
        ordenesReparacion,
        repuestos,
        repuestosUsados,
        trabajosRealizados
      ];
}

typedef $$TecnicosTableCreateCompanionBuilder = TecnicosCompanion Function({
  Value<int> id,
  required String nombre,
});
typedef $$TecnicosTableUpdateCompanionBuilder = TecnicosCompanion Function({
  Value<int> id,
  Value<String> nombre,
});

class $$TecnicosTableFilterComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));
}

class $$TecnicosTableOrderingComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));
}

class $$TecnicosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);
}

class $$TecnicosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TecnicosTable,
    Tecnico,
    $$TecnicosTableFilterComposer,
    $$TecnicosTableOrderingComposer,
    $$TecnicosTableAnnotationComposer,
    $$TecnicosTableCreateCompanionBuilder,
    $$TecnicosTableUpdateCompanionBuilder,
    (Tecnico, BaseReferences<_$AppDatabase, $TecnicosTable, Tecnico>),
    Tecnico,
    PrefetchHooks Function()> {
  $$TecnicosTableTableManager(_$AppDatabase db, $TecnicosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TecnicosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TecnicosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TecnicosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
          }) =>
              TecnicosCompanion(
            id: id,
            nombre: nombre,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
          }) =>
              TecnicosCompanion.insert(
            id: id,
            nombre: nombre,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TecnicosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TecnicosTable,
    Tecnico,
    $$TecnicosTableFilterComposer,
    $$TecnicosTableOrderingComposer,
    $$TecnicosTableAnnotationComposer,
    $$TecnicosTableCreateCompanionBuilder,
    $$TecnicosTableUpdateCompanionBuilder,
    (Tecnico, BaseReferences<_$AppDatabase, $TecnicosTable, Tecnico>),
    Tecnico,
    PrefetchHooks Function()>;
typedef $$EquiposTableCreateCompanionBuilder = EquiposCompanion Function({
  Value<int> id,
  required String tipo,
  required String marca,
  required String modelo,
  required String numeroSerie,
  required String nombreDueno,
  required String telefonoDueno,
  required String fallaReportada,
});
typedef $$EquiposTableUpdateCompanionBuilder = EquiposCompanion Function({
  Value<int> id,
  Value<String> tipo,
  Value<String> marca,
  Value<String> modelo,
  Value<String> numeroSerie,
  Value<String> nombreDueno,
  Value<String> telefonoDueno,
  Value<String> fallaReportada,
});

class $$EquiposTableFilterComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombreDueno => $composableBuilder(
      column: $table.nombreDueno, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefonoDueno => $composableBuilder(
      column: $table.telefonoDueno, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fallaReportada => $composableBuilder(
      column: $table.fallaReportada,
      builder: (column) => ColumnFilters(column));
}

class $$EquiposTableOrderingComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombreDueno => $composableBuilder(
      column: $table.nombreDueno, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefonoDueno => $composableBuilder(
      column: $table.telefonoDueno,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fallaReportada => $composableBuilder(
      column: $table.fallaReportada,
      builder: (column) => ColumnOrderings(column));
}

class $$EquiposTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => column);

  GeneratedColumn<String> get nombreDueno => $composableBuilder(
      column: $table.nombreDueno, builder: (column) => column);

  GeneratedColumn<String> get telefonoDueno => $composableBuilder(
      column: $table.telefonoDueno, builder: (column) => column);

  GeneratedColumn<String> get fallaReportada => $composableBuilder(
      column: $table.fallaReportada, builder: (column) => column);
}

class $$EquiposTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EquiposTable,
    Equipo,
    $$EquiposTableFilterComposer,
    $$EquiposTableOrderingComposer,
    $$EquiposTableAnnotationComposer,
    $$EquiposTableCreateCompanionBuilder,
    $$EquiposTableUpdateCompanionBuilder,
    (Equipo, BaseReferences<_$AppDatabase, $EquiposTable, Equipo>),
    Equipo,
    PrefetchHooks Function()> {
  $$EquiposTableTableManager(_$AppDatabase db, $EquiposTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquiposTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquiposTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquiposTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String> marca = const Value.absent(),
            Value<String> modelo = const Value.absent(),
            Value<String> numeroSerie = const Value.absent(),
            Value<String> nombreDueno = const Value.absent(),
            Value<String> telefonoDueno = const Value.absent(),
            Value<String> fallaReportada = const Value.absent(),
          }) =>
              EquiposCompanion(
            id: id,
            tipo: tipo,
            marca: marca,
            modelo: modelo,
            numeroSerie: numeroSerie,
            nombreDueno: nombreDueno,
            telefonoDueno: telefonoDueno,
            fallaReportada: fallaReportada,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String tipo,
            required String marca,
            required String modelo,
            required String numeroSerie,
            required String nombreDueno,
            required String telefonoDueno,
            required String fallaReportada,
          }) =>
              EquiposCompanion.insert(
            id: id,
            tipo: tipo,
            marca: marca,
            modelo: modelo,
            numeroSerie: numeroSerie,
            nombreDueno: nombreDueno,
            telefonoDueno: telefonoDueno,
            fallaReportada: fallaReportada,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EquiposTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EquiposTable,
    Equipo,
    $$EquiposTableFilterComposer,
    $$EquiposTableOrderingComposer,
    $$EquiposTableAnnotationComposer,
    $$EquiposTableCreateCompanionBuilder,
    $$EquiposTableUpdateCompanionBuilder,
    (Equipo, BaseReferences<_$AppDatabase, $EquiposTable, Equipo>),
    Equipo,
    PrefetchHooks Function()>;
typedef $$OrdenesReparacionTableCreateCompanionBuilder
    = OrdenesReparacionCompanion Function({
  Value<int> id,
  required int equipoId,
  required int tecnicoId,
  required EstadoOrden estado,
  Value<double> costoManoObra,
  Value<DateTime> fecha,
});
typedef $$OrdenesReparacionTableUpdateCompanionBuilder
    = OrdenesReparacionCompanion Function({
  Value<int> id,
  Value<int> equipoId,
  Value<int> tecnicoId,
  Value<EstadoOrden> estado,
  Value<double> costoManoObra,
  Value<DateTime> fecha,
});

class $$OrdenesReparacionTableFilterComposer
    extends Composer<_$AppDatabase, $OrdenesReparacionTable> {
  $$OrdenesReparacionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get equipoId => $composableBuilder(
      column: $table.equipoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tecnicoId => $composableBuilder(
      column: $table.tecnicoId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<EstadoOrden, EstadoOrden, int> get estado =>
      $composableBuilder(
          column: $table.estado,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));
}

class $$OrdenesReparacionTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdenesReparacionTable> {
  $$OrdenesReparacionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get equipoId => $composableBuilder(
      column: $table.equipoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tecnicoId => $composableBuilder(
      column: $table.tecnicoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));
}

class $$OrdenesReparacionTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdenesReparacionTable> {
  $$OrdenesReparacionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get equipoId =>
      $composableBuilder(column: $table.equipoId, builder: (column) => column);

  GeneratedColumn<int> get tecnicoId =>
      $composableBuilder(column: $table.tecnicoId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EstadoOrden, int> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$OrdenesReparacionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdenesReparacionTable,
    OrdenReparacion,
    $$OrdenesReparacionTableFilterComposer,
    $$OrdenesReparacionTableOrderingComposer,
    $$OrdenesReparacionTableAnnotationComposer,
    $$OrdenesReparacionTableCreateCompanionBuilder,
    $$OrdenesReparacionTableUpdateCompanionBuilder,
    (
      OrdenReparacion,
      BaseReferences<_$AppDatabase, $OrdenesReparacionTable, OrdenReparacion>
    ),
    OrdenReparacion,
    PrefetchHooks Function()> {
  $$OrdenesReparacionTableTableManager(
      _$AppDatabase db, $OrdenesReparacionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenesReparacionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenesReparacionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenesReparacionTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> equipoId = const Value.absent(),
            Value<int> tecnicoId = const Value.absent(),
            Value<EstadoOrden> estado = const Value.absent(),
            Value<double> costoManoObra = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
          }) =>
              OrdenesReparacionCompanion(
            id: id,
            equipoId: equipoId,
            tecnicoId: tecnicoId,
            estado: estado,
            costoManoObra: costoManoObra,
            fecha: fecha,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int equipoId,
            required int tecnicoId,
            required EstadoOrden estado,
            Value<double> costoManoObra = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
          }) =>
              OrdenesReparacionCompanion.insert(
            id: id,
            equipoId: equipoId,
            tecnicoId: tecnicoId,
            estado: estado,
            costoManoObra: costoManoObra,
            fecha: fecha,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrdenesReparacionTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdenesReparacionTable,
    OrdenReparacion,
    $$OrdenesReparacionTableFilterComposer,
    $$OrdenesReparacionTableOrderingComposer,
    $$OrdenesReparacionTableAnnotationComposer,
    $$OrdenesReparacionTableCreateCompanionBuilder,
    $$OrdenesReparacionTableUpdateCompanionBuilder,
    (
      OrdenReparacion,
      BaseReferences<_$AppDatabase, $OrdenesReparacionTable, OrdenReparacion>
    ),
    OrdenReparacion,
    PrefetchHooks Function()>;
typedef $$RepuestosTableCreateCompanionBuilder = RepuestosCompanion Function({
  Value<int> id,
  required String nombre,
  required String codigo,
  required double precio,
  required int stock,
  required int stockMinimo,
});
typedef $$RepuestosTableUpdateCompanionBuilder = RepuestosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> codigo,
  Value<double> precio,
  Value<int> stock,
  Value<int> stockMinimo,
});

class $$RepuestosTableFilterComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnFilters(column));
}

class $$RepuestosTableOrderingComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precio => $composableBuilder(
      column: $table.precio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnOrderings(column));
}

class $$RepuestosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => column);
}

class $$RepuestosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepuestosTable,
    Repuesto,
    $$RepuestosTableFilterComposer,
    $$RepuestosTableOrderingComposer,
    $$RepuestosTableAnnotationComposer,
    $$RepuestosTableCreateCompanionBuilder,
    $$RepuestosTableUpdateCompanionBuilder,
    (Repuesto, BaseReferences<_$AppDatabase, $RepuestosTable, Repuesto>),
    Repuesto,
    PrefetchHooks Function()> {
  $$RepuestosTableTableManager(_$AppDatabase db, $RepuestosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<double> precio = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<int> stockMinimo = const Value.absent(),
          }) =>
              RepuestosCompanion(
            id: id,
            nombre: nombre,
            codigo: codigo,
            precio: precio,
            stock: stock,
            stockMinimo: stockMinimo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required String codigo,
            required double precio,
            required int stock,
            required int stockMinimo,
          }) =>
              RepuestosCompanion.insert(
            id: id,
            nombre: nombre,
            codigo: codigo,
            precio: precio,
            stock: stock,
            stockMinimo: stockMinimo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RepuestosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepuestosTable,
    Repuesto,
    $$RepuestosTableFilterComposer,
    $$RepuestosTableOrderingComposer,
    $$RepuestosTableAnnotationComposer,
    $$RepuestosTableCreateCompanionBuilder,
    $$RepuestosTableUpdateCompanionBuilder,
    (Repuesto, BaseReferences<_$AppDatabase, $RepuestosTable, Repuesto>),
    Repuesto,
    PrefetchHooks Function()>;
typedef $$RepuestosUsadosTableCreateCompanionBuilder = RepuestosUsadosCompanion
    Function({
  Value<int> id,
  required int ordenId,
  required int repuestoId,
  required int cantidad,
});
typedef $$RepuestosUsadosTableUpdateCompanionBuilder = RepuestosUsadosCompanion
    Function({
  Value<int> id,
  Value<int> ordenId,
  Value<int> repuestoId,
  Value<int> cantidad,
});

class $$RepuestosUsadosTableFilterComposer
    extends Composer<_$AppDatabase, $RepuestosUsadosTable> {
  $$RepuestosUsadosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));
}

class $$RepuestosUsadosTableOrderingComposer
    extends Composer<_$AppDatabase, $RepuestosUsadosTable> {
  $$RepuestosUsadosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));
}

class $$RepuestosUsadosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepuestosUsadosTable> {
  $$RepuestosUsadosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordenId =>
      $composableBuilder(column: $table.ordenId, builder: (column) => column);

  GeneratedColumn<int> get repuestoId => $composableBuilder(
      column: $table.repuestoId, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);
}

class $$RepuestosUsadosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepuestosUsadosTable,
    RepuestoUsado,
    $$RepuestosUsadosTableFilterComposer,
    $$RepuestosUsadosTableOrderingComposer,
    $$RepuestosUsadosTableAnnotationComposer,
    $$RepuestosUsadosTableCreateCompanionBuilder,
    $$RepuestosUsadosTableUpdateCompanionBuilder,
    (
      RepuestoUsado,
      BaseReferences<_$AppDatabase, $RepuestosUsadosTable, RepuestoUsado>
    ),
    RepuestoUsado,
    PrefetchHooks Function()> {
  $$RepuestosUsadosTableTableManager(
      _$AppDatabase db, $RepuestosUsadosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosUsadosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosUsadosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosUsadosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<int> repuestoId = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
          }) =>
              RepuestosUsadosCompanion(
            id: id,
            ordenId: ordenId,
            repuestoId: repuestoId,
            cantidad: cantidad,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required int repuestoId,
            required int cantidad,
          }) =>
              RepuestosUsadosCompanion.insert(
            id: id,
            ordenId: ordenId,
            repuestoId: repuestoId,
            cantidad: cantidad,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RepuestosUsadosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepuestosUsadosTable,
    RepuestoUsado,
    $$RepuestosUsadosTableFilterComposer,
    $$RepuestosUsadosTableOrderingComposer,
    $$RepuestosUsadosTableAnnotationComposer,
    $$RepuestosUsadosTableCreateCompanionBuilder,
    $$RepuestosUsadosTableUpdateCompanionBuilder,
    (
      RepuestoUsado,
      BaseReferences<_$AppDatabase, $RepuestosUsadosTable, RepuestoUsado>
    ),
    RepuestoUsado,
    PrefetchHooks Function()>;
typedef $$TrabajosRealizadosTableCreateCompanionBuilder
    = TrabajosRealizadosCompanion Function({
  Value<int> id,
  required int ordenId,
  required String descripcion,
  required double costoManoObra,
});
typedef $$TrabajosRealizadosTableUpdateCompanionBuilder
    = TrabajosRealizadosCompanion Function({
  Value<int> id,
  Value<int> ordenId,
  Value<String> descripcion,
  Value<double> costoManoObra,
});

class $$TrabajosRealizadosTableFilterComposer
    extends Composer<_$AppDatabase, $TrabajosRealizadosTable> {
  $$TrabajosRealizadosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra, builder: (column) => ColumnFilters(column));
}

class $$TrabajosRealizadosTableOrderingComposer
    extends Composer<_$AppDatabase, $TrabajosRealizadosTable> {
  $$TrabajosRealizadosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordenId => $composableBuilder(
      column: $table.ordenId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra,
      builder: (column) => ColumnOrderings(column));
}

class $$TrabajosRealizadosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrabajosRealizadosTable> {
  $$TrabajosRealizadosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordenId =>
      $composableBuilder(column: $table.ordenId, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<double> get costoManoObra => $composableBuilder(
      column: $table.costoManoObra, builder: (column) => column);
}

class $$TrabajosRealizadosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrabajosRealizadosTable,
    TrabajoRealizado,
    $$TrabajosRealizadosTableFilterComposer,
    $$TrabajosRealizadosTableOrderingComposer,
    $$TrabajosRealizadosTableAnnotationComposer,
    $$TrabajosRealizadosTableCreateCompanionBuilder,
    $$TrabajosRealizadosTableUpdateCompanionBuilder,
    (
      TrabajoRealizado,
      BaseReferences<_$AppDatabase, $TrabajosRealizadosTable, TrabajoRealizado>
    ),
    TrabajoRealizado,
    PrefetchHooks Function()> {
  $$TrabajosRealizadosTableTableManager(
      _$AppDatabase db, $TrabajosRealizadosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrabajosRealizadosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrabajosRealizadosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrabajosRealizadosTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<double> costoManoObra = const Value.absent(),
          }) =>
              TrabajosRealizadosCompanion(
            id: id,
            ordenId: ordenId,
            descripcion: descripcion,
            costoManoObra: costoManoObra,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required String descripcion,
            required double costoManoObra,
          }) =>
              TrabajosRealizadosCompanion.insert(
            id: id,
            ordenId: ordenId,
            descripcion: descripcion,
            costoManoObra: costoManoObra,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TrabajosRealizadosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrabajosRealizadosTable,
    TrabajoRealizado,
    $$TrabajosRealizadosTableFilterComposer,
    $$TrabajosRealizadosTableOrderingComposer,
    $$TrabajosRealizadosTableAnnotationComposer,
    $$TrabajosRealizadosTableCreateCompanionBuilder,
    $$TrabajosRealizadosTableUpdateCompanionBuilder,
    (
      TrabajoRealizado,
      BaseReferences<_$AppDatabase, $TrabajosRealizadosTable, TrabajoRealizado>
    ),
    TrabajoRealizado,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TecnicosTableTableManager get tecnicos =>
      $$TecnicosTableTableManager(_db, _db.tecnicos);
  $$EquiposTableTableManager get equipos =>
      $$EquiposTableTableManager(_db, _db.equipos);
  $$OrdenesReparacionTableTableManager get ordenesReparacion =>
      $$OrdenesReparacionTableTableManager(_db, _db.ordenesReparacion);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db, _db.repuestos);
  $$RepuestosUsadosTableTableManager get repuestosUsados =>
      $$RepuestosUsadosTableTableManager(_db, _db.repuestosUsados);
  $$TrabajosRealizadosTableTableManager get trabajosRealizados =>
      $$TrabajosRealizadosTableTableManager(_db, _db.trabajosRealizados);
}
