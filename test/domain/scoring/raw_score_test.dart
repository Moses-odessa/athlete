import 'dart:math';

import 'package:athlete_index/domain/entities/scale_type.dart';
import 'package:athlete_index/domain/scoring/raw_score.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('linearScore (больше — лучше)', () {
    test('границы и середина', () {
      expect(linearScore(0, 0, 100, higherIsBetter: true), 0);
      expect(linearScore(100, 0, 100, higherIsBetter: true), 100);
      expect(linearScore(50, 0, 100, higherIsBetter: true), 50);
    });

    test('clamp за пределами диапазона', () {
      expect(linearScore(-10, 0, 100, higherIsBetter: true), 0);
      expect(linearScore(150, 0, 100, higherIsBetter: true), 100);
    });

    test('произвольный диапазон', () {
      // 80 кг при нормативе 24..160 → ~41.18
      expect(
        linearScore(80, 24, 160, higherIsBetter: true),
        closeTo(41.18, 0.01),
      );
    });

    test('вырожденный норматив ref == min', () {
      expect(linearScore(100, 100, 100, higherIsBetter: true), 100);
      expect(linearScore(50, 100, 100, higherIsBetter: true), 0);
    });
  });

  group('linearScore (меньше — лучше)', () {
    test('границы и середина (время бега)', () {
      expect(linearScore(1200, 1200, 600, higherIsBetter: false), 0);
      expect(linearScore(600, 1200, 600, higherIsBetter: false), 100);
      expect(linearScore(900, 1200, 600, higherIsBetter: false), 50);
    });

    test('clamp: быстрее эталона → 100, медленнее минимума → 0', () {
      expect(linearScore(500, 1200, 600, higherIsBetter: false), 100);
      expect(linearScore(1300, 1200, 600, higherIsBetter: false), 0);
    });

    test('вырожденный норматив ref == min', () {
      expect(linearScore(600, 600, 600, higherIsBetter: false), 100);
      expect(linearScore(700, 600, 600, higherIsBetter: false), 0);
    });
  });

  group('nonlinearScore', () {
    test('границы сохраняются', () {
      expect(nonlinearScore(0), closeTo(0, 1e-9));
      expect(nonlinearScore(100), closeTo(100, 1e-9));
    });

    test('быстрый рост в начале: балл выше линейного', () {
      expect(nonlinearScore(50), greaterThan(50));
      // Явное значение при k = 2.5
      final expected =
          100 * (1 - exp(-2.5 * 0.5)) / (1 - exp(-2.5));
      expect(nonlinearScore(50), closeTo(expected, 1e-9));
    });

    test('монотонность', () {
      double prev = -1;
      for (var x = 0; x <= 100; x += 5) {
        final v = nonlinearScore(x.toDouble());
        expect(v, greaterThanOrEqualTo(prev));
        prev = v;
      }
    });

    test('clamp входа', () {
      expect(nonlinearScore(-10), closeTo(0, 1e-9));
      expect(nonlinearScore(150), closeTo(100, 1e-9));
    });
  });

  group('applyScale', () {
    test('линейная возвращает вход', () {
      expect(applyScale(42, ScaleType.linear), 42);
    });
    test('нелинейная совпадает с nonlinearScore', () {
      expect(applyScale(42, ScaleType.nonlinear), nonlinearScore(42));
    });
  });

  group('qualitativeToScore', () {
    test('маппинг 1..5', () {
      expect(qualitativeToScore(1), 0);
      expect(qualitativeToScore(2), 25);
      expect(qualitativeToScore(3), 50);
      expect(qualitativeToScore(4), 75);
      expect(qualitativeToScore(5), 100);
    });
    test('clamp за пределами', () {
      expect(qualitativeToScore(0), 0);
      expect(qualitativeToScore(6), 100);
    });
  });
}
