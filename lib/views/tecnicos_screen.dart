import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/orden_detalle.dart';
import '../providers/data_providers.dart';
import '../theme/app_theme.dart';
import '../viewmodels/tecnicos_viewmodel.dart';
import 'widgets/async_view.dart';
import 'widgets/orden_card.dart';

class TecnicosScreen extends ConsumerWidget {
  const TecnicosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carga = ref.watch(cargaTecnicosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Técnicos')),
      body: AsyncView<List<CargaTecnico>>(
        value: carga,
        builder: (lista) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final c in lista)
              Card(
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.morado.withValues(alpha: 0.3),
                    child: Text(c.tecnico.nombre[0].toUpperCase()),
                  ),
                  title: Text(c.tecnico.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      '${c.enCurso} en curso · ${c.terminadas} terminadas'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TecnicoDetalleScreen(tecnico: c.tecnico),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TecnicoDetalleScreen extends ConsumerWidget {
  const TecnicoDetalleScreen({super.key, required this.tecnico});

  final Tecnico tecnico;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordenes = ref.watch(ordenesDeTecnicoProvider(tecnico.id));

    return Scaffold(
      appBar: AppBar(title: Text(tecnico.nombre)),
      body: AsyncView<List<OrdenDetalle>>(
        value: ordenes,
        builder: (lista) {
          final enCurso =
              lista.where((o) => o.orden.estado.enCurso).toList();
          final terminadas =
              lista.where((o) => o.orden.estado.terminada).toList();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _Seccion(
                titulo: 'Asignadas actualmente (${enCurso.length})',
                ordenes: enCurso,
                vacio: 'No tiene órdenes en curso',
              ),
              const SizedBox(height: 16),
              _Seccion(
                titulo: 'Terminadas: listas y entregadas (${terminadas.length})',
                ordenes: terminadas,
                vacio: 'Todavía no ha terminado órdenes',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Seccion extends StatelessWidget {
  const _Seccion({
    required this.titulo,
    required this.ordenes,
    required this.vacio,
  });

  final String titulo;
  final List<OrdenDetalle> ordenes;
  final String vacio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (ordenes.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(vacio, style: const TextStyle(color: Colors.white60)),
          )
        else
          for (final o in ordenes) OrdenCard(detalle: o),
      ],
    );
  }
}
