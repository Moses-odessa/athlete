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
        return const LocalizedText(ru: 'Штанга', en: 'Barbell');
      case Equipment.dumbbells:
        return const LocalizedText(ru: 'Гантели', en: 'Dumbbells');
      case Equipment.pullUpBar:
        return const LocalizedText(ru: 'Турник', en: 'Pull-up bar');
      case Equipment.treadmill:
        return const LocalizedText(ru: 'Беговая дорожка', en: 'Treadmill');
      case Equipment.rowingMachine:
        return const LocalizedText(ru: 'Гребной тренажёр', en: 'Rowing machine');
      case Equipment.bicycle:
        return const LocalizedText(ru: 'Велосипед', en: 'Bicycle');
      case Equipment.outdoorArea:
        return const LocalizedText(ru: 'Открытая площадка', en: 'Outdoor area');
    }
  }
}
