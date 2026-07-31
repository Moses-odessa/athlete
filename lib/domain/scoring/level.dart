import '../entities/athlete_level.dart';

/// Текстовый уровень по интегральному баллу (ТЗ разд. 2.3):
/// 0–19 Novice, 20–39 Beginner, 40–59 Intermediate,
/// 60–79 Advanced, 80–94 Elite, 95–100 Athlete.
AthleteLevel levelForScore(double score) {
  final s = score.clamp(0, 100);
  if (s < 20) return AthleteLevel.novice;
  if (s < 40) return AthleteLevel.beginner;
  if (s < 60) return AthleteLevel.intermediate;
  if (s < 80) return AthleteLevel.advanced;
  if (s < 95) return AthleteLevel.elite;
  return AthleteLevel.athlete;
}
