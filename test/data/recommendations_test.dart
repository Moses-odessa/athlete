import 'package:athlete_index/data/models/catalog_seed.dart';
import 'package:athlete_index/data/models/recommendations_seed.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('для каждой из 8 категорий есть 3–5 рекомендаций (ТЗ 4.11)', () {
    for (final c in Catalog.categories) {
      final recs = recommendationsFor(c.slug);
      expect(recs.length, inInclusiveRange(3, 5), reason: c.slug);
    }
  });
}
