import 'package:athlete_index/core/router/app_router.dart';
import 'package:athlete_index/data/repositories/profile_repository.dart';
import 'package:athlete_index/data/repositories/results_repository.dart';
import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/features/tests/presentation/entry_screen.dart';
import 'package:athlete_index/main.dart';
import 'package:flutter/material.dart';
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
  testWidgets('ввод результата сохраняется и виден в результатах',
      (tester) async {
    // Высокое окно, чтобы длинный экран ввода помещался целиком.
    tester.view.physicalSize = const Size(1000, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(profileControllerProvider.notifier).save(_profile());

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const AthleteApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Переходим на экран ввода конкретного теста через роутер.
    container.read(routerProvider).push('/entry/pull_ups');
    await tester.pumpAndSettle();
    expect(find.byType(EntryScreen), findsOneWidget);

    // Вводим значение (повторения) в поле результата.
    await tester.enterText(find.widgetWithText(TextField, 'Result'), '20');
    await tester.pumpAndSettle();

    // Сохраняем.
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    final results = container.read(resultsControllerProvider);
    expect(results.length, 1);
    expect(results.first.exerciseId, 'pull_ups');
    expect(results.first.value, 20);
  });
}
