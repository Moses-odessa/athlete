import 'package:athlete_index/domain/entities/athlete_level.dart';
import 'package:athlete_index/domain/entities/score.dart';
import 'package:athlete_index/domain/scoring/category_score.dart';
import 'package:flutter_test/flutter_test.dart';

Score _score(double v) =>
    Score(exerciseId: 'x', rawValue: v, normalizedScore: v);

void main() {
  test('среднее арифметическое баллов тестов', () {
    final cs = categoryScore('strength', [_score(40), _score(60)]);
    expect(cs.score, 50);
    expect(cs.level, AthleteLevel.intermediate);
    expect(cs.testCount, 2);
    expect(cs.partiallyAssessed, isFalse);
  });

  test('один тест → частично оценена (минимум 2)', () {
    final cs = categoryScore('strength', [_score(70)]);
    expect(cs.score, 70);
    expect(cs.partiallyAssessed, isTrue);
    expect(cs.testCount, 1);
  });

  test('пустой список → 0 и частично', () {
    final cs = categoryScore('strength', []);
    expect(cs.score, 0);
    expect(cs.testCount, 0);
    expect(cs.partiallyAssessed, isTrue);
    expect(cs.level, AthleteLevel.novice);
  });

  test('кастомный minTests', () {
    final cs = categoryScore(
      'endurance',
      [_score(50), _score(50)],
      minTests: 3,
    );
    expect(cs.partiallyAssessed, isTrue);
  });
}
