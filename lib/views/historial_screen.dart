import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/extensiones.dart';
import '../models/orden_detalle.dart';
import '../theme/app_theme.dart';
import '../viewmodels/historial_viewmodel.dart';
import 'widgets/async_view.dart';
import 'widgets/estado_chip.dart';
import 'widgets/mensaje_vacio.dart';

class HistorialScreen extends ConsumerWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final texto = ref.watch(busquedaHistorialProvider);
    final resultado = ref.watch(historialProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              onChanged: (v) =>
                  ref.read(busquedaHistorialProvider.notifier).actualizar(v),
              decoration: const InputDecoration(
                hintText: 'Buscar por número de serie o teléfono',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: texto.trim().length < 2
                ? const MensajeVacio(
                    icono: Icons.manage_search,
                    texto:
                        'Escriba al menos 2 caracteres del número de serie o del teléfono del dueño',
                  )
                : AsyncView<List<HistorialEquipo>>(
                    value: resultado,
                    builder: (lista) {
                      if (lista.isEmpty) {
                        return const MensajeVacio(
                          icono: Icons.search_off,
                          texto: 'No se encontraron equipos',
                        );
                      }
                      return ListView(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        children: [
                          for (final h in lista) _EquipoHistorial(historial: h),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EquipoHistorial extends StatelessWidget {
  const _EquipoHistorial({required this.historial});

  final HistorialEquipo historial;

  @override
  Widget build(BuildContext context) {
    final eq = historial.equipo;
    return Card(
      child: ExpansionTile(
        key: ValueKey('equipo-${eq.id}'),
        initiallyExpanded: true,
        shape: const Border(),
        collapsedShape: const Border(),
        leading: const Icon(Icons.devices, color: AppTheme.morado),
        title: Text('${eq.marca} ${eq.modelo}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          'Serie: ${eq.numeroSerie}\n${eq.nombreDueno} · ${eq.telefonoDueno}\n'
          '${historial.ordenes.length} orden(es) registradas',
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          if (historial.ordenes.isEmpty)
            const Text('Este equipo no tiene órdenes registradas.'),
          for (final o in historial.ordenes) _OrdenHistorial(orden: o),
        ],
      ),
    );
  }
}

class _OrdenHistorial extends StatelessWidget {
  const _OrdenHistorial({required this.orden});

  final HistorialOrden orden;

  @override
  Widget build(BuildContext context) {
    final o = orden.detalle.orden;
    final tema = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.negro,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Orden #${o.id} · ${formatoFecha(o.fecha)}',
                    style: tema.titleSmall),
              ),
              EstadoChip(estado: o.estado),
            ],
          ),
          const SizedBox(height: 6),
          Text('Técnico: ${orden.detalle.tecnico.nombre}',
              style: tema.bodySmall?.copyWith(color: Colors.white70)),
          Text('Falla: ${orden.detalle.equipo.fallaReportada}',
              style: tema.bodySmall?.copyWith(color: Colors.white70)),
          const SizedBox(height: 8),
          Text('Trabajos realizados', style: tema.labelLarge),
          if (orden.trabajos.isEmpty)
            const Text('—', style: TextStyle(color: Colors.white54)),
          for (final t in orden.trabajos)
            Text('• ${t.descripcion} (${formatoMoneda(t.costoManoObra)})',
                style: tema.bodySmall),
          const SizedBox(height: 8),
          Text('Piezas usadas', style: tema.labelLarge),
          if (orden.repuestos.isEmpty)
            const Text('—', style: TextStyle(color: Colors.white54)),
          for (final r in orden.repuestos)
            Text('• ${r.repuesto.nombre} × ${r.uso.cantidad}',
                style: tema.bodySmall),
          const Divider(),
          Align(
            alignment: Alignment.centerRight,
            child: Text('Total: ${formatoMoneda(orden.total)}',
                style: tema.titleSmall?.copyWith(color: AppTheme.morado)),
          ),
        ],
      ),
    );
  }
}
