import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/daos.dart';
import '../database/database.dart';
import '../providers/database_provider.dart';

class CrearOrdenViewModel {
  final OrdenesDao _dao;
  const CrearOrdenViewModel(this._dao);

  /// Devuelve el id de la orden creada. Lanza TallerException si el equipo
  /// ya tiene una orden abierta.
  Future<int> crear({
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String nombreDueno,
    required String telefonoDueno,
    required String fallaReportada,
    required int tecnicoId,
  }) {
    return _dao.crearOrden(
      tipo: tipo,
      marca: marca,
      modelo: modelo,
      numeroSerie: numeroSerie,
      nombreDueno: nombreDueno,
      telefonoDueno: telefonoDueno,
      fallaReportada: fallaReportada,
      tecnicoId: tecnicoId,
    );
  }

  /// Edita una orden existente. Lanza TallerException si el número de serie
  /// ya pertenece a otro equipo.
  Future<void> editar({
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
    return _dao.actualizarOrden(
      ordenId: ordenId,
      tipo: tipo,
      marca: marca,
      modelo: modelo,
      numeroSerie: numeroSerie,
      nombreDueno: nombreDueno,
      telefonoDueno: telefonoDueno,
      fallaReportada: fallaReportada,
      tecnicoId: tecnicoId,
    );
  }
}

final crearOrdenViewModelProvider = Provider<CrearOrdenViewModel>(
  (ref) => CrearOrdenViewModel(ref.watch(ordenesDaoProvider)),
);

// ---------------------------------------------------------------------------
// Sugerencias al escribir (datos de equipos ya guardados)
// ---------------------------------------------------------------------------

/// Equipos registrados, el más reciente primero.
final equiposRegistradosProvider = StreamProvider<List<Equipo>>(
  (ref) => ref.watch(equiposDaoProvider).observarEquipos(),
);

/// Valores distintos ya guardados para cada campo con sugerencias.
class SugerenciasEquipo {
  final List<String> marcas;
  final List<String> modelos;
  final List<String> duenos;
  final List<String> telefonos;

  const SugerenciasEquipo({
    required this.marcas,
    required this.modelos,
    required this.duenos,
    required this.telefonos,
  });

  factory SugerenciasEquipo.desde(List<Equipo> equipos) => SugerenciasEquipo(
        marcas: _unicos(equipos.map((e) => e.marca)),
        modelos: _unicos(equipos.map((e) => e.modelo)),
        duenos: _unicos(equipos.map((e) => e.nombreDueno)),
        telefonos: _unicos(equipos.map((e) => e.telefonoDueno)),
      );
}

/// Quita vacíos y repetidos (sin distinguir mayúsculas), conservando el orden.
List<String> _unicos(Iterable<String> valores) {
  final vistos = <String>{};
  final resultado = <String>[];
  for (final valor in valores) {
    final limpio = valor.trim();
    if (limpio.isEmpty) continue;
    if (vistos.add(limpio.toLowerCase())) resultado.add(limpio);
  }
  return resultado;
}

final sugerenciasEquipoProvider = Provider<SugerenciasEquipo>((ref) {
  final equipos =
      ref.watch(equiposRegistradosProvider).value ?? const <Equipo>[];
  return SugerenciasEquipo.desde(equipos);
});
