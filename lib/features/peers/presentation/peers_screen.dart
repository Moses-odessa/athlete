import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../domain/entities/category.dart';
import '../application/peer_comparison.dart';

/// Сравнение с когортой: общий перцентиль и разбивка по категориям (ТЗ 4.12).
class PeersScreen extends ConsumerWidget {
  const PeersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final peers = ref.watch(peerComparisonProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.peerTitle)),
      body: !peers.available
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.peerLocked, textAlign: TextAlign.center),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(l10n.peerHigherThan,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          '${peers.overallPercentile.round()}%',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(l10n.peerCohort),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                for (final category in _orderedCategories())
                  if (peers.byCategory[category.slug] != null)
                    _CategoryRow(
                      name: context.tr(category.name),
                      percentile: peers.byCategory[category.slug]!,
                    ),
                const SizedBox(height: 16),
                Text(l10n.peerModelNote,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
    );
  }

  List<Category> _orderedCategories() => [...Catalog.categories]
    ..sort((a, b) => a.radarOrder.compareTo(b.radarOrder));
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.name, required this.percentile});
  final String name;
  final double percentile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Text('${percentile.round()}%',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (percentile / 100).clamp(0, 1),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
