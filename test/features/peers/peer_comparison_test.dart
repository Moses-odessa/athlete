import 'package:athlete_index/features/peers/application/peer_comparison.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('перцентиль по нормальной модели', () {
    expect(percentileForScore(kCohortMean), closeTo(50, 0.5));
    expect(percentileForScore(kCohortMean + kCohortSd), closeTo(84, 1));
    expect(percentileForScore(kCohortMean - kCohortSd), closeTo(16, 1));
  });

  test('перцентиль монотонен и ограничен 0–100', () {
    var prev = -1.0;
    for (var s = 0; s <= 100; s += 5) {
      final p = percentileForScore(s.toDouble());
      expect(p, greaterThanOrEqualTo(prev));
      expect(p, inInclusiveRange(0, 100));
      prev = p;
    }
  });
}
