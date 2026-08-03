import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show
        PostgresChangeEvent,
        PostgresChangeFilter,
        PostgresChangeFilterType,
        RealtimeChannel,
        Supabase;

import '../../../core/supabase/supabase_config.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../settings/application/data_transfer.dart';
import 'cloud_controller.dart';

/// Полностью автоматическая мультидевайс-синхронизация (ТЗ M2, #3/#4):
/// • выгрузка при изменении данных (debounce) и при сворачивании;
/// • realtime-подписка на облако — правки с другого устройства подтягиваются
///   и объединяются автоматически.
/// Ручной синхронизации нет.
void setupAutoCloudSync(ProviderContainer container) {
  if (!SupabaseConfig.isConfigured) return;

  // Держим cloudController живым (слушатель сессии + подписки).
  container.listen(cloudControllerProvider, (_, _) {});

  final client = Supabase.instance.client;

  // ── Выгрузка локальных изменений (debounce) ──────────────────────────────
  Timer? pushDebounce;
  void schedulePush() {
    if (!container.read(cloudControllerProvider).signedIn) return;
    pushDebounce?.cancel();
    pushDebounce = Timer(const Duration(seconds: 3), () {
      container.read(cloudControllerProvider.notifier).backup();
    });
  }

  container.listen(resultsControllerProvider, (_, _) => schedulePush());
  container.listen(profileControllerProvider, (_, _) => schedulePush());

  // ── Подтягивание правок из облака (realtime) ─────────────────────────────
  Timer? pullDebounce;
  Future<void> pullAndMerge() async {
    try {
      final remote = await container.read(cloudSyncProvider).pull();
      if (remote == null) return;
      final localResults = container.read(resultsControllerProvider);
      final localProfile = container.read(profileControllerProvider);
      final merged =
          mergeUserData(UserData(localProfile, localResults), remote);
      final resultsChanged = merged.results.length != localResults.length;
      final profileGained = localProfile == null && merged.profile != null;
      if (!resultsChanged && !profileGained) return; // эхо/без изменений
      container.read(resultsControllerProvider.notifier).setAll(merged.results);
      if (profileGained) {
        container.read(profileControllerProvider.notifier).save(merged.profile!);
      }
    } catch (_) {
      // Сеть недоступна — попробуем при следующем событии.
    }
  }

  void schedulePull() {
    pullDebounce?.cancel();
    pullDebounce = Timer(const Duration(seconds: 1), pullAndMerge);
  }

  // ── Realtime-подписка на таблицу backups текущего пользователя ────────────
  RealtimeChannel? channel;
  void unsubscribe() {
    if (channel != null) {
      client.removeChannel(channel!);
      channel = null;
    }
  }

  void subscribe() {
    final uid = client.auth.currentUser?.id;
    if (uid == null || channel != null) return;
    channel = client
        .channel('backups:$uid')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'backups',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: uid,
          ),
          callback: (_) => schedulePull(),
        )
        .subscribe();
    // Сразу подтянуть актуальное состояние облака при (пере)подписке.
    schedulePull();
  }

  // (Пере)подписка по состоянию входа.
  if (container.read(cloudControllerProvider).signedIn) subscribe();
  container.listen<CloudState>(cloudControllerProvider, (prev, next) {
    if (next.signedIn && !(prev?.signedIn ?? false)) {
      subscribe();
    } else if (!next.signedIn && (prev?.signedIn ?? false)) {
      unsubscribe();
    }
  });

  // Выгрузка при сворачивании приложения.
  // Регистрируется в WidgetsBinding, поэтому ссылку хранить не нужно.
  AppLifecycleListener(
    onPause: () {
      if (container.read(cloudControllerProvider).signedIn) {
        container.read(cloudControllerProvider.notifier).backup();
      }
    },
  );
}
