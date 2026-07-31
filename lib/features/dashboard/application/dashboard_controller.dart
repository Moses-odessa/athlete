import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../domain/entities/athlete_index_result.dart';
import '../../../domain/entities/category_score.dart';
import '../../../domain/entities/cohort.dart';
import 'athlete_summary.dart';

/// Производное состояние главного экрана (ТЗ разд. 4.2).
class DashboardState {
  final Cohort? cohort;
  final Map<String, CategoryScore> categoryScores;
  final AthleteIndexResult index;
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

/// Считает сводку дашборда из профиля и результатов (ТЗ разд. 4.6–4.8).
final dashboardProvider = Provider<DashboardState>((ref) {
  final profile = ref.watch(profileControllerProvider);
  final results = ref.watch(resultsControllerProvider);

  if (profile == null) {
    return const DashboardState(
      cohort: null,
      categoryScores: {},
      index: AthleteSummary.emptyIndex,
      weakLinkSlug: null,
      hasProfile: false,
    );
  }

  final cohort = profile.cohortAsOf(DateTime.now());
  final summary = summarizeResults(
    cohort: cohort,
    weightKg: profile.weightKg,
    results: results,
  );

  return DashboardState(
    cohort: cohort,
    categoryScores: summary.categoryScores,
    index: summary.index,
    weakLinkSlug: summary.weakLinkSlug,
    hasProfile: true,
  );
});
