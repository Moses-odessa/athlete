import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/results_repository.dart';
import '../../../domain/entities/athlete_index_result.dart';
import '../../../domain/entities/category_score.dart';
import '../../../domain/entities/localized_text.dart';
import '../../../domain/entities/test_result.dart';
import '../../dashboard/application/dashboard_controller.dart';
import '../../history/application/history_controller.dart';

/// Достижение/бейдж (ТЗ разд. 4.14).
class Achievement {
  final String id;
  final LocalizedText title;
  final LocalizedText description;
  final bool unlocked;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.unlocked,
  });
}

/// Чистое вычисление бейджей из текущего состояния (ТЗ разд. 4.14).
List<Achievement> buildAchievements({
  required AthleteIndexResult index,
  required Map<String, CategoryScore> categoryScores,
  required List<IndexPoint> history,
  required List<TestResult> results,
}) {
  final hasData = categoryScores.isNotEmpty;
  final distinctDays = results
      .map((r) => DateTime(r.date.year, r.date.month, r.date.day))
      .toSet()
      .length;

  var improvement = 0.0;
  if (history.length >= 2) {
    final first = history.first.index;
    final best = history.map((p) => p.index).reduce(max);
    improvement = best - first;
  }
  final anyElite = categoryScores.values.any((c) => c.score >= 80);
  final fullCycle = hasData && !index.isForecast;

  Achievement level(
    String id,
    int threshold,
    String name, {
    String? nameUk,
    String? nameDe,
    String? nameIt,
    String? nameFr,
  }) =>
      Achievement(
        id: id,
        title: LocalizedText(
            ru: name,
            en: name,
            uk: nameUk,
            de: nameDe,
            it: nameIt,
            fr: nameFr),
        description: LocalizedText(
            ru: 'Индекс ≥ $threshold',
            en: 'Index ≥ $threshold',
            uk: 'Індекс ≥ $threshold',
            de: 'Index ≥ $threshold',
            it: 'Indice ≥ $threshold',
            fr: 'Indice ≥ $threshold'),
        unlocked: hasData && index.value >= threshold,
      );

  Achievement gain(String id, int n) => Achievement(
        id: id,
        title: LocalizedText(
            ru: 'Рост +$n',
            en: '+$n gain',
            uk: 'Приріст +$n',
            de: '+$n Zuwachs',
            it: '+$n guadagno',
            fr: '+$n gain'),
        description: LocalizedText(
            ru: 'Индекс вырос на $n',
            en: 'Index improved by $n',
            uk: 'Індекс зріс на $n',
            de: 'Index um $n verbessert',
            it: 'Indice migliorato di $n',
            fr: 'Indice amélioré de $n'),
        unlocked: improvement >= n,
      );

  Achievement streak(String id, int days) => Achievement(
        id: id,
        title: LocalizedText(
            ru: '$days дней тестов',
            en: '$days test days',
            uk: '$days днів тестів',
            de: '$days Testtage',
            it: '$days giorni di test',
            fr: '$days jours de tests'),
        description: LocalizedText(
            ru: 'Тестирование в $days разных дней',
            en: 'Testing on $days different days',
            uk: 'Тестування в $days різних днів',
            de: 'Testen an $days verschiedenen Tagen',
            it: 'Test in $days giorni diversi',
            fr: 'Tests sur $days jours différents'),
        unlocked: distinctDays >= days,
      );

  return [
    Achievement(
      id: 'full_cycle',
      title: const LocalizedText(
          ru: 'Полный цикл',
          en: 'Full cycle',
          uk: 'Повний цикл',
          de: 'Voller Zyklus',
          it: 'Ciclo completo',
          fr: 'Cycle complet'),
      description: const LocalizedText(
          ru: 'Оценены все 8 категорий',
          en: 'All 8 categories assessed',
          uk: 'Оцінені всі 8 категорій',
          de: 'Alle 8 Kategorien bewertet',
          it: 'Tutte le 8 categorie valutate',
          fr: 'Les 8 catégories évaluées'),
      unlocked: fullCycle,
    ),
    level('idx_intermediate', 40, 'Intermediate',
        nameUk: 'Середній',
        nameDe: 'Mittelstufe',
        nameIt: 'Intermedio',
        nameFr: 'Intermédiaire'),
    level('idx_advanced', 60, 'Advanced',
        nameUk: 'Просунутий',
        nameDe: 'Fortgeschritten',
        nameIt: 'Avanzato',
        nameFr: 'Avancé'),
    level('idx_elite', 80, 'Elite',
        nameUk: 'Еліта', nameDe: 'Elite', nameIt: 'Elite', nameFr: 'Élite'),
    level('idx_athlete', 95, 'Athlete',
        nameUk: 'Атлет', nameDe: 'Athlet', nameIt: 'Atleta', nameFr: 'Athlète'),
    gain('improve_5', 5),
    gain('improve_10', 10),
    gain('improve_20', 20),
    Achievement(
      id: 'category_elite',
      title: const LocalizedText(
          ru: 'Элитная категория',
          en: 'Elite category',
          uk: 'Елітна категорія',
          de: 'Elite-Kategorie',
          it: 'Categoria élite',
          fr: 'Catégorie élite'),
      description: const LocalizedText(
          ru: 'Любая категория ≥ 80',
          en: 'Any category ≥ 80',
          uk: 'Будь-яка категорія ≥ 80',
          de: 'Beliebige Kategorie ≥ 80',
          it: 'Qualsiasi categoria ≥ 80',
          fr: 'Toute catégorie ≥ 80'),
      unlocked: anyElite,
    ),
    streak('streak_3', 3),
    streak('streak_7', 7),
  ];
}

final achievementsProvider = Provider<List<Achievement>>((ref) {
  final dashboard = ref.watch(dashboardProvider);
  final history = ref.watch(indexHistoryProvider);
  final results = ref.watch(resultsControllerProvider);
  return buildAchievements(
    index: dashboard.index,
    categoryScores: dashboard.categoryScores,
    history: history,
    results: results,
  );
});
