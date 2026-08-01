import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Обязательные события аналитики (ТЗ разд. 14).
class AnalyticsEvents {
  static const registration = 'registration';
  static const onboardingCompleted = 'onboarding_completed';
  static const parqDeclined = 'parq_declined';
  static const testOpened = 'test_opened';
  static const resultEntryStarted = 'result_entry_started';
  static const resultSaved = 'result_saved';
  static const resultCancelled = 'result_cancelled';
  static const fullCycleCompleted = 'full_cycle_completed';
  static const indexChanged = 'index_changed';
  static const infoOpened = 'info_opened';
  static const scienceOpened = 'science_opened';
  static const pdfExported = 'pdf_exported';
  static const radarShared = 'radar_shared';
}

/// Фасад аналитики. Реальные бэкенды (PostHog, Sentry — ТЗ разд. 9) подключаются
/// заменой реализации; данные обезличены (ТЗ разд. 8.3).
abstract class AnalyticsService {
  void log(String event, [Map<String, Object?> props = const {}]);
}

/// Реализация по умолчанию — лог в консоль (без сети).
class LoggingAnalytics implements AnalyticsService {
  const LoggingAnalytics();

  @override
  void log(String event, [Map<String, Object?> props = const {}]) {
    if (kDebugMode) {
      debugPrint('[analytics] $event ${props.isEmpty ? '' : props}');
    }
  }
}

final analyticsProvider =
    Provider<AnalyticsService>((ref) => const LoggingAnalytics());
