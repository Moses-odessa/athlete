import '../../domain/entities/category.dart';
import '../../domain/entities/localized_text.dart';

/// Slug'и восьми категорий-осей радара (ТЗ разд. 2.2).
class CategorySlugs {
  static const strength = 'strength';
  static const speed = 'speed';
  static const endurance = 'endurance';
  static const explosive = 'explosive';
  static const coordination = 'coordination';
  static const flexibility = 'flexibility';
  static const balance = 'balance';
  static const mobility = 'mobility';
}

/// Все 8 категорий заводятся сразу (для полного радара), но тесты в MVP есть
/// только для 4 (ТЗ разд. 12). Остальные помечены `availableInMvp: false`.
const List<Category> kCategories = [
  Category(
    slug: CategorySlugs.strength,
    name: LocalizedText(ru: 'Сила', en: 'Strength'),
    radarOrder: 0,
    iconKey: 'strength',
    availableInMvp: true,
  ),
  Category(
    slug: CategorySlugs.speed,
    name: LocalizedText(ru: 'Скорость', en: 'Speed'),
    radarOrder: 1,
    iconKey: 'speed',
    availableInMvp: true,
  ),
  Category(
    slug: CategorySlugs.endurance,
    name: LocalizedText(ru: 'Выносливость', en: 'Endurance'),
    radarOrder: 2,
    iconKey: 'endurance',
    availableInMvp: true,
  ),
  Category(
    slug: CategorySlugs.explosive,
    name: LocalizedText(ru: 'Взрывная сила', en: 'Explosive power'),
    radarOrder: 3,
    iconKey: 'explosive',
    availableInMvp: true,
  ),
  Category(
    slug: CategorySlugs.coordination,
    name: LocalizedText(ru: 'Координация', en: 'Coordination'),
    radarOrder: 4,
    iconKey: 'coordination',
    availableInMvp: true,
  ),
  Category(
    slug: CategorySlugs.flexibility,
    name: LocalizedText(ru: 'Гибкость', en: 'Flexibility'),
    radarOrder: 5,
    iconKey: 'flexibility',
    availableInMvp: true,
  ),
  Category(
    slug: CategorySlugs.balance,
    name: LocalizedText(ru: 'Баланс', en: 'Balance'),
    radarOrder: 6,
    iconKey: 'balance',
    availableInMvp: true,
  ),
  Category(
    slug: CategorySlugs.mobility,
    name: LocalizedText(ru: 'Мобильность', en: 'Mobility'),
    radarOrder: 7,
    iconKey: 'mobility',
    availableInMvp: true,
  ),
];
