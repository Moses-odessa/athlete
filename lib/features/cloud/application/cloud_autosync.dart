import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/supabase/supabase_config.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../data/repositories/settings_repository.dart';
import 'cloud_controller.dart';

/// Полностью автоматическая облачная синхронизация (ТЗ M2):
/// debounce-выгрузка при изменении данных + выгрузка при сворачивании.
/// Держит cloudController живым, чтобы работал слушатель форс-логаута.
void setupAutoCloudSync(ProviderContainer container) {
  if (!SupabaseConfig.isConfigured) return;

  container.listen(cloudControllerProvider, (_, _) {});

  Timer? debounce;
  void scheduleBackup() {
    final settings = container.read(settingsControllerProvider);
    final cloud = container.read(cloudControllerProvider);
    if (!settings.autoCloudSync || !cloud.signedIn) return;
    debounce?.cancel();
    debounce = Timer(const Duration(seconds: 3), () {
      container.read(cloudControllerProvider.notifier).backup();
    });
  }

  container.listen(resultsControllerProvider, (_, _) => scheduleBackup());
  container.listen(profileControllerProvider, (_, _) => scheduleBackup());

  // Регистрируется в WidgetsBinding, поэтому ссылку хранить не нужно.
  AppLifecycleListener(
    onPause: () {
      final settings = container.read(settingsControllerProvider);
      final cloud = container.read(cloudControllerProvider);
      if (settings.autoCloudSync && cloud.signedIn) {
        container.read(cloudControllerProvider.notifier).backup();
      }
    },
  );
}
