import 'localized_text.dart';

/// Основная цель пользователя (ТЗ разд. 4.1).
enum TrainingGoal {
  generalFitness,
  competition,
  rehabilitation,
  fun;

  LocalizedText get label {
    switch (this) {
      case TrainingGoal.generalFitness:
        return const LocalizedText(ru: 'Общая форма', en: 'General fitness');
      case TrainingGoal.competition:
        return const LocalizedText(ru: 'Соревнования', en: 'Competition');
      case TrainingGoal.rehabilitation:
        return const LocalizedText(ru: 'Реабилитация', en: 'Rehabilitation');
      case TrainingGoal.fun:
        return const LocalizedText(ru: 'Развлечение', en: 'Fun');
    }
  }
}
