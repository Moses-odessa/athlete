import '../entities/cohort.dart';
import '../entities/exercise.dart';
import '../entities/gender.dart';
import '../entities/standards.dart';

/// Разрешённые нормативы {min, max} теста для конкретной когорты и веса тела
/// (ТЗ разд. 4.9, 5.1).
///
/// Способность когорты относительно эталонной (мужчины 25–29) = коэф. пола ×
/// коэф. возраста. Для «больше — лучше» планка масштабируется пропорционально
/// (ниже способность → ниже норматив). Для «меньше — лучше» (время) планка,
/// наоборот, повышается (медленнее) — значения делятся на коэффициент.
///
/// Для тестов на множителе массы тела нормативы дополнительно умножаются на
/// [bodyweightKg], переводя множители BW в абсолютные килограммы.
({double min, double max}) resolveStandards(
  Exercise exercise,
  Cohort cohort, {
  double? bodyweightKg,
}) {
  final s = exercise.standards;
  final genderFactor = cohort.gender == Gender.female ? s.femaleFactor : 1.0;
  final ageFactor =
      s.ageAdjusted ? CohortStandards.ageFactor(cohort.ageBracket) : 1.0;
  final capacity = genderFactor * ageFactor;

  double min = s.baseMin;
  double max = s.baseMax;

  if (capacity > 0) {
    if (exercise.higherIsBetter) {
      min *= capacity;
      max *= capacity;
    } else {
      // «Меньше — лучше»: пониженная способность → бо́льшие (медленнее) нормативы.
      min /= capacity;
      max /= capacity;
    }
  }

  if (exercise.usesBodyweight) {
    final bw = bodyweightKg ?? 0;
    min *= bw;
    max *= bw;
  }

  return (min: min, max: max);
}
