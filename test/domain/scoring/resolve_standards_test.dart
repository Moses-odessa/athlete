import 'package:athlete_index/data/models/catalog_seed.dart';
import 'package:athlete_index/domain/entities/age_bracket.dart';
import 'package:athlete_index/domain/entities/cohort.dart';
import 'package:athlete_index/domain/entities/gender.dart';
import 'package:athlete_index/domain/scoring/resolve_standards.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final bench = Catalog.exerciseById('bench_press')!;
  final run3km = Catalog.exerciseById('run_3km')!;

  const maleRef = Cohort(Gender.male, AgeBracket.b25to29);
  const femaleRef = Cohort(Gender.female, AgeBracket.b25to29);
  const maleOlder = Cohort(Gender.male, AgeBracket.b40to44);

  group('множитель массы тела (жим)', () {
    test('мужчина 25–29, вес 80 кг → абсолютные кг', () {
      final std = resolveStandards(bench, maleRef, bodyweightKg: 80);
      expect(std.min, closeTo(0.3 * 80, 1e-9)); // 24
      expect(std.max, closeTo(2.0 * 80, 1e-9)); // 160
    });

    test('женский коэффициент понижает планку', () {
      final std = resolveStandards(bench, femaleRef, bodyweightKg: 80);
      expect(std.min, closeTo(0.3 * 0.65 * 80, 1e-9));
      expect(std.max, closeTo(2.0 * 0.65 * 80, 1e-9));
    });

    test('возрастной коэффициент понижает планку', () {
      final std = resolveStandards(bench, maleOlder, bodyweightKg: 80);
      final f = 0.88; // ageFactor(40–44)
      expect(std.max, closeTo(2.0 * f * 80, 1e-9));
    });
  });

  group('«меньше — лучше» (бег): пониженная способность → большее время', () {
    test('мужчина 25–29 — базовые нормативы', () {
      final std = resolveStandards(run3km, maleRef);
      expect(std.min, closeTo(1200, 1e-9));
      expect(std.max, closeTo(600, 1e-9));
    });

    test('женский коэффициент делает нормативы медленнее', () {
      final std = resolveStandards(run3km, femaleRef);
      expect(std.min, closeTo(1200 / 0.88, 1e-6));
      expect(std.max, closeTo(600 / 0.88, 1e-6));
      // Женские нормативы по времени больше (медленнее) мужских.
      expect(std.min, greaterThan(1200));
    });
  });
}
