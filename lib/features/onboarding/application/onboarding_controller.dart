import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';

/// Черновик данных онбординга (ТЗ разд. 4.1). Поля опциональны, пока шаг не пройден.
class OnboardingDraft {
  final Gender? gender;
  final DateTime? dateOfBirth;
  final double? weightKg;
  final double? heightCm;
  final TrainingExperience? experience;
  final Set<Equipment> equipment;
  final TrainingGoal? goal;
  final List<bool> parqAnswers;
  final bool acceptedTerms;

  OnboardingDraft({
    this.gender,
    this.dateOfBirth,
    this.weightKg,
    this.heightCm,
    this.experience,
    Set<Equipment>? equipment,
    this.goal,
    List<bool>? parqAnswers,
    this.acceptedTerms = false,
  })  : equipment = equipment ?? <Equipment>{},
        parqAnswers = parqAnswers ??
            List<bool>.filled(ParqQuestionnaire.questionCount, false);

  OnboardingDraft copyWith({
    Gender? gender,
    DateTime? dateOfBirth,
    double? weightKg,
    double? heightCm,
    TrainingExperience? experience,
    Set<Equipment>? equipment,
    TrainingGoal? goal,
    List<bool>? parqAnswers,
    bool? acceptedTerms,
  }) {
    return OnboardingDraft(
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      experience: experience ?? this.experience,
      equipment: equipment ?? this.equipment,
      goal: goal ?? this.goal,
      parqAnswers: parqAnswers ?? this.parqAnswers,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    );
  }

  ParqQuestionnaire get parq => ParqQuestionnaire(parqAnswers);
}

class OnboardingController extends Notifier<OnboardingDraft> {
  @override
  OnboardingDraft build() => OnboardingDraft();

  void setGender(Gender value) => state = state.copyWith(gender: value);
  void setDateOfBirth(DateTime value) =>
      state = state.copyWith(dateOfBirth: value);
  void setWeight(double value) => state = state.copyWith(weightKg: value);
  void setHeight(double value) => state = state.copyWith(heightCm: value);
  void setExperience(TrainingExperience value) =>
      state = state.copyWith(experience: value);
  void setGoal(TrainingGoal value) => state = state.copyWith(goal: value);
  void setAcceptedTerms(bool value) =>
      state = state.copyWith(acceptedTerms: value);

  void toggleEquipment(Equipment value) {
    final next = Set<Equipment>.from(state.equipment);
    next.contains(value) ? next.remove(value) : next.add(value);
    state = state.copyWith(equipment: next);
  }

  void setParqAnswer(int index, bool value) {
    final next = List<bool>.from(state.parqAnswers);
    next[index] = value;
    state = state.copyWith(parqAnswers: next);
  }

  /// Готов ли черновик к сохранению (обязательные поля + принятое соглашение).
  bool get isComplete {
    final d = state;
    return d.gender != null &&
        d.dateOfBirth != null &&
        d.weightKg != null &&
        d.weightKg! > 0 &&
        d.heightCm != null &&
        d.heightCm! > 0 &&
        d.experience != null &&
        d.goal != null &&
        d.acceptedTerms;
  }

  /// Собрать профиль из черновика. [id] — генерируется вызывающей стороной.
  UserProfile buildProfile(String id) {
    final d = state;
    return UserProfile(
      id: id,
      gender: d.gender!,
      dateOfBirth: d.dateOfBirth!,
      weightKg: d.weightKg!,
      heightCm: d.heightCm!,
      experience: d.experience!,
      equipment: d.equipment,
      goal: d.goal!,
      parqPassed: d.parq.passed,
      acceptedTerms: d.acceptedTerms,
    );
  }
}

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, OnboardingDraft>(
        OnboardingController.new);
