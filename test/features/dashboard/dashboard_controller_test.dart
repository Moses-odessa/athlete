import 'package:athlete_index/data/repositories/profile_repository.dart';
import 'package:athlete_index/data/repositories/results_repository.dart';
import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/features/dashboard/application/dashboard_controller.dart';
import 'package:athlete_index/features/dashboard/application/demo_results.dart';
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

void main() {
  late ProviderContainer container;

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  test('без профиля — пустое состояние', () {
    final state = container.read(dashboardProvider);
    expect(state.hasProfile, isFalse);
    expect(state.hasData, isFalse);
    expect(state.index.isForecast, isTrue);
  });

  test('профиль + демо-результаты → 4 категории, индекс в режиме прогноза', () {
    container.read(profileControllerProvider.notifier).save(_profile());
    container
        .read(resultsControllerProvider.notifier)
        .setAll(buildDemoResults(DateTime(2026, 7, 31)));

    final state = container.read(dashboardProvider);
    expect(state.hasProfile, isTrue);
    expect(state.categoryScores.length, 4); // 4 MVP-категории
    expect(state.index.assessedCategories, 4);
    expect(state.index.totalCategories, 8);
    expect(state.index.isForecast, isTrue); // 4 из 8
    expect(state.weakLinkSlug, isNotNull);
    // Каждая демо-категория содержит 2 теста → не частичная.
    for (final cs in state.categoryScores.values) {
      expect(cs.partiallyAssessed, isFalse);
    }
  });

  test('слабое звено — категория с минимальным баллом', () {
    container.read(profileControllerProvider.notifier).save(_profile());
    container
        .read(resultsControllerProvider.notifier)
        .setAll(buildDemoResults(DateTime(2026, 7, 31)));

    final state = container.read(dashboardProvider);
    final scores = state.categoryScores;
    final weak = state.weakLinkSlug!;
    final weakScore = scores[weak]!.score;
    for (final cs in scores.values) {
      expect(weakScore, lessThanOrEqualTo(cs.score));
    }
  });
}
