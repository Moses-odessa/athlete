import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'data/repositories/persistence.dart';
import 'data/repositories/settings_repository.dart';
import 'domain/entities/app_settings.dart';

/// DSN Sentry передаётся при сборке: `--dart-define=SENTRY_DSN=...`.
/// Пусто → мониторинг ошибок выключен (dev/тесты работают как обычно).
const _sentryDsn = String.fromEnvironment('SENTRY_DSN');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // Загрузка сохранённых данных до первого кадра (без мигания онбординга).
  await bootstrapPersistence(container);

  final app = UncontrolledProviderScope(
    container: container,
    child: const AthleteApp(),
  );

  if (_sentryDsn.isEmpty) {
    runApp(app);
    return;
  }

  // Мониторинг крашей/исключений (ТЗ разд. 9, критерий приёмки 17).
  await SentryFlutter.init(
    (options) {
      options.dsn = _sentryDsn;
      // Приватность: не собираем PII/данные о здоровье (ТЗ разд. 8.3).
      options.sendDefaultPii = false;
      // Только ошибки/краши, без перформанс-трейсинга (беречь квоту).
      options.tracesSampleRate = 0;
    },
    appRunner: () => runApp(app),
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
