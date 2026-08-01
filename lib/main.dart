import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/supabase/supabase_config.dart';
import 'data/repositories/persistence.dart';
import 'data/repositories/settings_repository.dart';
import 'domain/entities/app_settings.dart';

// TODO(sentry): вернуть мониторинг крашей (ТЗ 9, критерий 17) после апгрейда
// Flutter SDK — текущие совместимые версии sentry_flutter не собираются под
// Kotlin-тулчейн Flutter 3.44 (language version 1.6). SENTRY_DSN в CI пока не
// используется.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
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
    final settings = ref.watch(settingsControllerProvider);
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
      themeMode: _themeMode(settings.themeMode),
      locale: settings.languageCode == null
          ? null
          : Locale(settings.languageCode!),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }

  ThemeMode _themeMode(AppThemeMode mode) => switch (mode) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      };
}
