import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/results_repository.dart';
import '../../../domain/entities/athlete_index_result.dart';
import '../../../domain/entities/category_score.dart';
import '../../../domain/entities/localized_text.dart';
import '../../../domain/entities/test_result.dart';
import '../../dashboard/application/dashboard_controller.dart';
import '../../history/application/history_controller.dart';

/// Достижение/бейдж (ТЗ разд. 4.14).
class Achievement {
  final String id;
  final LocalizedText title;
  final LocalizedText description;
  final bool unlocked;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.unlocked,
  });
}

/// Чистое вычисление бейджей из текущего состояния (ТЗ разд. 4.14).
List<Achievement> buildAchievements({
  required AthleteIndexResult index,
  required Map<String, CategoryScore> categoryScores,
  required List<IndexPoint> history,
  required List<TestResult> results,
}) {
  final hasData = categoryScores.isNotEmpty;
  final distinctDays = results
      .map((r) => DateTime(r.date.year, r.date.month, r.date.day))
      .toSet()
      .length;

  var improvement = 0.0;
  if (history.length >= 2) {
    final first = history.first.index;
    final best = history.map((p) => p.index).reduce(max);
    improvement = best - first;
  }
  final anyElite = categoryScores.values.any((c) => c.score >= 80);
  final fullCycle = hasData && !index.isForecast;

  Achievement level(String id, int threshold, String name) => Achievement(
        id: id,
        title: LocalizedText(ru: name, en: name),
        description: LocalizedText(
            ru: 'Индекс ≥ $threshold', en: 'Index ≥ $threshold'),
        unlocked: hasData && index.value >= threshold,
      );

  Achievement gain(String id, int n) => Achievement(
        id: id,
        title: LocalizedText(ru: 'Рост +$n', en: '+$n gain'),
        description: LocalizedText(
            ru: 'Индекс вырос на $n', en: 'Index improved by $n'),
        unlocked: improvement >= n,
      );

  Achievement streak(String id, int days) => Achievement(
        id: id,
        title: LocalizedText(ru: '$days дней тестов', en: '$days test days'),
        description: LocalizedText(
            ru: 'Тестирование в $days разных дней',
            en: 'Testing on $days different days'),
        unlocked: distinctDays >= days,
      );

  return [
    Achievement(
      id: 'full_cycle',
      title: const LocalizedText(ru: 'Полный цикл', en: 'Full cycle'),
      description: const LocalizedText(
          ru: 'Оценены все 8 категорий', en: 'All 8 categories assessed'),
      unlocked: fullCycle,
    ),
    level('idx_intermediate', 40, 'Intermediate'),
    level('idx_advanced', 60, 'Advanced'),
    level('idx_elite', 80, 'Elite'),
    level('idx_athlete', 95, 'Athlete'),
    gain('improve_5', 5),
    gain('improve_10', 10),
    gain('improve_20', 20),
    Achievement(
      id: 'category_elite',
      title:
          const LocalizedText(ru: 'Элитная категория', en: 'Elite category'),
      description: const LocalizedText(
          ru: 'Любая категория ≥ 80', en: 'Any category ≥ 80'),
      unlocked: anyElite,
    ),
    streak('streak_3', 3),
    streak('streak_7', 7),
  ];
}

final achievementsProvider = Provider<List<Achievement>>((ref) {
  final dashboard = ref.watch(dashboardProvider);
  final history = ref.watch(indexHistoryProvider);
  final results = ref.watch(resultsControllerProvider);
  return buildAchievements(
    index: dashboard.index,
    categoryScores: dashboard.categoryScores,
    history: history,
    results: results,
  );
});
