import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/orden_detalle.dart';
import '../viewmodels/ordenes_viewmodel.dart';
import 'crear_orden_screen.dart';
import 'widgets/async_view.dart';
import 'widgets/mensaje_vacio.dart';
import 'widgets/orden_card.dart';

class OrdenesScreen extends ConsumerWidget {
  const OrdenesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtro = ref.watch(filtroEstadoProvider);
    final ordenes = ref.watch(ordenesFiltradasProvider);
    final notifier = ref.read(filtroEstadoProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Órdenes')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CrearOrdenScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nueva orden'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: const Text('Todas'),
                    selected: filtro == null,
                    onSelected: (_) => notifier.seleccionar(null),
                  ),
                ),
                for (final e in EstadoOrden.values)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(e.etiqueta),
                      selected: filtro == e,
                      onSelected: (_) => notifier.seleccionar(e),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: AsyncView<List<OrdenDetalle>>(
              value: ordenes,
              builder: (lista) {
                if (lista.isEmpty) {
                  return const MensajeVacio(
                    icono: Icons.build_outlined,
                    texto: 'No hay órdenes con este filtro',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                  itemCount: lista.length,
                  itemBuilder: (_, i) => OrdenCard(detalle: lista[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
