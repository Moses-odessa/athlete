import 'cohort.dart';
import 'equipment.dart';
import 'gender.dart';
import 'training_experience.dart';
import 'training_goal.dart';

/// Профиль пользователя (ТЗ разд. 4.1, 11). Собирается в онбординге.
class UserProfile {
  final String id;
  final Gender gender;
  final DateTime dateOfBirth;
  final double weightKg;
  final double heightCm;
  final TrainingExperience experience;
  final Set<Equipment> equipment;
  final TrainingGoal goal;

  /// Прошёл ли PAR-Q без ограничений (ТЗ разд. 15).
  final bool parqPassed;

  /// Принято пользовательское соглашение и политика конфиденциальности
  /// (обязательно, ТЗ разд. 4.1).
  final bool acceptedTerms;

  const UserProfile({
    required this.id,
    required this.gender,
    required this.dateOfBirth,
    required this.weightKg,
    required this.heightCm,
    required this.experience,
    required this.equipment,
    required this.goal,
    required this.parqPassed,
    required this.acceptedTerms,
  });

  /// Когорта пользователя на указанный момент (для нормировки баллов).
  Cohort cohortAsOf(DateTime asOf) =>
      Cohort.forUser(gender: gender, dateOfBirth: dateOfBirth, asOf: asOf);

  UserProfile copyWith({
    Gender? gender,
    DateTime? dateOfBirth,
    double? weightKg,
    double? heightCm,
    TrainingExperience? experience,
    Set<Equipment>? equipment,
    TrainingGoal? goal,
    bool? parqPassed,
    bool? acceptedTerms,
  }) =>
      UserProfile(
        id: id,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        weightKg: weightKg ?? this.weightKg,
        heightCm: heightCm ?? this.heightCm,
        experience: experience ?? this.experience,
        equipment: equipment ?? this.equipment,
        goal: goal ?? this.goal,
        parqPassed: parqPassed ?? this.parqPassed,
        acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      );
}
