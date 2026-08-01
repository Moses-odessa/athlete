import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard/application/dashboard_controller.dart';

/// Параметры модельного распределения баллов внутри когорты.
/// TODO(data): заменить на реальную статистику когорт, когда появится бэкенд
/// и модерация результатов (ТЗ разд. 4.12, 8 п.8). Пока — нормальная модель.
const double kCohortMean = 50;
const double kCohortSd = 18;

double _erf(double x) {
  final sign = x < 0 ? -1.0 : 1.0;
  final ax = x.abs();
  final t = 1 / (1 + 0.3275911 * ax);
  final y = 1 -
      (((((1.061405429 * t - 1.453152027) * t) + 1.421413741) * t -
                  0.284496736) *
              t +
          0.254829592) *
          t *
          exp(-ax * ax);
  return sign * y;
}

/// Доля когорты (0–100) с баллом ниже [score] по нормальной модели.
double percentileForScore(
  double score, {
  double mean = kCohortMean,
  double sd = kCohortSd,
}) {
  final z = (score - mean) / sd;
  final cdf = 0.5 * (1 + _erf(z / sqrt2));
  return (cdf * 100).clamp(0, 100);
}

/// Сравнение с когортой (ТЗ разд. 4.12). Доступно после полного цикла.
class PeerComparison {
  final bool available;
  final double overallPercentile;
  final Map<String, double> byCategory;

  const PeerComparison({
    required this.available,
    required this.overallPercentile,
    required this.byCategory,
  });
}

final peerComparisonProvider = Provider<PeerComparison>((ref) {
  final dashboard = ref.watch(dashboardProvider);
  // Включается после сдачи полного цикла (ТЗ разд. 4.12).
  final available = dashboard.hasData && !dashboard.index.isForecast;

  return PeerComparison(
    available: available,
    overallPercentile: percentileForScore(dashboard.index.value),
    byCategory: {
      for (final entry in dashboard.categoryScores.entries)
        entry.key: percentileForScore(entry.value.score),
    },
  );
});
