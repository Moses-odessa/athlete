import 'package:athlete_index/domain/entities/athlete_level.dart';
import 'package:athlete_index/domain/scoring/level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('levelForScore — пороги ТЗ 2.3', () {
    test('Novice 0–19', () {
      expect(levelForScore(0), AthleteLevel.novice);
      expect(levelForScore(19.999), AthleteLevel.novice);
    });
    test('Beginner 20–39', () {
      expect(levelForScore(20), AthleteLevel.beginner);
      expect(levelForScore(39.999), AthleteLevel.beginner);
    });
    test('Intermediate 40–59', () {
      expect(levelForScore(40), AthleteLevel.intermediate);
      expect(levelForScore(59.999), AthleteLevel.intermediate);
    });
    test('Advanced 60–79', () {
      expect(levelForScore(60), AthleteLevel.advanced);
      expect(levelForScore(79.999), AthleteLevel.advanced);
    });
    test('Elite 80–94', () {
      expect(levelForScore(80), AthleteLevel.elite);
      expect(levelForScore(94.999), AthleteLevel.elite);
    });
    test('Athlete 95–100', () {
      expect(levelForScore(95), AthleteLevel.athlete);
      expect(levelForScore(100), AthleteLevel.athlete);
    });
    test('clamp за пределами', () {
      expect(levelForScore(-5), AthleteLevel.novice);
      expect(levelForScore(120), AthleteLevel.athlete);
    });
  });

  test('minScore и label уровней согласованы', () {
    expect(AthleteLevel.novice.minScore, 0);
    expect(AthleteLevel.athlete.minScore, 95);
    expect(AthleteLevel.elite.label, 'Elite');
  });
}
