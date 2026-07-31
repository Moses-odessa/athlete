import '../entities/category_score.dart';
import '../entities/score.dart';
import 'level.dart';

/// Балл категории — среднее арифметическое баллов её тестов (ТЗ разд. 4.7).
/// Если тестов меньше [minTests], категория помечается частично оценённой.
CategoryScore categoryScore(
  String categorySlug,
  List<Score> scores, {
  int minTests = 2,
}) {
  if (scores.isEmpty) {
    return CategoryScore(
      categorySlug: categorySlug,
      score: 0,
      level: levelForScore(0),
      testCount: 0,
      partiallyAssessed: true,
    );
  }

  final avg =
      scores.map((s) => s.normalizedScore).reduce((a, b) => a + b) /
          scores.length;

  return CategoryScore(
    categorySlug: categorySlug,
    score: avg,
    level: levelForScore(avg),
    testCount: scores.length,
    partiallyAssessed: scores.length < minTests,
  );
}
