import 'localized_text.dart';
import 'measurement.dart';
import 'scale_type.dart';
import 'standards.dart';

/// Тест/упражнение каталога (ТЗ разд. 4.3, 11).
class Exercise {
  final String id;
  final String categorySlug;
  final LocalizedText name;
  final LocalizedText shortDescription;
  final MeasurementUnit unit;

  /// true — «больше лучше» (вес, повторения, дистанция);
  /// false — «меньше лучше» (время бега).
  final bool higherIsBetter;

  /// Норматив задан множителями массы тела; результат вводится в кг
  /// и делится на вес пользователя перед нормировкой (ТЗ разд. 5.1).
  final bool usesBodyweight;

  final ScaleType scaling;
  final CohortStandards standards;

  const Exercise({
    required this.id,
    required this.categorySlug,
    required this.name,
    required this.shortDescription,
    required this.unit,
    required this.higherIsBetter,
    required this.usesBodyweight,
    required this.standards,
    this.scaling = ScaleType.linear,
  });

  /// Качественный тест 1–5 — балл считается таблицей, а не нормативами.
  bool get isQualitative => unit == MeasurementUnit.qualitative1to5;
}
