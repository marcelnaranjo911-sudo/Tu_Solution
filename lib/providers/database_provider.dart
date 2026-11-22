import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/daos.dart';
import '../database/database.dart';

/// Se sobrescribe en main() con la base ya inicializada.
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider debe sobrescribirse en main()');
});

final tecnicosDaoProvider =
    Provider<TecnicosDao>((ref) => ref.watch(databaseProvider).tecnicosDao);

final ordenesDaoProvider =
    Provider<OrdenesDao>((ref) => ref.watch(databaseProvider).ordenesDao);

final inventarioDaoProvider =
    Provider<InventarioDao>((ref) => ref.watch(databaseProvider).inventarioDao);

final equiposDaoProvider =
    Provider<EquiposDao>((ref) => ref.watch(databaseProvider).equiposDao);
