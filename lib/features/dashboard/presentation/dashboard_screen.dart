import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../core/widgets/radar_chart_view.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../domain/entities/gender.dart';
import '../../history/application/history_controller.dart';
import '../../peers/application/peer_comparison.dart';
import '../../report/application/pdf_report.dart';
import '../application/dashboard_controller.dart';

/// Главный экран: Индекс атлета, радар 8 качеств, слабое звено (ТЗ разд. 4.2).
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          if (state.hasData)
            IconButton(
              icon: const Icon(Icons.share),
              tooltip: l10n.shareRadar,
              onPressed: () => context.push('/share-radar'),
            ),
          if (state.hasData)
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: l10n.exportPdf,
              onPressed: () => _exportPdf(context, ref),
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settingsTitle,
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
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
          if (ref.watch(peerComparisonProvider).available) ...[
            const SizedBox(height: 16),
            _PeerCard(percentile:
                ref.watch(peerComparisonProvider).overallPercentile),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.list_alt),
                  label: Text(l10n.allTests),
                  onPressed: () => context.push('/catalog'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.history),
                  label: Text(l10n.history),
                  onPressed: () => context.push('/history'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            icon: const Icon(Icons.fitness_center),
            label: Text(l10n.batteriesTitle),
            onPressed: () => context.push('/batteries'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportPdf(BuildContext context, WidgetRef ref) async {
    final profile = ref.read(profileControllerProvider);
    final state = ref.read(dashboardProvider);
    if (profile == null || state.cohort == null) return;
    final records = ref.read(personalRecordsProvider);
    final lang = Localizations.localeOf(context).languageCode;
    final bytes = await buildAthleteReportPdf(
      languageCode: lang,
      profile: profile,
      cohort: state.cohort!,
      index: state.index,
      categoryScores: state.categoryScores,
      records: records,
      now: DateTime.now(),
    );
    ref.read(analyticsProvider).log(AnalyticsEvents.pdfExported);
    await Printing.sharePdf(bytes: bytes, filename: 'athlete-report.pdf');
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
        trailing: FilledButton(
          onPressed: () => context.push('/improve/$slug'),
          child: Text(l10n.improveCta),
        ),
        onTap: () => context.push('/improve/$slug'),
      ),
    );
  }
}

class _PeerCard extends StatelessWidget {
  const _PeerCard({required this.percentile});
  final double percentile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.groups),
        title: Text(l10n.peerTitle),
        subtitle: Text(
            '${l10n.peerHigherThan} ${percentile.round()}% ${l10n.peerCohort}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/peers'),
      ),
    );
  }
}
