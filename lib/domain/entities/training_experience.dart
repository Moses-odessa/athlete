import 'localized_text.dart';

/// Опыт тренировок (ТЗ разд. 4.1).
enum TrainingExperience {
  none,
  upToOneYear,
  oneToThreeYears,
  threePlusYears;

  LocalizedText get label {
    switch (this) {
      case TrainingExperience.none:
        return const LocalizedText(ru: 'Нет опыта', en: 'No experience');
      case TrainingExperience.upToOneYear:
        return const LocalizedText(ru: 'До года', en: 'Up to a year');
      case TrainingExperience.oneToThreeYears:
        return const LocalizedText(ru: '1–3 года', en: '1–3 years');
      case TrainingExperience.threePlusYears:
        return const LocalizedText(ru: '3+ лет', en: '3+ years');
    }
  }
}
