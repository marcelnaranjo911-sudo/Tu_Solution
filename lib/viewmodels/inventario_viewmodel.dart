import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/daos.dart';
import '../providers/database_provider.dart';

class InventarioViewModel {
  final InventarioDao _dao;
  const InventarioViewModel(this._dao);

  Future<void> reponer(int repuestoId, int cantidad) =>
      _dao.reponerStock(repuestoId, cantidad);
}

final inventarioViewModelProvider = Provider<InventarioViewModel>(
  (ref) => InventarioViewModel(ref.watch(inventarioDaoProvider)),
);
