import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/extensiones.dart';
import '../models/taller_exception.dart';
import '../providers/data_providers.dart';
import '../theme/app_theme.dart';
import '../viewmodels/inventario_viewmodel.dart';
import 'widgets/async_view.dart';

class InventarioScreen extends ConsumerWidget {
  const InventarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repuestos = ref.watch(repuestosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Inventario')),
      body: AsyncView<List<Repuesto>>(
        value: repuestos,
        builder: (lista) {
          final bajos = lista.where((r) => r.bajoStock).length;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (bajos > 0)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.alerta.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.alerta),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: AppTheme.alerta),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          bajos == 1
                              ? '1 repuesto está en el stock mínimo o por debajo'
                              : '$bajos repuestos están en el stock mínimo o por debajo',
                        ),
                      ),
                    ],
                  ),
                ),
              for (final r in lista) _RepuestoCard(repuesto: r),
            ],
          );
        },
      ),
    );
  }
}

class _RepuestoCard extends ConsumerWidget {
  const _RepuestoCard({required this.repuesto});

  final Repuesto repuesto;

  Future<void> _reponer(BuildContext context, WidgetRef ref) async {
    final cantidad = await showDialog<int>(
      context: context,
      builder: (_) => _DialogoReponer(nombre: repuesto.nombre),
    );
    if (cantidad == null || !context.mounted) return;
    try {
      await ref
          .read(inventarioViewModelProvider)
          .reponer(repuesto.id, cantidad);
    } on TallerException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.mensaje)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bajo = repuesto.bajoStock;
    final tema = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: bajo ? AppTheme.alerta : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(
              bajo ? Icons.warning_amber_rounded : Icons.memory,
              color: bajo ? AppTheme.alerta : AppTheme.morado,
              size: 32,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(repuesto.nombre,
                      style: tema.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text('Código: ${repuesto.codigo}',
                      style: tema.bodySmall?.copyWith(color: Colors.white60)),
                  Text('Precio: ${formatoMoneda(repuesto.precio)}',
                      style: tema.bodySmall?.copyWith(color: Colors.white60)),
                  const SizedBox(height: 2),
                  Text(
                    bajo
                        ? '¡Stock bajo! Mínimo: ${repuesto.stockMinimo}'
                        : 'Mínimo: ${repuesto.stockMinimo}',
                    style: tema.bodySmall?.copyWith(
                      color: bajo ? AppTheme.alerta : Colors.white60,
                      fontWeight: bajo ? FontWeight.bold : null,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '${repuesto.stock}',
                  style: tema.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: bajo ? AppTheme.alerta : null,
                  ),
                ),
                const Text('en stock',
                    style: TextStyle(color: Colors.white60, fontSize: 11)),
                TextButton(
                  onPressed: () => _reponer(context, ref),
                  child: const Text('Reponer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogoReponer extends StatefulWidget {
  const _DialogoReponer({required this.nombre});

  final String nombre;

  @override
  State<_DialogoReponer> createState() => _DialogoReponerState();
}

class _DialogoReponerState extends State<_DialogoReponer> {
  final _form = GlobalKey<FormState>();
  final _cantidad = TextEditingController();

  @override
  void dispose() {
    _cantidad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reponer ${widget.nombre}'),
      content: Form(
        key: _form,
        child: TextFormField(
          controller: _cantidad,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Unidades que ingresan'),
          validator: (v) {
            final n = int.tryParse((v ?? '').trim());
            return (n == null || n <= 0) ? 'Cantidad inválida' : null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (_form.currentState!.validate()) {
              Navigator.pop(context, int.parse(_cantidad.text.trim()));
            }
          },
          child: const Text('Reponer'),
        ),
      ],
    );
  }
}
