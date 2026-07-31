/// Текстовый уровень подготовки (ТЗ разд. 2.3). Применяется и к категории,
/// и к общему Индексу атлета.
enum AthleteLevel {
  novice,
  beginner,
  intermediate,
  advanced,
  elite,
  athlete;

  /// Нижняя граница диапазона уровня (включительно).
  int get minScore {
    switch (this) {
      case AthleteLevel.novice:
        return 0;
      case AthleteLevel.beginner:
        return 20;
      case AthleteLevel.intermediate:
        return 40;
      case AthleteLevel.advanced:
        return 60;
      case AthleteLevel.elite:
        return 80;
      case AthleteLevel.athlete:
        return 95;
    }
  }

  /// Отображаемое название уровня.
  String get label {
    switch (this) {
      case AthleteLevel.novice:
        return 'Novice';
      case AthleteLevel.beginner:
        return 'Beginner';
      case AthleteLevel.intermediate:
        return 'Intermediate';
      case AthleteLevel.advanced:
        return 'Advanced';
      case AthleteLevel.elite:
        return 'Elite';
      case AthleteLevel.athlete:
        return 'Athlete';
    }
  }
}
