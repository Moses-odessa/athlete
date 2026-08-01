import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/batteries_seed.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/results_repository.dart';

/// Прохождение баттереи: таймер сессии и последовательный ввод (ТЗ разд. 4.13).
class BatteryRunnerScreen extends ConsumerStatefulWidget {
  const BatteryRunnerScreen({super.key, required this.batteryId});
  final String batteryId;

  @override
  ConsumerState<BatteryRunnerScreen> createState() =>
      _BatteryRunnerScreenState();
}

class _BatteryRunnerScreenState extends ConsumerState<BatteryRunnerScreen> {
  late final DateTime _sessionStart;
  final _stopwatch = Stopwatch();
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _sessionStart = DateTime.now();
    _stopwatch.start();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String get _elapsed {
    final s = _stopwatch.elapsed.inSeconds;
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$m:$sec';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final battery = batteryById(widget.batteryId);
    final results = ref.watch(resultsControllerProvider);

    if (battery == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    bool isDone(String exerciseId) => results.any((r) =>
        r.exerciseId == exerciseId && !r.date.isBefore(_sessionStart));

    final doneCount = battery.exerciseIds.where(isDone).length;

    return Scaffold(
      appBar: AppBar(title: Text(context.tr(battery.name))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Icon(Icons.timer),
                  const SizedBox(width: 8),
                  Text('${l10n.batterySessionTime}: $_elapsed'),
                ]),
                Text(
                    '${l10n.batteryProgress}: $doneCount/${battery.exerciseIds.length}'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final id in battery.exerciseIds)
                  _ExerciseRow(
                    exerciseId: id,
                    done: isDone(id),
                    onRecord: () => context.push(
                      id == 'reaction_test' ? '/reaction' : '/entry/$id',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({
    required this.exerciseId,
    required this.done,
    required this.onRecord,
  });
  final String exerciseId;
  final bool done;
  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final exercise = Catalog.exerciseById(exerciseId);
    return ListTile(
      leading: Icon(
        done ? Icons.check_circle : Icons.radio_button_unchecked,
        color: done ? Colors.green : Theme.of(context).colorScheme.outline,
      ),
      title: Text(exercise == null ? exerciseId : context.tr(exercise.name)),
      trailing: done
          ? Text(l10n.batteryDone)
          : FilledButton(onPressed: onRecord, child: Text(l10n.batteryRecord)),
    );
  }
}
