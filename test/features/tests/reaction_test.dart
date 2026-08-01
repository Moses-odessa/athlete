import 'package:athlete_index/data/models/catalog_seed.dart';
import 'package:athlete_index/domain/entities/age_bracket.dart';
import 'package:athlete_index/domain/entities/cohort.dart';
import 'package:athlete_index/domain/entities/gender.dart';
import 'package:athlete_index/domain/scoring/score_test.dart';
import 'package:athlete_index/features/tests/application/reaction_math.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('среднее время реакции', () {
    expect(averageMs([200, 300, 250, 220, 280]), 250);
    expect(averageMs(const []), 0);
  });

  test('тест реакции есть в каталоге и считается (меньше — лучше)', () {
    final reaction = Catalog.exerciseById('reaction_test');
    expect(reaction, isNotNull);
    const cohort = Cohort(Gender.male, AgeBracket.b25to29);
    // 250 мс при нормативе 400→180: (400-250)/(400-180)*100 ≈ 68.2
    final s = scoreTest(reaction!, 250, cohort);
    expect(s.normalizedScore, closeTo(68.2, 0.2));
  });
}
