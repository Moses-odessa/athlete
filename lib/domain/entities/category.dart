import 'localized_text.dart';

/// Категория физического качества — одна из 8 осей радара (ТЗ разд. 2.2).
class Category {
  final String slug;
  final LocalizedText name;

  /// Порядок на радарной диаграмме (0..7), по списку ТЗ разд. 2.2.
  final int radarOrder;

  /// Ключ иконки категории (маппинг на ассет — на UI-итерации).
  final String iconKey;

  /// Доступна ли категория в MVP (ТЗ разд. 12). Остальные — «в разработке».
  final bool availableInMvp;

  const Category({
    required this.slug,
    required this.name,
    required this.radarOrder,
    required this.iconKey,
    this.availableInMvp = false,
  });
}
