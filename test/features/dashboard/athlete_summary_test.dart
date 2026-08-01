import 'package:athlete_index/domain/entities/age_bracket.dart';
import 'package:athlete_index/domain/entities/cohort.dart';
import 'package:athlete_index/domain/entities/gender.dart';
import 'package:athlete_index/domain/entities/test_result.dart';
import 'package:athlete_index/features/dashboard/application/athlete_summary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const cohort = Cohort(Gender.male, AgeBracket.b25to29);

  TestResult r(String id, String exercise, num v, DateTime d) =>
      TestResult(id: id, exerciseId: exercise, value: v, date: d);

  test('пустые результаты → прогноз, нет данных', () {
    final s = summarizeResults(cohort: cohort, weightKg: 80, results: const []);
    expect(s.hasData, isFalse);
    expect(s.index.isForecast, isTrue);
  });

  test('ретест берёт последний результат, а не среднее двух', () {
    final results = [
      r('a', 'bench_press', 80, DateTime(2026, 1, 1)),
      r('b', 'bench_press', 120, DateTime(2026, 6, 1)), // позже
    ];
    final s = summarizeResults(cohort: cohort, weightKg: 80, results: results);
    final strength = s.categoryScores['strength']!;
    // Учтён один тест (последний), не два.
    expect(strength.testCount, 1);
    // 120 кг при нормативе 24..160 → ~70.6
    expect(strength.score, closeTo(70.6, 0.5));
  });

  test('две категории оценены, индекс — среднее по ним, прогноз (2 из 8)', () {
    final results = [
      r('a', 'bench_press', 100, DateTime(2026, 6, 1)),
      r('b', 'pull_ups', 15, DateTime(2026, 6, 1)),
      r('c', 'sit_and_reach', 10, DateTime(2026, 6, 1)),
      r('d', 'deep_squat', 4, DateTime(2026, 6, 1)),
    ];
    final s = summarizeResults(cohort: cohort, weightKg: 80, results: results);
    expect(s.categoryScores.keys.toSet(), {'strength', 'flexibility'});
    expect(s.index.assessedCategories, 2);
    expect(s.index.isForecast, isTrue);
    expect(s.weakLinkSlug, isNotNull);
  });

  test('силовой балл считается по весу тела из результата, а не по fallback', () {
    final withSnapshot = summarizeResults(
      cohort: cohort,
      weightKg: 100, // fallback тяжелее
      results: [
        TestResult(
          id: 'a',
          exerciseId: 'bench_press',
          value: 100,
          date: DateTime(2026, 6, 1),
          bodyweightKg: 80, // снимок: легче → выше относительный балл
        ),
        r('b', 'pull_ups', 10, DateTime(2026, 6, 1)),
      ],
    );
    final withoutSnapshot = summarizeResults(
      cohort: cohort,
      weightKg: 100,
      results: [
        r('a', 'bench_press', 100, DateTime(2026, 6, 1)),
        r('b', 'pull_ups', 10, DateTime(2026, 6, 1)),
      ],
    );
    expect(withSnapshot.categoryScores['strength']!.score,
        greaterThan(withoutSnapshot.categoryScores['strength']!.score));
  });

  test('добавление результата не понижает индекс, если балл выше текущего', () {
    final base = [
      r('a', 'bench_press', 60, DateTime(2026, 6, 1)),
      r('b', 'pull_ups', 5, DateTime(2026, 6, 1)),
    ];
    final before = summarizeResults(cohort: cohort, weightKg: 80, results: base);
    final after = summarizeResults(
      cohort: cohort,
      weightKg: 80,
      results: [...base, r('c', 'pull_ups', 30, DateTime(2026, 7, 1))],
    );
    // Последний pull_ups = 30 (лучше 5) → балл силы вырос.
    expect(after.categoryScores['strength']!.score,
        greaterThan(before.categoryScores['strength']!.score));
  });
}
