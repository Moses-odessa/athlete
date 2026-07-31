import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../domain/entities/test_result.dart';
import '../../../domain/scoring/scoring.dart';

/// Текущий балл по каждому упражнению (по последнему результату), slug теста → балл.
final exerciseScoresProvider = Provider<Map<String, double>>((ref) {
  final profile = ref.watch(profileControllerProvider);
  final results = ref.watch(resultsControllerProvider);
  if (profile == null) return const {};

  final cohort = profile.cohortAsOf(DateTime.now());
  final scale = ref.watch(settingsControllerProvider).scaleType;

  final latest = <String, TestResult>{};
  for (final r in results) {
    final current = latest[r.exerciseId];
    if (current == null || r.date.isAfter(current.date)) {
      latest[r.exerciseId] = r;
    }
  }

  final scores = <String, double>{};
  latest.forEach((id, result) {
    final exercise = Catalog.exerciseById(id);
    if (exercise != null) {
      scores[id] = scoreTest(
        exercise,
        result.value,
        cohort,
        bodyweightKg: profile.weightKg,
        scaleOverride: scale,
      ).normalizedScore;
    }
  });
  return scores;
});
