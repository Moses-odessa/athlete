import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../application/weekly_plan.dart';

/// Экран недельного плана по слабым звеньям (ТЗ разд. 4.11 пост-MVP).
class WeeklyPlanScreen extends ConsumerWidget {
  const WeeklyPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final plan = ref.watch(weeklyPlanProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.planTitle)),
      body: plan.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.planEmpty, textAlign: TextAlign.center),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final day in plan) _DayCard(day: day),
              ],
            ),
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({required this.day});
  final PlanDay day;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final category =
        day.categorySlug == null ? null : Catalog.categoryBySlug(day.categorySlug!);
    final headline = category == null
        ? context.tr(day.title)
        : '${context.tr(day.title)}: ${context.tr(category.name)}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  child: Text('${day.day}'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${l10n.planDay} ${day.day} · $headline',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (final r in day.items)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•  '),
                    Expanded(child: Text(context.tr(r.title))),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(context.tr(day.note),
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
