import 'package:flutter/material.dart';

import '../../models/extensiones.dart';
import '../../models/orden_detalle.dart';
import '../../theme/app_theme.dart';
import '../orden_detalle_screen.dart';
import 'estado_chip.dart';

/// Tarjeta de una orden: equipo, estado y técnico responsable.
class OrdenCard extends StatelessWidget {
  const OrdenCard({super.key, required this.detalle});

  final OrdenDetalle detalle;

  @override
  Widget build(BuildContext context) {
    final orden = detalle.orden;
    final equipo = detalle.equipo;
    final tema = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OrdenDetalleScreen(ordenId: orden.id),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#${orden.id} · ${equipo.marca} ${equipo.modelo}',
                      style: tema.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  EstadoChip(estado: orden.estado),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${equipo.tipo} · Dueño: ${equipo.nombreDueno}',
                style: tema.bodySmall?.copyWith(color: Colors.white60),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.engineering,
                      size: 16, color: AppTheme.morado),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Técnico: ${detalle.tecnico.nombre}',
                      style: tema.bodyMedium,
                    ),
                  ),
                  Text(
                    formatoFecha(orden.fecha),
                    style: tema.bodySmall?.copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
