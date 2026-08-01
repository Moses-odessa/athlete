import 'package:athlete_index/core/widgets/radar_chart_view.dart';
import 'package:athlete_index/data/repositories/profile_repository.dart';
import 'package:athlete_index/data/repositories/results_repository.dart';
import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/features/dashboard/application/demo_results.dart';
import 'package:athlete_index/features/dashboard/presentation/share_radar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:athlete_index/core/l10n/app_localizations.dart';

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
  testWidgets('экран шеринга рендерит карточку с радаром и кнопку',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(profileControllerProvider.notifier).save(_profile());
    container
        .read(resultsControllerProvider.notifier)
        .setAll(buildDemoResults(DateTime(2026, 7, 31)));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShareRadarScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(RadarChartView), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
