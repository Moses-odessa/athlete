import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/database_provider.dart';
import 'profile_repository.dart';
import 'results_repository.dart';

/// Загружает сохранённые профиль и результаты в контроллеры при старте и
/// настраивает запись изменений в БД (ТЗ разд. 8.2).
///
/// Best-effort: если БД недоступна, приложение продолжает работать в памяти
/// без сохранения. На web персистентность отключена (нужны wasm-ассеты sqlite),
/// поэтому там сразу выходим, не блокируя старт приложения.
Future<void> bootstrapPersistence(ProviderContainer container) async {
  if (kIsWeb) return;
  try {
    final db = container.read(appDatabaseProvider);

    final profile =
        await db.loadProfile().timeout(const Duration(seconds: 5));
    if (profile != null) {
      container.read(profileControllerProvider.notifier).save(profile);
    }
    final results = await db.loadResults();
    if (results.isNotEmpty) {
      container.read(resultsControllerProvider.notifier).setAll(results);
    }

    // Write-through: любые изменения контроллеров пишутся в БД.
    container.listen(profileControllerProvider, (_, next) {
      final future =
          next == null ? db.clearProfile() : db.upsertProfile(next);
      future.catchError((_) {});
    });
    container.listen(resultsControllerProvider, (_, next) {
      db.replaceResults(next).catchError((_) {});
    });
  } catch (_) {
    // БД недоступна — работаем без персистентности.
  }
}
