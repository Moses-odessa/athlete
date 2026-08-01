import '../../domain/entities/app_settings.dart';
import '../../domain/entities/measurement.dart';

/// Множитель перевода введённого значения (в текущей системе единиц) в
/// метрическое, в котором заданы нормативы (ТЗ разд. 4.17, 8.5).
/// Время, повторения и качественные оценки не конвертируются.
double toMetricFactor(MeasurementUnit unit, UnitSystem system) {
  if (system == UnitSystem.metric) return 1;
  switch (unit) {
    case MeasurementUnit.kilograms:
    case MeasurementUnit.bodyweightMultiple:
      return 0.45359237; // фунты → кг
    case MeasurementUnit.centimeters:
      return 2.54; // дюймы → см
    case MeasurementUnit.meters:
      return 0.3048; // футы → м
    case MeasurementUnit.reps:
    case MeasurementUnit.seconds:
    case MeasurementUnit.milliseconds:
    case MeasurementUnit.qualitative1to5:
      return 1;
  }
}
