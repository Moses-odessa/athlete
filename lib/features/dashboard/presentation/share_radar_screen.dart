import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/radar_chart_view.dart';
import '../../../domain/entities/gender.dart';
import '../application/dashboard_controller.dart';

/// Экран шеринга радара картинкой (соцфича, roadmap M3).
class ShareRadarScreen extends ConsumerStatefulWidget {
  const ShareRadarScreen({super.key});

  @override
  ConsumerState<ShareRadarScreen> createState() => _ShareRadarScreenState();
}

class _ShareRadarScreenState extends ConsumerState<ShareRadarScreen> {
  final _cardKey = GlobalKey();

  Future<void> _share() async {
    final boundary =
        _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return;
    final Uint8List png = byteData.buffer.asUint8List();

    ref.read(analyticsProvider).log(AnalyticsEvents.radarShared);
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(png, mimeType: 'image/png', name: 'athlete_radar.png'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.shareRadar)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: RepaintBoundary(
            key: _cardKey,
            child: _ShareCard(state: state),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _share,
        icon: const Icon(Icons.share),
        label: Text(l10n.shareAction),
      ),
    );
  }
}

class _ShareCard extends StatelessWidget {
  const _ShareCard({required this.state});
  final DashboardState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.appTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(l10n.athleteIndexTitle,
              style: Theme.of(context).textTheme.bodySmall),
          Text(
            state.hasData ? state.index.value.round().toString() : '—',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: scheme.primary),
          ),
          if (state.hasData)
            Text(state.index.level.label,
                style: Theme.of(context).textTheme.titleMedium),
          if (state.cohort != null)
            Text(_cohort(l10n), style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          SizedBox(
            width: 260,
            height: 260,
            child: RadarChartView(categoryScores: state.categoryScores),
          ),
        ],
      ),
    );
  }

  String _cohort(AppLocalizations l10n) {
    final c = state.cohort!;
    final g = switch (c.gender) {
      Gender.male => l10n.genderMale,
      Gender.female => l10n.genderFemale,
      Gender.unspecified => l10n.genderUnspecified,
    };
    return '${l10n.cohortStandardPrefix} ${g.toLowerCase()}, ${c.ageBracket.label}';
  }
}
