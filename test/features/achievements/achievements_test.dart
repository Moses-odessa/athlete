import 'package:athlete_index/domain/entities/athlete_index_result.dart';
import 'package:athlete_index/domain/entities/athlete_level.dart';
import 'package:athlete_index/domain/entities/category_score.dart';
import 'package:athlete_index/domain/entities/test_result.dart';
import 'package:athlete_index/features/achievements/application/achievements.dart';
import 'package:athlete_index/features/history/application/history_controller.dart';
import 'package:flutter_test/flutter_test.dart';

AthleteIndexResult _index(double v, {bool forecast = false, int assessed = 8}) =>
    AthleteIndexResult(
      value: v,
      level: AthleteLevel.advanced,
      assessedCategories: assessed,
      totalCategories: 8,
      isForecast: forecast,
    );

bool _has(List<Achievement> a, String id) =>
    a.firstWhere((x) => x.id == id).unlocked;

void main() {
  test('нет данных → бейджи заблокированы', () {
    final a = buildAchievements(
      index: _index(0, forecast: true, assessed: 0),
      categoryScores: const {},
      history: const [],
      results: const [],
    );
    expect(a.every((x) => !x.unlocked), isTrue);
  });

  test('полный цикл, высокий индекс и рост разблокируют бейджи', () {
    final cats = {
      for (final s in ['strength', 'speed'])
        s: CategoryScore(
          categorySlug: s,
          score: 85,
          level: AthleteLevel.elite,
          testCount: 2,
          partiallyAssessed: false,
        ),
    };
    final a = buildAchievements(
      index: _index(65),
      categoryScores: cats,
      history: [
        IndexPoint(DateTime(2026, 1, 1), 50),
        IndexPoint(DateTime(2026, 6, 1), 65),
      ],
      results: [
        TestResult(
            id: '1',
            exerciseId: 'bench_press',
            value: 100,
            date: DateTime(2026, 1, 1)),
        TestResult(
            id: '2',
            exerciseId: 'pull_ups',
            value: 15,
            date: DateTime(2026, 6, 1)),
        TestResult(
            id: '3',
            exerciseId: 'run_3km',
            value: 800,
            date: DateTime(2026, 7, 1)),
      ],
    );

    expect(_has(a, 'full_cycle'), isTrue);
    expect(_has(a, 'idx_advanced'), isTrue); // 65 ≥ 60
    expect(_has(a, 'idx_elite'), isFalse); // 65 < 80
    expect(_has(a, 'improve_10'), isTrue); // +15
    expect(_has(a, 'improve_20'), isFalse);
    expect(_has(a, 'category_elite'), isTrue); // 85 ≥ 80
    expect(_has(a, 'streak_3'), isTrue); // 3 разных дня
  });
}
