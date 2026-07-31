import 'package:athlete_index/domain/entities/athlete_level.dart';
import 'package:athlete_index/domain/entities/category_score.dart';
import 'package:athlete_index/domain/scoring/athlete_index.dart';
import 'package:flutter_test/flutter_test.dart';

CategoryScore _cat(String slug, double score, {bool partial = false}) =>
    CategoryScore(
      categorySlug: slug,
      score: score,
      level: AthleteLevel.intermediate,
      testCount: partial ? 1 : 2,
      partiallyAssessed: partial,
    );

void main() {
  test('среднее по категориям', () {
    final idx = athleteIndex({
      'a': _cat('a', 40),
      'b': _cat('b', 60),
    });
    expect(idx.value, 50);
    expect(idx.assessedCategories, 2);
  });

  test('4 из 8 категорий → прогноз (ТЗ 4.7)', () {
    final idx = athleteIndex({
      for (final s in ['a', 'b', 'c', 'd']) s: _cat(s, 50),
    });
    expect(idx.isForecast, isTrue);
    expect(idx.assessedCategories, 4);
    expect(idx.totalCategories, 8);
  });

  test('все 8 полных категорий → индекс полный', () {
    final idx = athleteIndex({
      for (final s in ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']) s: _cat(s, 70),
    });
    expect(idx.isForecast, isFalse);
    expect(idx.assessedCategories, 8);
  });

  test('8 категорий, но одна частичная → прогноз', () {
    final map = <String, CategoryScore>{
      for (final s in ['a', 'b', 'c', 'd', 'e', 'f', 'g']) s: _cat(s, 70),
    };
    map['h'] = _cat('h', 70, partial: true);
    final idx = athleteIndex(map);
    expect(idx.isForecast, isTrue);
  });

  test('пустой набор → 0 и прогноз', () {
    final idx = athleteIndex({});
    expect(idx.value, 0);
    expect(idx.isForecast, isTrue);
    expect(idx.level, AthleteLevel.novice);
  });
}
