/// Нормализованный балл одного теста (ТЗ разд. 4.6, 11).
class Score {
  final String exerciseId;

  /// Исходное значение результата (в единицах теста).
  final num rawValue;

  /// Итоговый балл 0..100 после нормировки и выбранной шкалы.
  final double normalizedScore;

  const Score({
    required this.exerciseId,
    required this.rawValue,
    required this.normalizedScore,
  });
}
