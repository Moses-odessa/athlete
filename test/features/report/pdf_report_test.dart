import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/features/dashboard/application/athlete_summary.dart';
import 'package:athlete_index/features/report/application/pdf_report.dart';
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
  TestWidgetsFlutterBinding.ensureInitialized();

  test('PDF-отчёт генерируется с валидным заголовком %PDF', () async {
    const cohort = Cohort(Gender.male, AgeBracket.b25to29);
    final summary = summarizeResults(
      cohort: cohort,
      weightKg: 80,
      results: [
        TestResult(
            id: 'a',
            exerciseId: 'bench_press',
            value: 100,
            date: DateTime(2026, 6, 1)),
        TestResult(
            id: 'b',
            exerciseId: 'pull_ups',
            value: 15,
            date: DateTime(2026, 6, 1)),
      ],
    );

    final bytes = await buildAthleteReportPdf(
      languageCode: 'ru',
      profile: _profile(),
      cohort: cohort,
      index: summary.index,
      categoryScores: summary.categoryScores,
      records: const [],
      now: DateTime(2026, 8, 1),
    );

    expect(bytes.length, greaterThan(2000));
    expect(String.fromCharCodes(bytes.take(4)), '%PDF');
  });
}
