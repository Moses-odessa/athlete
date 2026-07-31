import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../domain/entities/gender.dart';
import '../application/dashboard_controller.dart';
import '../application/demo_results.dart';
import 'radar_chart_view.dart';

/// Главный экран: Индекс атлета, радар 8 качеств, слабое звено (ТЗ разд. 4.2).
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _IndexCard(state: state),
          const SizedBox(height: 16),
          if (state.hasData)
            AspectRatio(
              aspectRatio: 1,
              child: RadarChartView(categoryScores: state.categoryScores),
            )
          else
            _EmptyRadarCard(message: l10n.takeTestsPrompt),
          const SizedBox(height: 16),
          if (state.weakLinkSlug != null)
            _WeakLinkCard(slug: state.weakLinkSlug!),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.list_alt),
                  label: Text(l10n.allTests),
                  onPressed: () => _comingSoon(context, l10n),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.history),
                  label: Text(l10n.history),
                  onPressed: () => _comingSoon(context, l10n),
                ),
              ),
            ],
          ),
          const Divider(height: 40),
          // Временные демо-контролы (до экрана ввода результатов).
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => ref
                      .read(resultsControllerProvider.notifier)
                      .setAll(buildDemoResults(DateTime.now())),
                  child: Text(l10n.loadDemoData),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () =>
                      ref.read(resultsControllerProvider.notifier).clear(),
                  child: Text(l10n.clearData),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _comingSoon(BuildContext context, AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.comingSoon)),
    );
  }
}

class _IndexCard extends StatelessWidget {
  const _IndexCard({required this.state});
  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final hasData = state.hasData;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(l10n.athleteIndexTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              hasData ? state.index.value.round().toString() : '—',
              style: theme.textTheme.displayLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (hasData) ...[
              Text(
                state.index.level.label,
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.primary),
              ),
              if (state.index.isForecast)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Chip(
                    avatar: const Icon(Icons.trending_up, size: 18),
                    label: Text(
                      '${l10n.athleteIndexForecast} · '
                      '${state.index.assessedCategories}/${state.index.totalCategories}',
                    ),
                  ),
                ),
            ],
            if (state.cohort != null) ...[
              const SizedBox(height: 8),
              Text(
                _cohortCaption(l10n, state),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _cohortCaption(AppLocalizations l10n, DashboardState state) {
    final cohort = state.cohort!;
    final gender = switch (cohort.gender) {
      Gender.male => l10n.genderMale,
      Gender.female => l10n.genderFemale,
      Gender.unspecified => l10n.genderUnspecified,
    };
    return '${l10n.cohortStandardPrefix} '
        '${gender.toLowerCase()}, ${cohort.ageBracket.label}';
  }
}

class _EmptyRadarCard extends StatelessWidget {
  const _EmptyRadarCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.radar,
                size: 48, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _WeakLinkCard extends StatelessWidget {
  const _WeakLinkCard({required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final category = Catalog.categoryBySlug(slug);
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        leading: const Icon(Icons.flag),
        title: Text(l10n.weakLinkTitle),
        subtitle: category == null ? null : Text(context.tr(category.name)),
      ),
    );
  }
}
