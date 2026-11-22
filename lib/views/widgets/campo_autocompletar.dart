import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CampoAutocompletar extends StatefulWidget {
  const CampoAutocompletar({
    super.key,
    required this.controller,
    required this.etiqueta,
    required this.opciones,
    this.validator,
    this.teclado,
    this.abrirHaciaArriba = false,
    this.maxSugerencias = 4,
  });

  final TextEditingController controller;
  final String etiqueta;
  final List<String> opciones;
  final String? Function(String?)? validator;
  final TextInputType? teclado;

  /// Útil en los campos de la parte baja de la pantalla, para que el
  /// desplegable no quede tapado por el teclado.
  final bool abrirHaciaArriba;
  final int maxSugerencias;

  @override
  State<CampoAutocompletar> createState() => _CampoAutocompletarState();
}

class _CampoAutocompletarState extends State<CampoAutocompletar> {
  final FocusNode _foco = FocusNode();

  @override
  void dispose() {
    _foco.dispose();
    super.dispose();
  }

  Iterable<String> _sugerencias(TextEditingValue valor) {
    final consulta = valor.text.trim().toLowerCase();
    if (consulta.isEmpty) return const <String>[];

    final coincidencias = widget.opciones.where((opcion) {
      final minuscula = opcion.toLowerCase();
      // Si ya está escrito exactamente igual, no hay nada que sugerir.
      return minuscula != consulta && minuscula.contains(consulta);
    }).toList();

    // Primero las que empiezan por lo escrito.
    coincidencias.sort((a, b) {
      final pa = a.toLowerCase().startsWith(consulta) ? 0 : 1;
      final pb = b.toLowerCase().startsWith(consulta) ? 0 : 1;
      return pa.compareTo(pb);
    });
    return coincidencias.take(widget.maxSugerencias).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, restricciones) {
        return RawAutocomplete<String>(
          textEditingController: widget.controller,
          focusNode: _foco,
          optionsBuilder: _sugerencias,
          optionsViewOpenDirection: widget.abrirHaciaArriba
              ? OptionsViewOpenDirection.up
              : OptionsViewOpenDirection.down,
          fieldViewBuilder: (context, controller, foco, _) {
            return TextFormField(
              controller: controller,
              focusNode: foco,
              keyboardType: widget.teclado,
              decoration: InputDecoration(labelText: widget.etiqueta),
              validator: widget.validator,
            );
          },
          optionsViewBuilder: (context, alSeleccionar, opciones) {
            return Align(
              alignment: widget.abrirHaciaArriba
                  ? Alignment.bottomLeft
                  : Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Material(
                  elevation: 8,
                  color: AppTheme.grisOscuro,
                  shadowColor: Colors.black,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: AppTheme.morado.withValues(alpha: 0.6),
                    ),
                  ),
                  child: SizedBox(
                    width: restricciones.maxWidth,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: opciones.length,
                      separatorBuilder: (context, indice) =>
                          const Divider(height: 1, color: Colors.white10),
                      itemBuilder: (context, indice) {
                        final opcion = opciones.elementAt(indice);
                        return InkWell(
                          onTap: () => alSeleccionar(opcion),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.history,
                                  size: 18,
                                  color: AppTheme.morado,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    opcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
