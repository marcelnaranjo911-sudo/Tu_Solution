import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/orden_detalle.dart';
import '../models/taller_exception.dart';
import '../providers/data_providers.dart';
import '../viewmodels/crear_orden_viewmodel.dart';
import 'orden_detalle_screen.dart';
import 'widgets/campo_autocompletar.dart';

/// Pantalla de la orden: sirve para CREAR una orden nueva o, si se le pasa
/// [ordenAEditar], para EDITAR los datos de una orden existente.
class CrearOrdenScreen extends ConsumerStatefulWidget {
  const CrearOrdenScreen({super.key, this.ordenAEditar});

  final OrdenDetalle? ordenAEditar;

  @override
  ConsumerState<CrearOrdenScreen> createState() => _CrearOrdenScreenState();
}

class _CrearOrdenScreenState extends ConsumerState<CrearOrdenScreen> {
  static const _tipos = ['Celular', 'Tablet', 'Laptop'];

  final _form = GlobalKey<FormState>();
  final _marca = TextEditingController();
  final _modelo = TextEditingController();
  final _serie = TextEditingController();
  final _dueno = TextEditingController();
  final _telefono = TextEditingController();
  final _falla = TextEditingController();

  String _tipo = _tipos.first;
  int? _tecnicoId;
  bool _guardando = false;

  bool get _esEdicion => widget.ordenAEditar != null;

  @override
  void initState() {
    super.initState();
    final detalle = widget.ordenAEditar;
    if (detalle != null) {
      final equipo = detalle.equipo;
      _tipo = equipo.tipo;
      _marca.text = equipo.marca;
      _modelo.text = equipo.modelo;
      _serie.text = equipo.numeroSerie;
      _dueno.text = equipo.nombreDueno;
      _telefono.text = equipo.telefonoDueno;
      _falla.text = equipo.fallaReportada;
      _tecnicoId = detalle.orden.tecnicoId;
    }
  }

  @override
  void dispose() {
    _marca.dispose();
    _modelo.dispose();
    _serie.dispose();
    _dueno.dispose();
    _telefono.dispose();
    _falla.dispose();
    super.dispose();
  }

  String? _obligatorio(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null;

  Widget _campo(
    TextEditingController controller,
    String etiqueta, {
    int maxLines = 1,
    TextInputType? teclado,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: teclado,
        decoration: InputDecoration(labelText: etiqueta),
        validator: _obligatorio,
      ),
    );
  }

  /// Igual que [_campo], pero con desplegable de sugerencias.
  Widget _campoSugerido(
    TextEditingController controller,
    String etiqueta,
    List<String> opciones, {
    TextInputType? teclado,
    bool abrirHaciaArriba = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CampoAutocompletar(
        controller: controller,
        etiqueta: etiqueta,
        opciones: opciones,
        teclado: teclado,
        abrirHaciaArriba: abrirHaciaArriba,
        validator: _obligatorio,
      ),
    );
  }

  Future<void> _guardar() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _guardando = true);
    try {
      final vm = ref.read(crearOrdenViewModelProvider);
      if (_esEdicion) {
        await vm.editar(
          ordenId: widget.ordenAEditar!.orden.id,
          tipo: _tipo,
          marca: _marca.text,
          modelo: _modelo.text,
          numeroSerie: _serie.text,
          nombreDueno: _dueno.text,
          telefonoDueno: _telefono.text,
          fallaReportada: _falla.text,
          tecnicoId: _tecnicoId!,
        );
        if (!mounted) return;
        final mensajes = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        mensajes.showSnackBar(
          const SnackBar(content: Text('Cambios guardados')),
        );
      } else {
        final id = await vm.crear(
          tipo: _tipo,
          marca: _marca.text,
          modelo: _modelo.text,
          numeroSerie: _serie.text,
          nombreDueno: _dueno.text,
          telefonoDueno: _telefono.text,
          fallaReportada: _falla.text,
          tecnicoId: _tecnicoId!,
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => OrdenDetalleScreen(ordenId: id)),
        );
      }
    } on TallerException catch (e) {
      _error(e.mensaje);
    } catch (e) {
      _error('No se pudo guardar la orden: $e');
    }
  }

  void _error(String mensaje) {
    if (!mounted) return;
    setState(() => _guardando = false);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    final tecnicos = ref.watch(tecnicosProvider).value ?? const <Tecnico>[];
    final sugerencias = ref.watch(sugerenciasEquipoProvider);
    final tipos = _tipos.contains(_tipo) ? _tipos : [..._tipos, _tipo];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _esEdicion
              ? 'Editar orden #${widget.ordenAEditar!.orden.id}'
              : 'Nueva orden',
        ),
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Datos del equipo',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DropdownButtonFormField<String>(
                // ignore: deprecated_member_use
                value: _tipo,
                decoration: const InputDecoration(labelText: 'Tipo de equipo'),
                items: [
                  for (final t in tipos)
                    DropdownMenuItem(value: t, child: Text(t)),
                ],
                onChanged: (v) => setState(() => _tipo = v ?? _tipo),
              ),
            ),
            _campoSugerido(_marca, 'Marca', sugerencias.marcas),
            _campoSugerido(_modelo, 'Modelo', sugerencias.modelos),
            _campo(_serie, 'Número de serie'),
            _campoSugerido(_dueno, 'Nombre del dueño', sugerencias.duenos,
                abrirHaciaArriba: true),
            _campoSugerido(
                _telefono, 'Teléfono del dueño', sugerencias.telefonos,
                teclado: TextInputType.phone, abrirHaciaArriba: true),
            _campo(_falla, 'Falla reportada', maxLines: 3),
            const SizedBox(height: 8),
            Text('Responsable',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              // ignore: deprecated_member_use
              value: _tecnicoId,
              decoration: const InputDecoration(labelText: 'Técnico asignado'),
              items: [
                for (final t in tecnicos)
                  DropdownMenuItem(value: t.id, child: Text(t.nombre)),
              ],
              onChanged: (v) => setState(() => _tecnicoId = v),
              validator: (v) => v == null ? 'Seleccione un técnico' : null,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _guardando ? null : _guardar,
              icon: _guardando
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(_esEdicion ? 'Guardar cambios' : 'Crear orden'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
