import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../domain/scoring/level.dart';
import '../application/history_controller.dart';

/// История и прогресс: динамика индекса и личные рекорды (ТЗ разд. 4.10).
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final points = ref.watch(indexHistoryProvider);
    final records = ref.watch(personalRecordsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.history)),
      body: records.isEmpty
          ? Center(child: Text(l10n.historyEmpty))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(l10n.indexOverTime,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                if (points.length < 2)
                  _InfoCard(text: l10n.notEnoughData)
                else ...[
                  SizedBox(height: 220, child: _IndexChart(points: points)),
                  const SizedBox(height: 8),
                  _LastChange(points: points),
                ],
                const SizedBox(height: 24),
                Text(l10n.personalRecords,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                for (final record in records) _RecordTile(record: record),
              ],
            ),
    );
  }
}

class _IndexChart extends StatelessWidget {
  const _IndexChart({required this.points});
  final List<IndexPoint> points;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final spots = [
      for (var i = 0; i < points.length; i++)
        FlSpot(i.toDouble(), points[i].index),
    ];
    // Показываем не более ~6 подписей дат по оси X.
    final step = (points.length / 6).ceil().clamp(1, points.length);

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 100,
        gridData: FlGridData(
          show: true,
          horizontalInterval: 25,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: scheme.outlineVariant, strokeWidth: 0.5),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 25,
              reservedSize: 32,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final i = value.round();
                if (i < 0 || i >= points.length || i % step != 0) {
                  return const SizedBox.shrink();
                }
                final d = points[i].date;
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '${d.day.toString().padLeft(2, '0')}.'
                    '${d.month.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            color: scheme.primary,
            barWidth: 3,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: scheme.primary.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }
}

class _LastChange extends StatelessWidget {
  const _LastChange({required this.points});
  final List<IndexPoint> points;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final delta = points.last.index - points[points.length - 2].index;
    final positive = delta >= 0;
    final color = positive ? Colors.green : Theme.of(context).colorScheme.error;
    return Row(
      children: [
        Icon(positive ? Icons.trending_up : Icons.trending_down, color: color),
        const SizedBox(width: 8),
        Text('${l10n.lastChange}: '),
        Text(
          '${positive ? '+' : ''}${delta.toStringAsFixed(1)}',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _RecordTile extends StatelessWidget {
  const _RecordTile({required this.record});
  final PersonalRecord record;

  @override
  Widget build(BuildContext context) {
    final exercise = Catalog.exerciseById(record.exerciseId);
    final name =
        exercise == null ? record.exerciseId : context.tr(exercise.name);
    final d = record.date;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.emoji_events),
      title: Text(name),
      subtitle: Text('${d.day.toString().padLeft(2, '0')}.'
          '${d.month.toString().padLeft(2, '0')}.${d.year}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            record.score.round().toString(),
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(levelForScore(record.score).label,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
