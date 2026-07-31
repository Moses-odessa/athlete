import '../../../data/models/catalog_seed.dart';
import '../../../domain/entities/athlete_index_result.dart';
import '../../../domain/entities/athlete_level.dart';
import '../../../domain/entities/category_score.dart';
import '../../../domain/entities/cohort.dart';
import '../../../domain/entities/scale_type.dart';
import '../../../domain/entities/score.dart';
import '../../../domain/entities/test_result.dart';
import '../../../domain/scoring/scoring.dart';

/// Сводка атлета: баллы категорий, индекс и слабое звено (ТЗ разд. 4.7, 4.8, 4.11).
class AthleteSummary {
  final Map<String, CategoryScore> categoryScores;
  final AthleteIndexResult index;
  final String? weakLinkSlug;

  const AthleteSummary({
    required this.categoryScores,
    required this.index,
    required this.weakLinkSlug,
  });

  bool get hasData => categoryScores.isNotEmpty;

  static const AthleteIndexResult emptyIndex = AthleteIndexResult(
    value: 0,
    level: AthleteLevel.novice,
    assessedCategories: 0,
    totalCategories: 8,
    isForecast: true,
  );

  static const empty = AthleteSummary(
    categoryScores: {},
    index: emptyIndex,
    weakLinkSlug: null,
  );
}

/// Считает сводку из результатов. По каждому упражнению берётся **последний**
/// результат (ретесты не задваиваются в среднем категории, ТЗ разд. 4.7),
/// затем баллы группируются по категориям и усредняются, из категорий —
/// индекс (ТЗ разд. 4.8).
AthleteSummary summarizeResults({
  required Cohort cohort,
  required double weightKg,
  required List<TestResult> results,
  int totalCategories = 8,
  ScaleType scale = ScaleType.linear,
}) {
  // Последний результат по каждому упражнению.
  final latest = <String, TestResult>{};
  for (final r in results) {
    final current = latest[r.exerciseId];
    if (current == null || r.date.isAfter(current.date)) {
      latest[r.exerciseId] = r;
    }
  }

  final byCategory = <String, List<Score>>{};
  for (final result in latest.values) {
    final exercise = Catalog.exerciseById(result.exerciseId);
    if (exercise == null) continue;
    final score = scoreTest(
      exercise,
      result.value,
      cohort,
      bodyweightKg: weightKg,
      scaleOverride: scale,
    );
    byCategory.putIfAbsent(exercise.categorySlug, () => []).add(score);
  }

  final categoryScores = <String, CategoryScore>{};
  byCategory.forEach((slug, scores) {
    categoryScores[slug] = categoryScore(slug, scores);
  });

  final index = athleteIndex(categoryScores, totalCategories: totalCategories);

  String? weakLink;
  var lowest = double.infinity;
  categoryScores.forEach((slug, cs) {
    if (cs.score < lowest) {
      lowest = cs.score;
      weakLink = slug;
    }
  });

  return AthleteSummary(
    categoryScores: categoryScores,
    index: index,
    weakLinkSlug: weakLink,
  );
}
