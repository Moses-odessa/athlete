import 'package:athlete_index/data/models/catalog_seed.dart';
import 'package:athlete_index/domain/entities/age_bracket.dart';
import 'package:athlete_index/domain/entities/cohort.dart';
import 'package:athlete_index/domain/entities/gender.dart';
import 'package:athlete_index/domain/entities/scale_type.dart';
import 'package:athlete_index/domain/scoring/raw_score.dart';
import 'package:athlete_index/domain/scoring/score_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const maleRef = Cohort(Gender.male, AgeBracket.b25to29);

  final bench = Catalog.exerciseById('bench_press')!;
  final run3km = Catalog.exerciseById('run_3km')!;
  final sitReach = Catalog.exerciseById('sit_and_reach')!;
  final deepSquat = Catalog.exerciseById('deep_squat')!;

  test('жим 1.0×BW (80 кг при весе 80) у мужчины 25–29 → ~41 (Intermediate)', () {
    final s = scoreTest(bench, 80, maleRef, bodyweightKg: 80);
    // норматив 24..160 → (80-24)/136*100
    expect(s.normalizedScore, closeTo(41.18, 0.01));
  });

  test('бег 3 км за 15:00 (900 с) → 50 (меньше — лучше)', () {
    final s = scoreTest(run3km, 900, maleRef);
    expect(s.normalizedScore, closeTo(50, 1e-9));
  });

  test('наклон вперёд 0 см → 50 (диапазон −20..+20)', () {
    final s = scoreTest(sitReach, 0, maleRef);
    expect(s.normalizedScore, closeTo(50, 1e-9));
  });

  test('качественный тест: оценка 4 → 75', () {
    final s = scoreTest(deepSquat, 4, maleRef);
    expect(s.normalizedScore, closeTo(75, 1e-9));
  });

  test('scaleOverride применяет нелинейную шкалу', () {
    final s = scoreTest(bench, 80, maleRef,
        bodyweightKg: 80, scaleOverride: ScaleType.nonlinear);
    final linear =
        scoreTest(bench, 80, maleRef, bodyweightKg: 80).normalizedScore;
    expect(s.normalizedScore, closeTo(nonlinearScore(linear), 1e-9));
    expect(s.normalizedScore, greaterThan(linear));
  });

  test('rawValue сохраняется', () {
    final s = scoreTest(run3km, 900, maleRef);
    expect(s.rawValue, 900);
    expect(s.exerciseId, 'run_3km');
  });
}
