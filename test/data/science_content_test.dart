import 'package:athlete_index/data/models/science_content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('научная база: источники, формулы и валидные URL (ТЗ 4.16)', () {
    expect(kScienceReferences, isNotEmpty);
    expect(kScienceFormulas.length, 3);
    for (final ref in kScienceReferences) {
      final uri = Uri.parse(ref.url);
      expect(uri.isAbsolute, isTrue, reason: ref.url);
      expect(uri.scheme, 'https', reason: ref.url);
    }
  });
}
