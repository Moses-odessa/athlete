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
        return const LocalizedText(
          ru: 'Общая форма',
          en: 'General fitness',
          uk: 'Загальна форма',
          de: 'Allgemeine Fitness',
          it: 'Forma fisica generale',
          fr: 'Forme physique générale',
        );
      case TrainingGoal.competition:
        return const LocalizedText(
          ru: 'Соревнования',
          en: 'Competition',
          uk: 'Змагання',
          de: 'Wettkampf',
          it: 'Competizione',
          fr: 'Compétition',
        );
      case TrainingGoal.rehabilitation:
        return const LocalizedText(
          ru: 'Реабилитация',
          en: 'Rehabilitation',
          uk: 'Реабілітація',
          de: 'Rehabilitation',
          it: 'Riabilitazione',
          fr: 'Rééducation',
        );
      case TrainingGoal.fun:
        return const LocalizedText(
          ru: 'Развлечение',
          en: 'Fun',
          uk: 'Розвага',
          de: 'Spaß',
          it: 'Divertimento',
          fr: 'Loisir',
        );
    }
  }
}
