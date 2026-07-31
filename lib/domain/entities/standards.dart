import 'age_bracket.dart';

/// Нормативы теста: «минимум» (0 баллов) и «эталон» (100 баллов) для эталонной
/// когорты — мужчины 25–29 (ТЗ разд. 4.9, 6). Значения для остальных когорт
/// вычисляются в [resolveStandards] умножением на коэффициенты пола и возраста.
///
/// Для тестов с [MeasurementUnit.bodyweightMultiple] значения — это множители
/// массы тела (напр. жим 0.3×BW … 2.0×BW, ТЗ разд. 5.1).
///
/// TODO(calibration): все коэффициенты предварительные и требуют финальной
/// калибровки со спортивным экспертом (ТЗ разд. 4.9, 6, 16 п.1).
class CohortStandards {
  /// Норматив «минимум» (0 баллов) для эталонной когорты.
  final double baseMin;

  /// Норматив «эталон» (100 баллов) для эталонной когорты.
  final double baseMax;

  /// Доля женского норматива от мужского (ТЗ разд. 4.9):
  /// ~0.6–0.8 силовые, ~0.85 беговые/выносливость, ~1.0 гибкость.
  final double femaleFactor;

  /// Применять ли возрастную корректировку норматива.
  final bool ageAdjusted;

  const CohortStandards({
    required this.baseMin,
    required this.baseMax,
    this.femaleFactor = 1.0,
    this.ageAdjusted = true,
  });

  /// Возрастной коэффициент способности относительно пика 25–29.
  /// TODO(calibration): грубая модель постепенного спада после 30.
  static double ageFactor(AgeBracket bracket) {
    switch (bracket) {
      case AgeBracket.b18to24:
        return 0.98;
      case AgeBracket.b25to29:
        return 1.00;
      case AgeBracket.b30to34:
        return 0.97;
      case AgeBracket.b35to39:
        return 0.93;
      case AgeBracket.b40to44:
        return 0.88;
      case AgeBracket.b45to49:
        return 0.83;
      case AgeBracket.b50plus:
        return 0.75;
    }
  }
}
