import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../application/catalog_controller.dart';
import 'exercise_info_sheet.dart';

/// Каталог тестов: категория → тест (ТЗ разд. 4.3).
class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scores = ref.watch(exerciseScoresProvider);
    final categories = [...Catalog.categories]
      ..sort((a, b) => a.radarOrder.compareTo(b.radarOrder));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.catalogTitle)),
      body: ListView(
        children: [
          for (final category in categories)
            _CategorySection(
              categorySlug: category.slug,
              title: context.tr(category.name),
              available: category.availableInMvp,
              scores: scores,
            ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.categorySlug,
    required this.title,
    required this.available,
    required this.scores,
  });

  final String categorySlug;
  final String title;
  final bool available;
  final Map<String, double> scores;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!available) {
      return ListTile(
        title: Text(title),
        trailing: Chip(label: Text(l10n.comingSoon)),
        enabled: false,
      );
    }

    final exercises = Catalog.exercisesFor(categorySlug);
    return ExpansionTile(
      title: Text(title),
      initiallyExpanded: true,
      children: [
        for (final exercise in exercises)
          ListTile(
            title: Text(context.tr(exercise.name)),
            subtitle: Text(
              scores.containsKey(exercise.id)
                  ? '${l10n.currentScore}: ${scores[exercise.id]!.round()}'
                  : l10n.notTested,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer(
                  builder: (context, ref, _) => IconButton(
                    icon: const Icon(Icons.info_outline),
                    tooltip: l10n.infoTitle,
                    onPressed: () {
                      ref.read(analyticsProvider).log(
                        AnalyticsEvents.infoOpened,
                        {'exerciseId': exercise.id},
                      );
                      showExerciseInfo(context, exercise.id);
                    },
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () => context.push(
              exercise.id == 'reaction_test'
                  ? '/reaction'
                  : '/entry/${exercise.id}',
            ),
          ),
      ],
    );
  }
}
