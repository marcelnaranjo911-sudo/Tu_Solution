import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/database.dart';
import 'providers/database_provider.dart';
import 'theme/app_theme.dart';
import 'views/main_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Abre la base de datos local y, la primera vez, carga los datos semilla.
  final db = AppDatabase();
  await db.inicializar();

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const TuSolutionApp(),
    ),
  );
}

class TuSolutionApp extends StatelessWidget {
  const TuSolutionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu Solution',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const MainShell(),
    );
  }
}
