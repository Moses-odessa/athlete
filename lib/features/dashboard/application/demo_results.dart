import '../../../domain/entities/test_result.dart';

/// Временные демо-результаты для превью радара до появления экрана ввода
/// результатов (следующая итерация). Покрывают 4 MVP-категории по 2 теста,
/// поэтому индекс считается в режиме «Прогноз» (оценены 4 из 8 категорий).
///
/// TODO: удалить вместе с кнопкой «демо» после реализации ввода результатов.
List<TestResult> buildDemoResults(DateTime now) {
  final samples = <String, num>{
    'bench_press': 85, // кг
    'pull_ups': 12,
    'run_3km': 780, // 13:00
    'cooper_test': 2800, // м
    'vertical_jump': 55, // см
    'standing_long_jump': 235, // см
    'sit_and_reach': 10, // см
    'deep_squat': 4, // качественная 1–5
  };

  var i = 0;
  return [
    for (final entry in samples.entries)
      TestResult(
        id: 'demo_${now.microsecondsSinceEpoch}_${i++}',
        exerciseId: entry.key,
        value: entry.value,
        date: now,
      ),
  ];
}
