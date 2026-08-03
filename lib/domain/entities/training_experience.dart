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
        return const LocalizedText(
          ru: 'Нет опыта',
          en: 'No experience',
          uk: 'Немає досвіду',
          de: 'Keine Erfahrung',
          it: 'Nessuna esperienza',
          fr: 'Aucune expérience',
        );
      case TrainingExperience.upToOneYear:
        return const LocalizedText(
          ru: 'До года',
          en: 'Up to a year',
          uk: 'До року',
          de: 'Bis zu einem Jahr',
          it: 'Fino a un anno',
          fr: 'Jusqu\'à un an',
        );
      case TrainingExperience.oneToThreeYears:
        return const LocalizedText(
          ru: '1–3 года',
          en: '1–3 years',
          uk: '1–3 роки',
          de: '1–3 Jahre',
          it: '1–3 anni',
          fr: '1–3 ans',
        );
      case TrainingExperience.threePlusYears:
        return const LocalizedText(
          ru: '3+ лет',
          en: '3+ years',
          uk: '3+ роки',
          de: '3+ Jahre',
          it: '3+ anni',
          fr: '3+ ans',
        );
    }
  }
}
