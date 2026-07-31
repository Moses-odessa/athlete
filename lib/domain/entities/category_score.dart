import 'athlete_level.dart';

/// Балл категории — среднее баллов её тестов (ТЗ разд. 4.7, 11).
class CategoryScore {
  final String categorySlug;

  /// Балл категории 0..100.
  final double score;
  final AthleteLevel level;

  /// Сколько тестов учтено в расчёте.
  final int testCount;

  /// Оценена частично: тестов меньше минимума (ТЗ разд. 4.7) —
  /// на радаре сектор рисуется прозрачным.
  final bool partiallyAssessed;

  const CategoryScore({
    required this.categorySlug,
    required this.score,
    required this.level,
    required this.testCount,
    required this.partiallyAssessed,
  });
}
