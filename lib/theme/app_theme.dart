import 'package:flutter/material.dart';

import '../database/database.dart';

/// Tema oscuro: morado, negro y gris oscuro.
class AppTheme {
  AppTheme._();

  static const Color morado = Color(0xFF9B5DE5);
  static const Color moradoOscuro = Color(0xFF6D28D9);
  static const Color negro = Color(0xFF0B0B0F);
  static const Color grisOscuro = Color(0xFF1B1B22);
  static const Color grisTarjeta = Color(0xFF24242D);
  static const Color alerta = Color(0xFFFF5252);

  static Color colorEstado(EstadoOrden estado) => switch (estado) {
        EstadoOrden.recibida => const Color(0xFF42A5F5),
        EstadoOrden.enReparacion => const Color(0xFFFFB300),
        EstadoOrden.lista => const Color(0xFF66BB6A),
        EstadoOrden.entregada => const Color(0xFF9E9E9E),
        EstadoOrden.cancelada => const Color(0xFFEF5350),
      };

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: moradoOscuro,
      brightness: Brightness.dark,
    ).copyWith(
      primary: morado,
      onPrimary: Colors.white,
      secondary: morado,
      surface: negro,
      onSurface: Colors.white,
      surfaceContainerLowest: negro,
      surfaceContainerLow: grisOscuro,
      surfaceContainer: grisOscuro,
      surfaceContainerHigh: grisTarjeta,
      surfaceContainerHighest: grisTarjeta,
      error: alerta,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: negro,
      appBarTheme: const AppBarTheme(
        backgroundColor: negro,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: grisOscuro,
        indicatorColor: morado.withValues(alpha: 0.30),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: morado,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: grisTarjeta,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      chipTheme: ChipThemeData(
        selectedColor: morado.withValues(alpha: 0.35),
        backgroundColor: grisTarjeta,
        checkmarkColor: Colors.white,
      ),
    );
  }
}
