import 'package:athlete_index/data/repositories/profile_repository.dart';
import 'package:athlete_index/data/repositories/results_repository.dart';
import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/features/history/application/history_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

UserProfile _profile() => UserProfile(
      id: 'u1',
      gender: Gender.male,
      dateOfBirth: DateTime(1994, 1, 15),
      weightKg: 80,
      heightCm: 180,
      experience: TrainingExperience.oneToThreeYears,
      equipment: const {},
      goal: TrainingGoal.generalFitness,
      parqPassed: true,
      acceptedTerms: true,
    );

TestResult _r(String id, String exercise, num v, DateTime d) =>
    TestResult(id: id, exerciseId: exercise, value: v, date: d);

void main() {
  late ProviderContainer container;
  setUp(() {
    container = ProviderContainer();
    container.read(profileControllerProvider.notifier).save(_profile());
  });
  tearDown(() => container.dispose());

  test('пустые результаты → пустая история и рекорды', () {
    expect(container.read(indexHistoryProvider), isEmpty);
    expect(container.read(personalRecordsProvider), isEmpty);
  });

  test('индекс растёт при улучшении: две точки, вторая выше', () {
    container.read(resultsControllerProvider.notifier).setAll([
      _r('a', 'bench_press', 60, DateTime(2026, 6, 1)),
      _r('b', 'pull_ups', 5, DateTime(2026, 6, 1)),
      _r('c', 'pull_ups', 30, DateTime(2026, 7, 1)), // улучшение позже
    ]);

    final points = container.read(indexHistoryProvider);
    expect(points.length, 2);
    expect(points[1].index, greaterThan(points[0].index));
    expect(points[0].date, DateTime(2026, 6, 1));
  });

  test('личный рекорд берёт лучший результат упражнения', () {
    container.read(resultsControllerProvider.notifier).setAll([
      _r('a', 'pull_ups', 5, DateTime(2026, 6, 1)),
      _r('b', 'pull_ups', 30, DateTime(2026, 7, 1)),
    ]);

    final records = container.read(personalRecordsProvider);
    final pullUps = records.firstWhere((r) => r.exerciseId == 'pull_ups');
    expect(pullUps.value, 30);
    // Рекорды отсортированы по убыванию балла.
    for (var i = 1; i < records.length; i++) {
      expect(records[i - 1].score, greaterThanOrEqualTo(records[i].score));
    }
  });
}
