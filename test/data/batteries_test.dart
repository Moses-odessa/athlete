import 'package:athlete_index/data/models/batteries_seed.dart';
import 'package:athlete_index/data/models/catalog_seed.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('баттереи: 3–5 существующих тестов в каждой (ТЗ 4.13)', () {
    expect(kBatteries, isNotEmpty);
    for (final b in kBatteries) {
      expect(b.exerciseIds.length, inInclusiveRange(2, 5), reason: b.id);
      for (final id in b.exerciseIds) {
        expect(Catalog.exerciseById(id), isNotNull, reason: '${b.id} → $id');
      }
    }
  });

  test('batteryById находит и возвращает null для неизвестного', () {
    expect(batteryById('strength'), isNotNull);
    expect(batteryById('nope'), isNull);
  });
}
