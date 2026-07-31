import '../entities/athlete_index_result.dart';
import '../entities/category_score.dart';
import 'level.dart';

/// Индекс атлета — среднее по оценённым категориям (ТЗ разд. 4.8).
///
/// Индекс считается «полным» только когда оценены все [totalCategories]
/// категорий и ни одна не частичная; иначе — прогноз с индикатором неполноты
/// (ТЗ разд. 4.7). В MVP заведены 4 категории из 8, поэтому индекс всегда прогноз.
AthleteIndexResult athleteIndex(
  Map<String, CategoryScore> categories, {
  int totalCategories = 8,
}) {
  final assessed = categories.values.toList();

  if (assessed.isEmpty) {
    return AthleteIndexResult(
      value: 0,
      level: levelForScore(0),
      assessedCategories: 0,
      totalCategories: totalCategories,
      isForecast: true,
    );
  }

  final avg =
      assessed.map((c) => c.score).reduce((a, b) => a + b) / assessed.length;

  final complete = assessed.length >= totalCategories &&
      assessed.every((c) => !c.partiallyAssessed);

  return AthleteIndexResult(
    value: avg,
    level: levelForScore(avg),
    assessedCategories: assessed.length,
    totalCategories: totalCategories,
    isForecast: !complete,
  );
}
