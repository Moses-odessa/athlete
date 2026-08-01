import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/catalog_seed.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../domain/entities/test_result.dart';
import '../application/reaction_math.dart';

enum _Phase { idle, waiting, ready, finished }

/// Тест реакции: экран меняет цвет через случайный интервал, замер по касанию
/// (ТЗ разд. 5.2). Точный отсчёт через [Stopwatch] (микросекунды), а не Ticker.
class ReactionScreen extends ConsumerStatefulWidget {
  const ReactionScreen({super.key});

  @override
  ConsumerState<ReactionScreen> createState() => _ReactionScreenState();
}

class _ReactionScreenState extends ConsumerState<ReactionScreen> {
  static const _trialCount = 5;
  final _rand = Random();
  final _stopwatch = Stopwatch();
  final List<int> _trials = [];
  Timer? _timer;
  _Phase _phase = _Phase.idle;
  int? _lastMs;
  String? _message;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _armGreen() {
    _timer?.cancel();
    _timer = Timer(
      Duration(milliseconds: 1500 + _rand.nextInt(2500)),
      () {
        _stopwatch
          ..reset()
          ..start();
        setState(() => _phase = _Phase.ready);
      },
    );
  }

  void _startWaiting() {
    setState(() {
      _phase = _Phase.waiting;
      _message = null;
    });
    _armGreen();
  }

  void _finish() {
    final avg = averageMs(_trials).round();
    ref.read(resultsControllerProvider.notifier).add(
          TestResult(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            exerciseId: 'reaction_test',
            value: avg,
            date: DateTime.now(),
          ),
        );
    setState(() => _phase = _Phase.finished);
  }

  void _onTap() {
    switch (_phase) {
      case _Phase.idle:
        _startWaiting();
      case _Phase.waiting:
        // Фальстарт: касание до зелёного — перезапуск попытки.
        _timer?.cancel();
        setState(() => _message = AppLocalizations.of(context).reactionTooEarly);
        _armGreen();
      case _Phase.ready:
        _stopwatch.stop();
        final ms = _stopwatch.elapsedMilliseconds;
        _trials.add(ms);
        _lastMs = ms;
        if (_trials.length >= _trialCount) {
          _finish();
        } else {
          _startWaiting();
        }
      case _Phase.finished:
        break;
    }
  }

  Color _bg(ColorScheme scheme) {
    switch (_phase) {
      case _Phase.waiting:
        return scheme.errorContainer;
      case _Phase.ready:
        return Colors.green;
      case _Phase.idle:
      case _Phase.finished:
        return scheme.surface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final exercise = Catalog.exerciseById('reaction_test');

    return Scaffold(
      appBar: AppBar(
          title: Text(exercise == null ? '' : context.tr(exercise.name))),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Container(
          color: _bg(scheme),
          width: double.infinity,
          child: Center(
            child: _phase == _Phase.finished
                ? _finishedView(context, l10n)
                : _playView(context, l10n),
          ),
        ),
      ),
    );
  }

  Widget _playView(BuildContext context, AppLocalizations l10n) {
    final String text;
    switch (_phase) {
      case _Phase.idle:
        text = l10n.reactionTapToStart;
      case _Phase.waiting:
        text = l10n.reactionWait;
      case _Phase.ready:
        text = l10n.reactionTapNow;
      case _Phase.finished:
        text = '';
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text('${l10n.reactionTrial}: ${_trials.length}/$_trialCount'),
        if (_lastMs != null) Text('$_lastMs ${l10n.unitMilliseconds}'),
        if (_message != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(_message!,
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
      ],
    );
  }

  Widget _finishedView(BuildContext context, AppLocalizations l10n) {
    final avg = averageMs(_trials).round();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${l10n.reactionAverage}: $avg ${l10n.unitMilliseconds}',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(_trials.map((e) => '$e').join(' · ')),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.reactionSaved)),
            );
            context.pop();
          },
          child: Text(l10n.finish),
        ),
      ],
    );
  }
}
