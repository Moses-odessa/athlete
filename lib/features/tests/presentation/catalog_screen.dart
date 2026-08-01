import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/profile_repository.dart';
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

    final profile = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.catalogTitle)),
      body: ListView(
        padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom),
        children: [
          ListTile(
            leading: const Icon(Icons.monitor_weight),
            title: Text(l10n.updateWeight),
            subtitle: profile == null
                ? null
                : Text('${profile.weightKg} ${l10n.unitKilograms}'),
            onTap: () => _editMetric(context, ref, isWeight: true),
          ),
          ListTile(
            leading: const Icon(Icons.height),
            title: Text(l10n.updateHeight),
            subtitle: profile == null
                ? null
                : Text('${profile.heightCm} ${l10n.unitCentimeters}'),
            onTap: () => _editMetric(context, ref, isWeight: false),
          ),
          const Divider(),
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

  Future<void> _editMetric(
    BuildContext context,
    WidgetRef ref, {
    required bool isWeight,
  }) async {
    final l10n = AppLocalizations.of(context);
    final profile = ref.read(profileControllerProvider);
    if (profile == null) return;
    final controller = TextEditingController(
      text: (isWeight ? profile.weightKg : profile.heightCm).toString(),
    );
    final value = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isWeight ? l10n.updateWeight : l10n.updateHeight),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: isWeight ? l10n.currentWeight : l10n.currentHeight,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(
              double.tryParse(controller.text.replaceAll(',', '.')),
            ),
            child: Text(l10n.saveShort),
          ),
        ],
      ),
    );
    if (value == null || value <= 0) return;
    if (isWeight) {
      ref.read(profileControllerProvider.notifier).updateWeight(value);
    } else {
      ref.read(profileControllerProvider.notifier).updateHeight(value);
    }
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
