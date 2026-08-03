import 'localized_text.dart';

/// Доступное оборудование (ТЗ разд. 4.1). Используется для фильтрации доступных
/// тестов на последующих итерациях.
enum Equipment {
  barbell,
  dumbbells,
  pullUpBar,
  treadmill,
  rowingMachine,
  bicycle,
  outdoorArea;

  LocalizedText get label {
    switch (this) {
      case Equipment.barbell:
        return const LocalizedText(
            ru: 'Штанга',
            en: 'Barbell',
            uk: 'Штанга',
            de: 'Langhantel',
            it: 'Bilanciere',
            fr: 'Barre');
      case Equipment.dumbbells:
        return const LocalizedText(
            ru: 'Гантели',
            en: 'Dumbbells',
            uk: 'Гантелі',
            de: 'Kurzhanteln',
            it: 'Manubri',
            fr: 'Haltères');
      case Equipment.pullUpBar:
        return const LocalizedText(
            ru: 'Турник',
            en: 'Pull-up bar',
            uk: 'Турнік',
            de: 'Klimmzugstange',
            it: 'Sbarra per trazioni',
            fr: 'Barre de traction');
      case Equipment.treadmill:
        return const LocalizedText(
            ru: 'Беговая дорожка',
            en: 'Treadmill',
            uk: 'Бігова доріжка',
            de: 'Laufband',
            it: 'Tapis roulant',
            fr: 'Tapis de course');
      case Equipment.rowingMachine:
        return const LocalizedText(
            ru: 'Гребной тренажёр',
            en: 'Rowing machine',
            uk: 'Веслувальний тренажер',
            de: 'Rudergerät',
            it: 'Vogatore',
            fr: 'Rameur');
      case Equipment.bicycle:
        return const LocalizedText(
            ru: 'Велосипед',
            en: 'Bicycle',
            uk: 'Велосипед',
            de: 'Fahrrad',
            it: 'Bicicletta',
            fr: 'Vélo');
      case Equipment.outdoorArea:
        return const LocalizedText(
            ru: 'Открытая площадка',
            en: 'Outdoor area',
            uk: 'Відкритий майданчик',
            de: 'Außenbereich',
            it: 'Area all\'aperto',
            fr: 'Espace extérieur');
    }
  }
}
