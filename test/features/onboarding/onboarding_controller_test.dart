import 'package:athlete_index/domain/entities/entities.dart';
import 'package:athlete_index/features/onboarding/application/onboarding_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  late OnboardingController controller;

  setUp(() {
    container = ProviderContainer();
    controller = container.read(onboardingControllerProvider.notifier);
  });
  tearDown(() => container.dispose());

  void fillRequired() {
    controller
      ..setGender(Gender.male)
      ..setDateOfBirth(DateTime(1994, 1, 15))
      ..setWeight(80)
      ..setHeight(180)
      ..setExperience(TrainingExperience.oneToThreeYears)
      ..setGoal(TrainingGoal.generalFitness)
      ..setAcceptedTerms(true);
  }

  test('черновик неполон без обязательных полей', () {
    expect(controller.isComplete, isFalse);
  });

  test('без принятого соглашения черновик неполон', () {
    fillRequired();
    controller.setAcceptedTerms(false);
    expect(controller.isComplete, isFalse);
  });

  test('полный черновик → профиль, PAR-Q без «да» → passed', () {
    fillRequired();
    expect(controller.isComplete, isTrue);
    final profile = controller.buildProfile('id1');
    expect(profile.gender, Gender.male);
    expect(profile.weightKg, 80);
    expect(profile.parqPassed, isTrue);
    expect(profile.acceptedTerms, isTrue);
  });

  test('положительный ответ PAR-Q → предупреждение и parqPassed=false', () {
    fillRequired();
    controller.setParqAnswer(2, true);
    final draft = container.read(onboardingControllerProvider);
    expect(draft.parq.hasPositiveAnswer, isTrue);
    expect(controller.buildProfile('id2').parqPassed, isFalse);
  });

  test('переключение оборудования', () {
    controller.toggleEquipment(Equipment.barbell);
    controller.toggleEquipment(Equipment.pullUpBar);
    controller.toggleEquipment(Equipment.barbell); // снять
    final draft = container.read(onboardingControllerProvider);
    expect(draft.equipment, {Equipment.pullUpBar});
  });
}
