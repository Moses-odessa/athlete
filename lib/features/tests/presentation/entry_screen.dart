import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../core/widgets/radar_chart_view.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../domain/entities/cohort.dart';
import '../../../domain/entities/exercise.dart';
import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/test_result.dart';
import '../../../domain/scoring/level.dart';
import '../../../domain/scoring/resolve_standards.dart';
import '../../../domain/scoring/score_test.dart';
import '../../dashboard/application/athlete_summary.dart';

/// Ввод результата теста с расчётом балла в реальном времени и превью изменения
/// индекса и радара до сохранения (ТЗ разд. 4.5).
class EntryScreen extends ConsumerStatefulWidget {
  const EntryScreen({super.key, required this.exerciseId});

  final String exerciseId;

  @override
  ConsumerState<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends ConsumerState<EntryScreen> {
  final _valueController = TextEditingController();
  final _minController = TextEditingController();
  final _secController = TextEditingController();
  final _noteController = TextEditingController();
  int _rating = 3;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
  }

  @override
  void dispose() {
    _valueController.dispose();
    _minController.dispose();
    _secController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Exercise? get _exercise => Catalog.exerciseById(widget.exerciseId);

  /// Текущее введённое значение в единицах теста (null — если не задано/невалидно).
  num? _enteredValue(Exercise exercise) {
    switch (exercise.unit) {
      case MeasurementUnit.qualitative1to5:
        return _rating;
      case MeasurementUnit.seconds:
        final m = int.tryParse(_minController.text) ?? 0;
        final s = int.tryParse(_secController.text) ?? 0;
        if (_minController.text.isEmpty && _secController.text.isEmpty) {
          return null;
        }
        return m * 60 + s;
      default:
        return double.tryParse(_valueController.text.replaceAll(',', '.'));
    }
  }

  String _unitSuffix(AppLocalizations l10n, MeasurementUnit unit) {
    switch (unit) {
      case MeasurementUnit.meters:
        return l10n.unitMeters;
      case MeasurementUnit.centimeters:
        return l10n.unitCentimeters;
      case MeasurementUnit.kilograms:
      case MeasurementUnit.bodyweightMultiple:
        return l10n.unitKilograms;
      case MeasurementUnit.reps:
        return l10n.unitReps;
      case MeasurementUnit.seconds:
        return l10n.unitSeconds;
      case MeasurementUnit.qualitative1to5:
        return '';
    }
  }

  void _save(Exercise exercise, num value) {
    ref.read(resultsControllerProvider.notifier).add(
          TestResult(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            exerciseId: exercise.id,
            value: value,
            date: _date,
            note: _noteController.text.isEmpty ? null : _noteController.text,
          ),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).savedSnack)),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exercise = _exercise;
    final profile = ref.watch(profileControllerProvider);

    if (exercise == null || profile == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    final now = DateTime.now();
    final cohort = profile.cohortAsOf(now);
    final results = ref.watch(resultsControllerProvider);
    final value = _enteredValue(exercise);

    final score = value == null
        ? null
        : scoreTest(exercise, value, cohort, bodyweightKg: profile.weightKg)
            .normalizedScore;

    final currentSummary = summarizeResults(
      cohort: cohort,
      weightKg: profile.weightKg,
      results: results,
    );
    final afterSummary = value == null
        ? null
        : summarizeResults(
            cohort: cohort,
            weightKg: profile.weightKg,
            results: [
              ...results,
              TestResult(
                id: 'preview',
                exerciseId: exercise.id,
                value: value,
                date: now,
              ),
            ],
          );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(exercise.name)),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfo(context, exercise, cohort, profile.weightKg),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            context.tr(exercise.shortDescription),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          _InputArea(
            exercise: exercise,
            valueController: _valueController,
            minController: _minController,
            secController: _secController,
            rating: _rating,
            unitSuffix: _unitSuffix(l10n, exercise.unit),
            onChanged: () => setState(() {}),
            onRatingChanged: (v) => setState(() => _rating = v),
          ),
          const SizedBox(height: 20),
          _ScoreCard(score: score),
          if (afterSummary != null) ...[
            const SizedBox(height: 16),
            _IndexPreviewCard(
              before: currentSummary.index.value,
              after: afterSummary.index.value,
              isForecast: afterSummary.index.isForecast,
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1,
              child: RadarChartView(categoryScores: afterSummary.categoryScores),
            ),
          ],
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today),
            title: Text(l10n.fieldDate),
            subtitle: Text(
              '${_date.day.toString().padLeft(2, '0')}.'
              '${_date.month.toString().padLeft(2, '0')}.${_date.year}',
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(now.year - 5),
                lastDate: now,
              );
              if (picked != null) setState(() => _date = picked);
            },
          ),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: l10n.fieldNote,
              border: const OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            icon: const Icon(Icons.save),
            label: Text(l10n.save),
            onPressed:
                value == null ? null : () => _save(exercise, value),
          ),
        ],
      ),
    );
  }

  void _showInfo(
    BuildContext context,
    Exercise exercise,
    Cohort cohort,
    double weightKg,
  ) {
    final l10n = AppLocalizations.of(context);
    final category = Catalog.categoryBySlug(exercise.categorySlug);
    final std = exercise.isQualitative
        ? null
        : resolveStandards(exercise, cohort, bodyweightKg: weightKg);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.infoTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${l10n.infoCategory}: '
                '${category == null ? '' : context.tr(category.name)}'),
            const SizedBox(height: 8),
            Text(exercise.higherIsBetter
                ? l10n.infoDirectionHigher
                : l10n.infoDirectionLower),
            if (std != null) ...[
              const SizedBox(height: 8),
              Text('${l10n.infoStandard}: '
                  '${std.min.toStringAsFixed(1)} → ${std.max.toStringAsFixed(1)}'),
            ],
            const SizedBox(height: 12),
            Text(l10n.infoDetailsSoon,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _InputArea extends StatelessWidget {
  const _InputArea({
    required this.exercise,
    required this.valueController,
    required this.minController,
    required this.secController,
    required this.rating,
    required this.unitSuffix,
    required this.onChanged,
    required this.onRatingChanged,
  });

  final Exercise exercise;
  final TextEditingController valueController;
  final TextEditingController minController;
  final TextEditingController secController;
  final int rating;
  final String unitSuffix;
  final VoidCallback onChanged;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    switch (exercise.unit) {
      case MeasurementUnit.qualitative1to5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.ratingLabel),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: [
                for (var i = 1; i <= 5; i++)
                  ButtonSegment(value: i, label: Text('$i')),
              ],
              selected: {rating},
              onSelectionChanged: (s) => onRatingChanged(s.first),
            ),
          ],
        );
      case MeasurementUnit.seconds:
        return Row(
          children: [
            Expanded(
              child: TextField(
                controller: minController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: l10n.unitMinutes,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: secController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: l10n.unitSeconds,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        );
      default:
        return TextField(
          controller: valueController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: l10n.fieldResult,
            suffixText: unitSuffix,
            border: const OutlineInputBorder(),
          ),
          onChanged: (_) => onChanged(),
        );
    }
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.score});
  final double? score;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.scoreLabel, style: theme.textTheme.titleMedium),
            if (score == null)
              Text('—', style: theme.textTheme.headlineMedium)
            else
              Row(
                children: [
                  Text(
                    score!.round().toString(),
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  Chip(label: Text(levelForScore(score!).label)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _IndexPreviewCard extends StatelessWidget {
  const _IndexPreviewCard({
    required this.before,
    required this.after,
    required this.isForecast,
  });

  final double before;
  final double after;
  final bool isForecast;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final delta = after - before;
    final deltaColor = delta >= 0 ? Colors.green : theme.colorScheme.error;

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(l10n.indexLabel, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(l10n.previewNow, style: theme.textTheme.bodySmall),
                    Text(before.round().toString(),
                        style: theme.textTheme.headlineSmall),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.arrow_forward,
                      color: theme.colorScheme.primary),
                ),
                Column(
                  children: [
                    Text(l10n.previewAfter, style: theme.textTheme.bodySmall),
                    Text(after.round().toString(),
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(width: 12),
                Text(
                  '${delta >= 0 ? '+' : ''}${delta.toStringAsFixed(1)}',
                  style: theme.textTheme.titleMedium?.copyWith(color: deltaColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
