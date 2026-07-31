import '../entities/cohort.dart';
import '../entities/exercise.dart';
import '../entities/scale_type.dart';
import '../entities/score.dart';
import 'raw_score.dart';
import 'resolve_standards.dart';

/// Полный расчёт балла теста: нормативы когорты → линейный балл → шкала
/// (ТЗ разд. 4.5, 4.6). Для качественных тестов используется таблица 1–5.
///
/// [scaleOverride] позволяет переопределить шкалу упражнения (настройка
/// «Тип шкалы», ТЗ разд. 4.17).
Score scoreTest(
  Exercise exercise,
  num value,
  Cohort cohort, {
  double? bodyweightKg,
  ScaleType? scaleOverride,
}) {
  final scale = scaleOverride ?? exercise.scaling;

  final double linear;
  if (exercise.isQualitative) {
    linear = qualitativeToScore(value.round());
  } else {
    final std = resolveStandards(exercise, cohort, bodyweightKg: bodyweightKg);
    linear = linearScore(
      value,
      std.min,
      std.max,
      higherIsBetter: exercise.higherIsBetter,
    );
  }

  return Score(
    exerciseId: exercise.id,
    rawValue: value,
    normalizedScore: applyScale(linear, scale),
  );
}
