import 'athlete_level.dart';

/// Интегральный Индекс атлета — среднее по категориям (ТЗ разд. 2.1, 4.8, 11).
class AthleteIndexResult {
  /// Значение индекса 0..100.
  final double value;
  final AthleteLevel level;

  /// Сколько категорий фактически оценено.
  final int assessedCategories;

  /// Полный набор категорий (8 по ТЗ разд. 2.2).
  final int totalCategories;

  /// Прогноз: оценены не все категории или есть частично оценённые
  /// (ТЗ разд. 4.7) — показывается индикатор неполноты.
  final bool isForecast;

  const AthleteIndexResult({
    required this.value,
    required this.level,
    required this.assessedCategories,
    required this.totalCategories,
    required this.isForecast,
  });
}
