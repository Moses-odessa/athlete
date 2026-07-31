import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/models/catalog_seed.dart';
import '../../domain/entities/category_score.dart';
import '../l10n/localized_text_ext.dart';

/// Радарная диаграмма 8 качеств (ТЗ разд. 2.2, 4.2). Оси — в порядке radarOrder;
/// значение оси = балл категории (0 — если не оценена). Шкала зафиксирована 0–100
/// прозрачным опорным датасетом.
class RadarChartView extends StatelessWidget {
  const RadarChartView({super.key, required this.categoryScores});

  final Map<String, CategoryScore> categoryScores;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ordered = [...Catalog.categories]
      ..sort((a, b) => a.radarOrder.compareTo(b.radarOrder));

    double valueFor(String slug) => categoryScores[slug]?.score ?? 0;

    return RadarChart(
      RadarChartData(
        radarShape: RadarShape.polygon,
        tickCount: 4,
        ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 1),
        tickBorderData: BorderSide(color: scheme.outlineVariant, width: 0.5),
        gridBorderData: BorderSide(color: scheme.outlineVariant, width: 0.5),
        radarBorderData: BorderSide(color: scheme.outlineVariant, width: 1),
        titlePositionPercentageOffset: 0.18,
        getTitle: (index, angle) => RadarChartTitle(
          text: context.tr(ordered[index].name),
        ),
        titleTextStyle: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
        dataSets: [
          // Опорный прозрачный датасет фиксирует внешнюю границу на 100.
          RadarDataSet(
            fillColor: Colors.transparent,
            borderColor: Colors.transparent,
            entryRadius: 0,
            borderWidth: 0,
            dataEntries: [
              for (var i = 0; i < ordered.length; i++)
                const RadarEntry(value: 100),
            ],
          ),
          RadarDataSet(
            fillColor: scheme.primary.withValues(alpha: 0.25),
            borderColor: scheme.primary,
            borderWidth: 2,
            entryRadius: 3,
            dataEntries: [
              for (final c in ordered) RadarEntry(value: valueFor(c.slug)),
            ],
          ),
        ],
      ),
    );
  }
}
