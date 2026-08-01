import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../domain/entities/test_result.dart';
import '../../../domain/scoring/scoring.dart';
import '../../dashboard/application/athlete_summary.dart';

/// Точка динамики Индекса атлета (ТЗ разд. 4.10).
class IndexPoint {
  final DateTime date;
  final double index;
  const IndexPoint(this.date, this.index);
}

/// Личный рекорд по упражнению — лучший балл и соответствующий результат.
class PersonalRecord {
  final String exerciseId;
  final num value;
  final double score;
  final DateTime date;
  const PersonalRecord({
    required this.exerciseId,
    required this.value,
    required this.score,
    required this.date,
  });
}

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Динамика индекса по датам: на каждую дату замера — индекс по всем результатам
/// до этой даты включительно (ТЗ разд. 4.10).
final indexHistoryProvider = Provider<List<IndexPoint>>((ref) {
  final profile = ref.watch(profileControllerProvider);
  final results = ref.watch(resultsControllerProvider);
  if (profile == null || results.isEmpty) return const [];

  final cohort = profile.cohortAsOf(DateTime.now());
  final scale = ref.watch(settingsControllerProvider).scaleType;
  final sorted = [...results]..sort((a, b) => a.date.compareTo(b.date));

  final points = <IndexPoint>[];
  final accumulated = <TestResult>[];
  for (var i = 0; i < sorted.length; i++) {
    accumulated.add(sorted[i]);
    final isBoundary =
        i == sorted.length - 1 || !_sameDay(sorted[i].date, sorted[i + 1].date);
    if (isBoundary) {
      final summary = summarizeResults(
        cohort: cohort,
        weightKg: profile.weightKg,
        results: accumulated,
        scale: scale,
      );
      points.add(IndexPoint(sorted[i].date, summary.index.value));
    }
  }
  return points;
});

/// Личные рекорды по каждому упражнению (лучший балл), сортировка по убыванию.
final personalRecordsProvider = Provider<List<PersonalRecord>>((ref) {
  final profile = ref.watch(profileControllerProvider);
  final results = ref.watch(resultsControllerProvider);
  if (profile == null || results.isEmpty) return const [];

  final cohort = profile.cohortAsOf(DateTime.now());
  final scale = ref.watch(settingsControllerProvider).scaleType;
  final best = <String, PersonalRecord>{};
  for (final r in results) {
    final exercise = Catalog.exerciseById(r.exerciseId);
    if (exercise == null) continue;
    final score = scoreTest(
      exercise,
      r.value,
      cohort,
      bodyweightKg: r.bodyweightKg ?? profile.weightKg,
      scaleOverride: scale,
    ).normalizedScore;
    final current = best[r.exerciseId];
    if (current == null || score > current.score) {
      best[r.exerciseId] = PersonalRecord(
        exerciseId: r.exerciseId,
        value: r.value,
        score: score,
        date: r.date,
      );
    }
  }

  final list = best.values.toList()
    ..sort((a, b) => b.score.compareTo(a.score));
  return list;
});
