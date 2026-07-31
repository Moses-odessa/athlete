import 'package:athlete_index/core/units/units.dart';
import 'package:athlete_index/domain/entities/app_settings.dart';
import 'package:athlete_index/domain/entities/measurement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('метрическая система — множитель 1 для всех единиц', () {
    for (final u in MeasurementUnit.values) {
      expect(toMetricFactor(u, UnitSystem.metric), 1);
    }
  });

  test('имперская конвертация в метрику', () {
    expect(toMetricFactor(MeasurementUnit.kilograms, UnitSystem.imperial),
        closeTo(0.4536, 0.0001)); // фунты → кг
    expect(toMetricFactor(MeasurementUnit.centimeters, UnitSystem.imperial),
        closeTo(2.54, 1e-9)); // дюймы → см
    expect(toMetricFactor(MeasurementUnit.meters, UnitSystem.imperial),
        closeTo(0.3048, 1e-9)); // футы → м
  });

  test('время, повторения и качественная оценка не конвертируются', () {
    for (final u in [
      MeasurementUnit.seconds,
      MeasurementUnit.reps,
      MeasurementUnit.qualitative1to5,
    ]) {
      expect(toMetricFactor(u, UnitSystem.imperial), 1);
    }
  });
}
