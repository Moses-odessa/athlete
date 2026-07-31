import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../domain/entities/localized_text.dart';

/// Показывает инфо-модалку теста с 7 разделами (ТЗ разд. 4.4).
Future<void> showExerciseInfo(BuildContext context, String exerciseId) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _ExerciseInfoSheet(exerciseId: exerciseId),
  );
}

class _ExerciseInfoSheet extends StatelessWidget {
  const _ExerciseInfoSheet({required this.exerciseId});
  final String exerciseId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exercise = Catalog.exerciseById(exerciseId);
    final info = Catalog.infoFor(exerciseId);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (context, controller) {
        if (exercise == null || info == null) {
          return const Center(child: Text('—'));
        }
        return ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: [
            Text(context.tr(exercise.name),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(context.tr(exercise.shortDescription),
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            _Section(title: l10n.infoWhatMeasures, text: info.whatMeasures),
            _Section(title: l10n.infoWhyNeeded, text: info.whyNeeded),
            _ListSection(
                title: l10n.infoHowToPerform,
                items: info.howToPerform,
                numbered: true),
            _Section(title: l10n.infoHowToEnter, text: info.howToEnter),
            _ListSection(
                title: l10n.infoCommonMistakes,
                items: info.commonMistakes,
                numbered: false),
            _Section(title: l10n.infoSafety, text: info.safety),
            _Section(title: l10n.infoRadarImpact, text: info.radarImpact),
          ],
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.text});
  final String title;
  final LocalizedText text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 4),
          Text(context.tr(text)),
        ],
      ),
    );
  }
}

class _ListSection extends StatelessWidget {
  const _ListSection({
    required this.title,
    required this.items,
    required this.numbered,
  });
  final String title;
  final List<LocalizedText> items;
  final bool numbered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 4),
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(numbered ? '${i + 1}. ' : '•  '),
                  Expanded(child: Text(context.tr(items[i]))),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
