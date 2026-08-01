import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/features/settings/application/data_transfer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('encode → decode round-trip профиля и результатов', () {
    final profile = UserProfile(
      id: 'local',
      gender: Gender.female,
      dateOfBirth: DateTime(1995, 3, 10),
      weightKg: 62.5,
      heightCm: 168,
      experience: TrainingExperience.threePlusYears,
      equipment: const {Equipment.barbell, Equipment.pullUpBar},
      goal: TrainingGoal.competition,
      parqPassed: false,
      acceptedTerms: true,
    );
    final results = [
      TestResult(
          id: 'r1',
          exerciseId: 'pull_ups',
          value: 12,
          date: DateTime(2026, 6, 1),
          note: 'strict'),
      TestResult(
          id: 'r2',
          exerciseId: 'bench_press',
          value: 90,
          date: DateTime(2026, 5, 1)),
    ];

    final json = encodeUserDataJson(
        profile: profile, results: results, now: DateTime(2026, 8, 1));
    final decoded = decodeUserDataJson(json);

    expect(decoded.profile, isNotNull);
    expect(decoded.profile!.gender, Gender.female);
    expect(decoded.profile!.weightKg, 62.5);
    expect(decoded.profile!.equipment,
        {Equipment.barbell, Equipment.pullUpBar});
    expect(decoded.profile!.parqPassed, isFalse);
    expect(decoded.results.length, 2);
    expect(decoded.results.first.exerciseId, 'pull_ups');
    expect(decoded.results.first.note, 'strict');
  });

  test('невалидный JSON бросает исключение', () {
    expect(() => decodeUserDataJson('not json'), throwsA(anything));
  });
}
