import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/categories_seed.dart';
import '../../../data/models/recommendations_seed.dart';
import '../../../domain/entities/localized_text.dart';
import '../../dashboard/application/dashboard_controller.dart';

/// День недельного плана (ТЗ разд. 4.11 пост-MVP, roadmap M3).
class PlanDay {
  final int day;
  final LocalizedText title;

  /// Категория-фокус (null — день восстановления/отдыха).
  final String? categorySlug;
  final List<Recommendation> items;
  final LocalizedText note;

  const PlanDay({
    required this.day,
    required this.title,
    required this.categorySlug,
    required this.items,
    required this.note,
  });

  bool get isRest => categorySlug == null && items.isEmpty;
}

LocalizedText _t(String ru, String en,
        {String? uk, String? de, String? it, String? fr}) =>
    LocalizedText(ru: ru, en: en, uk: uk, de: de, it: it, fr: fr);

const _progression = LocalizedText(
  ru: 'Прибавьте 1 подход или ~5% нагрузки к прошлой неделе.',
  en: 'Add one set or ~5% load versus last week.',
  uk: 'Додайте 1 підхід або ~5% навантаження до минулого тижня.',
  de: 'Füge einen Satz oder ~5% Last gegenüber der Vorwoche hinzu.',
  it: 'Aggiungi una serie o ~5% di carico rispetto alla scorsa settimana.',
  fr: 'Ajoutez une série ou ~5% de charge par rapport à la semaine dernière.',
);

/// Генерирует 7-дневный план для 1–2 самых отстающих категорий с чередованием
/// нагрузки, прогрессией и днями восстановления (ТЗ разд. 4.11).
List<PlanDay> generateWeeklyPlan(List<String> weakSlugs) {
  if (weakSlugs.isEmpty) return const [];
  final primary = weakSlugs.first;
  final secondary = weakSlugs.length > 1 ? weakSlugs[1] : primary;

  PlanDay focus(int day, String slug, {bool progression = false}) => PlanDay(
        day: day,
        title: _t('Фокус', 'Focus',
            uk: 'Фокус', de: 'Fokus', it: 'Focus', fr: 'Focus'),
        categorySlug: slug,
        items: recommendationsFor(slug),
        note: progression
            ? _progression
            : _t('Качественно, с разминкой.', 'Quality work, warm up first.',
                uk: 'Якісно, з розминкою.',
                de: 'Qualitativ, erst aufwärmen.',
                it: 'Lavoro di qualità, prima riscaldati.',
                fr: 'Travail de qualité, échauffez-vous d\'abord.'),
      );

  return [
    focus(1, primary),
    focus(2, secondary),
    PlanDay(
      day: 3,
      title: _t('Восстановление', 'Recovery',
          uk: 'Відновлення',
          de: 'Erholung',
          it: 'Recupero',
          fr: 'Récupération'),
      categorySlug: CategorySlugs.mobility,
      items: recommendationsFor(CategorySlugs.mobility),
      note: _t('Лёгкая мобилити-работа.', 'Light mobility work.',
          uk: 'Легка мобіліті-робота.',
          de: 'Leichte Mobility-Arbeit.',
          it: 'Lavoro di mobilità leggero.',
          fr: 'Travail de mobilité léger.'),
    ),
    focus(4, primary, progression: true),
    focus(5, secondary, progression: true),
    PlanDay(
      day: 6,
      title: _t('Активное восстановление', 'Active recovery',
          uk: 'Активне відновлення',
          de: 'Aktive Erholung',
          it: 'Recupero attivo',
          fr: 'Récupération active'),
      categorySlug: null,
      items: const [],
      note: _t('Прогулка/лёгкое кардио 20–30 мин.',
          'Walk / easy cardio 20–30 min.',
          uk: 'Прогулянка/легке кардіо 20–30 хв.',
          de: 'Spaziergang / lockeres Cardio 20–30 min.',
          it: 'Camminata / cardio leggero 20–30 min.',
          fr: 'Marche / cardio léger 20–30 min.'),
    ),
    PlanDay(
      day: 7,
      title: _t('Отдых', 'Rest',
          uk: 'Відпочинок', de: 'Ruhe', it: 'Riposo', fr: 'Repos'),
      categorySlug: null,
      items: const [],
      note: _t('Полный отдых и сон.', 'Full rest and sleep.',
          uk: 'Повний відпочинок і сон.',
          de: 'Vollständige Ruhe und Schlaf.',
          it: 'Riposo completo e sonno.',
          fr: 'Repos complet et sommeil.'),
    ),
  ];
}

/// 1–2 самые отстающие оценённые категории (по возрастанию балла).
final weakestCategoriesProvider = Provider<List<String>>((ref) {
  final scores = ref.watch(dashboardProvider).categoryScores;
  final entries = scores.entries.toList()
    ..sort((a, b) => a.value.score.compareTo(b.value.score));
  return entries.take(2).map((e) => e.key).toList();
});

final weeklyPlanProvider = Provider<List<PlanDay>>((ref) {
  return generateWeeklyPlan(ref.watch(weakestCategoriesProvider));
});
