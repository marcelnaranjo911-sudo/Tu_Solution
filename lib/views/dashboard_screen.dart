import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_theme.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import 'widgets/async_view.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(dashboardProvider);
    final tema = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tu Solution')),
      body: AsyncView<DashboardState>(
        value: estado,
        builder: (d) {
          final maxCarga = math.max(
            1,
            d.carga.fold<int>(0, (m, c) => math.max(m, c.enCurso)),
          );
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      titulo: 'Órdenes abiertas',
                      valor: '${d.ordenesAbiertas}',
                      icono: Icons.build_circle_outlined,
                      color: AppTheme.morado,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      titulo: 'Repuestos con stock bajo',
                      valor: '${d.bajoStock.length}',
                      icono: Icons.warning_amber_rounded,
                      color: d.bajoStock.isEmpty
                          ? Colors.greenAccent
                          : AppTheme.alerta,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _MiniStat(
                        titulo: 'Recibidas', valor: d.recibidas, icono: Icons.inbox),
                  ),
                  Expanded(
                    child: _MiniStat(
                        titulo: 'En reparación',
                        valor: d.enReparacion,
                        icono: Icons.handyman),
                  ),
                  Expanded(
                    child: _MiniStat(
                        titulo: 'Listas',
                        valor: d.listas,
                        icono: Icons.check_circle_outline),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Carga de trabajo por técnico', style: tema.titleMedium),
              const SizedBox(height: 8),
              for (final c in d.carga)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.morado.withValues(alpha: 0.3),
                          child: Text(c.tecnico.nombre[0].toUpperCase()),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.tecnico.nombre,
                                  style: tema.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: c.enCurso / maxCarga,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(8),
                                color: AppTheme.morado,
                                backgroundColor: Colors.white12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${c.enCurso} en curso',
                          style: tema.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Text('Alertas de stock', style: tema.titleMedium),
              const SizedBox(height: 8),
              if (d.bajoStock.isEmpty)
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.greenAccent),
                    title: Text('Todo el inventario está en niveles normales'),
                  ),
                )
              else
                for (final r in d.bajoStock)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppTheme.alerta),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.warning_amber_rounded,
                          color: AppTheme.alerta),
                      title: Text(r.nombre),
                      subtitle:
                          Text('Stock ${r.stock} · mínimo ${r.stockMinimo}'),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
  });

  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icono, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              valor,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: color),
            ),
            Text(titulo, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.titulo,
    required this.valor,
    required this.icono,
  });

  final String titulo;
  final int valor;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icono, color: AppTheme.morado),
        const SizedBox(height: 4),
        Text('$valor',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        Text(titulo,
            style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }
}
