import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'data/repositories/persistence.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // Загрузка сохранённых данных до первого кадра (без мигания онбординга).
  await bootstrapPersistence(container);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const AthleteApp(),
    ),
  );
}

/// Корневой виджет приложения (ТЗ разд. 8.4, 8.5).
class AthleteApp extends ConsumerWidget {
  const AthleteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    const seed = Color(0xFF1565C0);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // Тёмная тема по умолчанию для использования в зале (ТЗ разд. 8.4).
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
