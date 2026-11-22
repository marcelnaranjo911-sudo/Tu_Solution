import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/extensiones.dart';
import '../models/orden_detalle.dart';
import '../models/taller_exception.dart';
import '../providers/data_providers.dart';
import '../theme/app_theme.dart';
import '../viewmodels/orden_detalle_viewmodel.dart';
import 'crear_orden_screen.dart';
import 'widgets/async_view.dart';
import 'widgets/estado_chip.dart';

class OrdenDetalleScreen extends ConsumerWidget {
  const OrdenDetalleScreen({super.key, required this.ordenId});

  final int ordenId;

  /// Pide confirmación y elimina la orden; luego vuelve a la pantalla anterior.
  Future<void> _eliminar(
    BuildContext context,
    WidgetRef ref,
    OrdenDetalle detalle,
  ) async {
    final devuelveStock = detalle.orden.estado != EstadoOrden.entregada;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('¿Eliminar la orden #${detalle.orden.id}?'),
        content: Text(
          'Se borrará la orden con sus trabajos y repuestos, y dejará de '
          'aparecer en el inicio, en la lista y en el historial.'
          '${devuelveStock ? ' Los repuestos usados volverán al inventario.' : ''}'
          '\n\nEsta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.alerta),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmar != true || !context.mounted) return;

    final vm = ref.read(ordenDetalleViewModelProvider);
    final mensajes = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    try {
      await vm.eliminarOrden(detalle.orden.id);
      mensajes.showSnackBar(
        SnackBar(content: Text('Orden #${detalle.orden.id} eliminada')),
      );
    } catch (e) {
      mensajes.showSnackBar(
        SnackBar(content: Text('No se pudo eliminar la orden: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordenAsync = ref.watch(ordenProvider(ordenId));
    final detalleActual = ordenAsync.value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden #$ordenId'),
        actions: [
          if (detalleActual != null) ...[
            IconButton(
              tooltip: 'Editar orden',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CrearOrdenScreen(ordenAEditar: detalleActual),
                ),
              ),
            ),
            IconButton(
              tooltip: 'Eliminar orden',
              icon: const Icon(Icons.delete_outline, color: AppTheme.alerta),
              onPressed: () => _eliminar(context, ref, detalleActual),
            ),
          ],
        ],
      ),
      body: AsyncView<OrdenDetalle?>(
        value: ordenAsync,
        builder: (detalle) {
          if (detalle == null) {
            return const Center(child: Text('La orden no existe'));
          }
          return _Contenido(detalle: detalle);
        },
      ),
    );
  }
}

class _Contenido extends ConsumerWidget {
  const _Contenido({required this.detalle});

  final OrdenDetalle detalle;

  void _aviso(BuildContext context, String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  /// Ejecuta una acción y muestra el mensaje si el negocio la rechaza.
  Future<void> _ejecutar(
    BuildContext context,
    Future<void> Function() accion,
  ) async {
    try {
      await accion();
    } on TallerException catch (e) {
      if (context.mounted) _aviso(context, e.mensaje);
    }
  }

  Future<void> _agregarTrabajo(BuildContext context, WidgetRef ref) async {
    final datos = await showDialog<(String, double)>(
      context: context,
      builder: (_) => const _DialogoTrabajo(),
    );
    if (datos == null || !context.mounted) return;
    await _ejecutar(
      context,
      () => ref
          .read(ordenDetalleViewModelProvider)
          .agregarTrabajo(detalle.orden.id, datos.$1, datos.$2),
    );
  }

  Future<void> _agregarRepuesto(BuildContext context, WidgetRef ref) async {
    final inventario = ref.read(repuestosProvider).value ?? const <Repuesto>[];
    final datos = await showDialog<(int, int)>(
      context: context,
      builder: (_) => _DialogoRepuesto(repuestos: inventario),
    );
    if (datos == null || !context.mounted) return;
    await _ejecutar(
      context,
      () => ref
          .read(ordenDetalleViewModelProvider)
          .agregarRepuesto(detalle.orden.id, datos.$1, datos.$2),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orden = detalle.orden;
    final equipo = detalle.equipo;
    final vm = ref.read(ordenDetalleViewModelProvider);
    final tema = Theme.of(context).textTheme;
    final tecnicos = ref.watch(tecnicosProvider).value ?? const <Tecnico>[];
    final trabajos = ref.watch(trabajosProvider(orden.id)).value ??
        const <TrabajoRealizado>[];
    final usos = ref.watch(repuestosUsadosProvider(orden.id)).value ??
        const <RepuestoUsadoDetalle>[];
    final costo = ref.watch(resumenCostoProvider(orden.id));
    final editable = orden.estado.abierta;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ----- Equipo -----
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('${equipo.marca} ${equipo.modelo}',
                          style: tema.titleLarge),
                    ),
                    EstadoChip(estado: orden.estado),
                  ],
                ),
                const SizedBox(height: 8),
                _Dato(Icons.devices, 'Tipo', equipo.tipo),
                _Dato(Icons.qr_code, 'Serie', equipo.numeroSerie),
                _Dato(Icons.person, 'Dueño', equipo.nombreDueno),
                _Dato(Icons.phone, 'Teléfono', equipo.telefonoDueno),
                _Dato(Icons.report_problem_outlined, 'Falla',
                    equipo.fallaReportada),
                _Dato(Icons.event, 'Ingreso', formatoFecha(orden.fecha)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ----- Estado y responsable -----
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gestión de la orden', style: tema.titleMedium),
                const SizedBox(height: 12),
                DropdownButtonFormField<EstadoOrden>(
                  key: ValueKey('estado-${orden.estado.name}'),
                  // ignore: deprecated_member_use
                  value: orden.estado,
                  decoration: const InputDecoration(labelText: 'Estado'),
                  items: [
                    for (final e in EstadoOrden.values)
                      DropdownMenuItem(value: e, child: Text(e.etiqueta)),
                  ],
                  onChanged: (v) {
                    if (v != null) vm.cambiarEstado(orden.id, v);
                  },
                ),
                const SizedBox(height: 12),
                if (tecnicos.isNotEmpty)
                  DropdownButtonFormField<int>(
                    key: ValueKey('tecnico-${orden.tecnicoId}'),
                    // ignore: deprecated_member_use
                    value: orden.tecnicoId,
                    decoration: const InputDecoration(
                        labelText: 'Técnico responsable'),
                    items: [
                      for (final t in tecnicos)
                        DropdownMenuItem(value: t.id, child: Text(t.nombre)),
                    ],
                    onChanged: (v) {
                      if (v != null) vm.asignarTecnico(orden.id, v);
                    },
                  )
                else
                  Text('Responsable: ${detalle.tecnico.nombre}'),
                if (!editable) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'La orden está cerrada: no se pueden agregar trabajos ni repuestos. '
                    'Para modificarla, cambie el estado.',
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ----- Trabajos de mano de obra -----
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Trabajos de mano de obra',
                          style: tema.titleMedium),
                    ),
                    if (editable)
                      IconButton.filledTonal(
                        tooltip: 'Agregar trabajo',
                        icon: const Icon(Icons.add),
                        onPressed: () => _agregarTrabajo(context, ref),
                      ),
                  ],
                ),
                if (trabajos.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Sin trabajos registrados',
                        style: TextStyle(color: Colors.white60)),
                  ),
                for (final t in trabajos)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(t.descripcion),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(formatoMoneda(t.costoManoObra)),
                        if (editable)
                          IconButton(
                            tooltip: 'Eliminar trabajo',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _ejecutar(
                                context, () => vm.eliminarTrabajo(t.id)),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ----- Repuestos usados -----
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child:
                          Text('Repuestos usados', style: tema.titleMedium),
                    ),
                    if (editable)
                      IconButton.filledTonal(
                        tooltip: 'Agregar repuesto',
                        icon: const Icon(Icons.add),
                        onPressed: () => _agregarRepuesto(context, ref),
                      ),
                  ],
                ),
                if (usos.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Sin repuestos usados',
                        style: TextStyle(color: Colors.white60)),
                  ),
                for (final u in usos)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text('${u.repuesto.nombre} × ${u.uso.cantidad}'),
                    subtitle: Text(
                        '${formatoMoneda(u.repuesto.precio)} c/u · ${u.repuesto.codigo}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(formatoMoneda(u.subtotal)),
                        if (editable)
                          IconButton(
                            tooltip: 'Quitar y devolver al stock',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _ejecutar(
                                context, () => vm.quitarRepuesto(u.uso.id)),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ----- Costo total -----
        Card(
          color: AppTheme.moradoOscuro.withValues(alpha: 0.35),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _FilaCosto('Mano de obra', costo.manoObra),
                _FilaCosto('Repuestos', costo.repuestos),
                const Divider(),
                _FilaCosto('TOTAL', costo.total, destacado: true),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _Dato extends StatelessWidget {
  const _Dato(this.icono, this.etiqueta, this.valor);

  final IconData icono;
  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 16, color: AppTheme.morado),
          const SizedBox(width: 8),
          Text('$etiqueta: ', style: const TextStyle(color: Colors.white60)),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}

class _FilaCosto extends StatelessWidget {
  const _FilaCosto(this.etiqueta, this.valor, {this.destacado = false});

  final String etiqueta;
  final double valor;
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final estilo = destacado
        ? Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(etiqueta, style: estilo),
          Text(formatoMoneda(valor), style: estilo),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Diálogos
// ---------------------------------------------------------------------------

class _DialogoTrabajo extends StatefulWidget {
  const _DialogoTrabajo();

  @override
  State<_DialogoTrabajo> createState() => _DialogoTrabajoState();
}

class _DialogoTrabajoState extends State<_DialogoTrabajo> {
  final _form = GlobalKey<FormState>();
  final _descripcion = TextEditingController();
  final _costo = TextEditingController();

  @override
  void dispose() {
    _descripcion.dispose();
    _costo.dispose();
    super.dispose();
  }

  double? _parsear(String? v) =>
      double.tryParse((v ?? '').trim().replaceAll(',', '.'));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar trabajo'),
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _descripcion,
              decoration: const InputDecoration(labelText: 'Descripción'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _costo,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration:
                  const InputDecoration(labelText: 'Costo de mano de obra'),
              validator: (v) {
                final n = _parsear(v);
                if (n == null || n < 0) return 'Ingrese un costo válido';
                return null;
              },
            ),
          ],
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
              Navigator.pop(
                  context, (_descripcion.text.trim(), _parsear(_costo.text)!));
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}

class _DialogoRepuesto extends StatefulWidget {
  const _DialogoRepuesto({required this.repuestos});

  final List<Repuesto> repuestos;

  @override
  State<_DialogoRepuesto> createState() => _DialogoRepuestoState();
}

class _DialogoRepuestoState extends State<_DialogoRepuesto> {
  final _form = GlobalKey<FormState>();
  final _cantidad = TextEditingController(text: '1');
  int? _repuestoId;

  @override
  void dispose() {
    _cantidad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar repuesto'),
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              isExpanded: true,
              // ignore: deprecated_member_use
              value: _repuestoId,
              decoration: const InputDecoration(labelText: 'Repuesto'),
              items: [
                for (final r in widget.repuestos)
                  DropdownMenuItem(
                    value: r.id,
                    enabled: r.stock > 0,
                    child: Text(
                      '${r.nombre} (stock ${r.stock})',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: (v) => setState(() => _repuestoId = v),
              validator: (v) => v == null ? 'Seleccione un repuesto' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _cantidad,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cantidad'),
              validator: (v) {
                final n = int.tryParse((v ?? '').trim());
                if (n == null || n <= 0) return 'Cantidad inválida';
                if (_repuestoId != null) {
                  final r =
                      widget.repuestos.firstWhere((x) => x.id == _repuestoId);
                  if (n > r.stock) return 'Solo hay ${r.stock} en stock';
                }
                return null;
              },
            ),
          ],
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
              Navigator.pop(
                  context, (_repuestoId!, int.parse(_cantidad.text.trim())));
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
