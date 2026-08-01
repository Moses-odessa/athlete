import 'package:athlete_index/core/analytics/analytics.dart';
import 'package:athlete_index/data/repositories/profile_repository.dart';
import 'package:athlete_index/core/router/app_router.dart';
import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _CapturingAnalytics implements AnalyticsService {
  final events = <String>[];
  @override
  void log(String event, [Map<String, Object?> props = const {}]) =>
      events.add(event);
}

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
  test('LoggingAnalytics не бросает', () {
    const LoggingAnalytics().log(AnalyticsEvents.resultSaved, {'a': 1});
  });

  testWidgets('ввод результата шлёт test_opened и result_saved',
      (tester) async {
    tester.view.physicalSize = const Size(1000, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final analytics = _CapturingAnalytics();
    final container = ProviderContainer(
      overrides: [analyticsProvider.overrideWithValue(analytics)],
    );
    addTearDown(container.dispose);
    container.read(profileControllerProvider.notifier).save(_profile());

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const AthleteApp(),
      ),
    );
    await tester.pumpAndSettle();

    container.read(routerProvider).push('/entry/pull_ups');
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Result'), '20');
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    expect(analytics.events, contains(AnalyticsEvents.testOpened));
    expect(analytics.events, contains(AnalyticsEvents.resultSaved));
  });
}
