import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../data/models/recommendations_seed.dart';

/// Рекомендации по прокачке категории (ТЗ разд. 4.11).
class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key, required this.categorySlug});
  final String categorySlug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final category = Catalog.categoryBySlug(categorySlug);
    final items = recommendationsFor(categorySlug);

    return Scaffold(
      appBar: AppBar(
        title: Text(category == null
            ? l10n.improveTitle
            : '${l10n.improveTitle}: ${context.tr(category.name)}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l10n.improveWhy),
            ),
          ),
          const SizedBox(height: 12),
          for (final r in items)
            Card(
              child: ListTile(
                leading: const Icon(Icons.tips_and_updates),
                title: Text(context.tr(r.title)),
                subtitle: Text(context.tr(r.description)),
              ),
            ),
        ],
      ),
    );
  }
}
