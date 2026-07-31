import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../data/models/science_content.dart';

/// Раздел «Научная база» (ТЗ разд. 4.16).
class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final mvpCategories = [...Catalog.categories.where((c) => c.availableInMvp)]
      ..sort((a, b) => a.radarOrder.compareTo(b.radarOrder));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.scienceTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(context.tr(kScienceIntro)),
          const SizedBox(height: 24),

          // Обоснование выбора каждого теста.
          _Heading(l10n.scienceRationale),
          for (final category in mvpCategories) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Text(context.tr(category.name),
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: theme.colorScheme.primary)),
            ),
            for (final ex in Catalog.exercisesFor(category.slug))
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr(ex.name),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    if (Catalog.infoFor(ex.id) != null)
                      Text(context.tr(Catalog.infoFor(ex.id)!.whyNeeded),
                          style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
          ],
          const SizedBox(height: 24),

          // Объяснение формулы расчёта.
          _Heading(l10n.scienceFormula),
          Text(context.tr(kScienceFormulaBody)),
          const SizedBox(height: 12),
          for (final f in kScienceFormulas)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(context.tr(f),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
            ),
          const SizedBox(height: 24),

          // Объяснение выбора нормативов.
          _Heading(l10n.scienceNorms),
          Text(context.tr(kScienceNormsBody)),
          const SizedBox(height: 24),

          // Первоисточники.
          _Heading(l10n.scienceReferences),
          for (final ref in kScienceReferences)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.link),
              title: Text(ref.title),
              subtitle: Text(ref.source),
              onTap: () => _open(ref.url),
            ),
          const Divider(height: 32),

          _Heading(l10n.scienceDisclaimerTitle),
          Text(context.tr(kScienceDisclaimer),
              style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
