import 'package:flutter/material.dart';

import 'core/l10n/app_localizations.dart';

void main() {
  runApp(const AthleteApp());
}

/// Корневой виджет приложения (ТЗ разд. 8.4, 8.5).
///
/// На этой итерации собрано ядро расчётов; экраны (онбординг, дашборд с радаром,
/// ввод результатов, история) добавляются следующими итерациями.
class AthleteApp extends StatelessWidget {
  const AthleteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // Тёмная тема по умолчанию для использования в зале (ТЗ разд. 8.4).
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const _CorePlaceholderScreen(),
    );
  }
}

class _CorePlaceholderScreen extends StatelessWidget {
  const _CorePlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.athleteIndexTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(l10n.comingSoon),
            ],
          ),
        ),
      ),
    );
  }
}
