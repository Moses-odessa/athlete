import 'package:athlete_index/data/models/catalog_seed.dart';
import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/features/dashboard/application/athlete_summary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('8 категорий доступны, в каждой ≥ 2 теста', () {
    final available =
        Catalog.categories.where((c) => c.availableInMvp).toList();
    expect(available.length, 8);
    for (final c in available) {
      expect(Catalog.exercisesFor(c.slug).length, greaterThanOrEqualTo(2),
          reason: c.slug);
    }
  });

  test('у всех тестов каталога есть инфо-контент', () {
    for (final ex in Catalog.exercises) {
      expect(Catalog.infoFor(ex.id), isNotNull, reason: ex.id);
    }
  });

  test('полный цикл (2 теста в каждой из 8) → индекс не прогноз', () {
    const cohort = Cohort(Gender.male, AgeBracket.b25to29);
    final results = <TestResult>[];
    var i = 0;
    for (final c in Catalog.categories) {
      for (final e in Catalog.exercisesFor(c.slug).take(2)) {
        results.add(TestResult(
          id: 'r${i++}',
          exerciseId: e.id,
          value: e.isQualitative ? 4 : 10,
          date: DateTime(2026, 6, 1),
        ));
      }
    }
    final summary =
        summarizeResults(cohort: cohort, weightKg: 80, results: results);
    expect(summary.index.assessedCategories, 8);
    expect(summary.index.isForecast, isFalse);
  });
}
