import 'package:athlete_index/data/models/catalog_seed.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('у всех 12 тестов MVP есть инфо-контент (ТЗ 4.4)', () {
    for (final ex in Catalog.exercises) {
      final info = Catalog.infoFor(ex.id);
      expect(info, isNotNull, reason: 'нет инфо для ${ex.id}');
      expect(info!.howToPerform, isNotEmpty, reason: ex.id);
      expect(info.commonMistakes, isNotEmpty, reason: ex.id);
    }
  });
}
