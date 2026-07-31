import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../domain/entities/athlete_index_result.dart';
import '../../../domain/entities/athlete_level.dart';
import '../../../domain/entities/category_score.dart';
import '../../../domain/entities/cohort.dart';
import '../../../domain/entities/score.dart';
import '../../../domain/scoring/scoring.dart';

/// Производное состояние главного экрана (ТЗ разд. 4.2, 4.7, 4.8).
class DashboardState {
  final Cohort? cohort;

  /// Баллы оценённых категорий по slug.
  final Map<String, CategoryScore> categoryScores;

  final AthleteIndexResult index;

  /// Slug самой отстающей оценённой категории (ТЗ разд. 4.11), либо null.
  final String? weakLinkSlug;

  final bool hasProfile;

  const DashboardState({
    required this.cohort,
    required this.categoryScores,
    required this.index,
    required this.weakLinkSlug,
    required this.hasProfile,
  });

  bool get hasData => categoryScores.isNotEmpty;
}

/// Считает баллы категорий и индекс из результатов и профиля (ТЗ разд. 4.6–4.8).
final dashboardProvider = Provider<DashboardState>((ref) {
  final profile = ref.watch(profileControllerProvider);
  final results = ref.watch(resultsControllerProvider);

  const emptyIndex = AthleteIndexResult(
    value: 0,
    level: AthleteLevel.novice,
    assessedCategories: 0,
    totalCategories: 8,
    isForecast: true,
  );

  if (profile == null) {
    return const DashboardState(
      cohort: null,
      categoryScores: {},
      index: emptyIndex,
      weakLinkSlug: null,
      hasProfile: false,
    );
  }

  final cohort = profile.cohortAsOf(DateTime.now());

  // Группируем баллы тестов по категориям.
  final byCategory = <String, List<Score>>{};
  for (final result in results) {
    final exercise = Catalog.exerciseById(result.exerciseId);
    if (exercise == null) continue;
    final score = scoreTest(
      exercise,
      result.value,
      cohort,
      bodyweightKg: profile.weightKg,
    );
    byCategory.putIfAbsent(exercise.categorySlug, () => []).add(score);
  }

  final categoryScores = <String, CategoryScore>{};
  byCategory.forEach((slug, scores) {
    categoryScores[slug] = categoryScore(slug, scores);
  });

  final index = athleteIndex(categoryScores, totalCategories: 8);

  // Слабое звено — категория с наименьшим баллом среди оценённых.
  String? weakLink;
  var lowest = double.infinity;
  categoryScores.forEach((slug, cs) {
    if (cs.score < lowest) {
      lowest = cs.score;
      weakLink = slug;
    }
  });

  return DashboardState(
    cohort: cohort,
    categoryScores: categoryScores,
    index: index,
    weakLinkSlug: weakLink,
    hasProfile: true,
  );
});
