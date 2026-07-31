import 'package:athlete_index/domain/entities/age_bracket.dart';
import 'package:athlete_index/domain/entities/cohort.dart';
import 'package:athlete_index/domain/entities/gender.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AgeBracket.fromAge', () {
    test('границы брэкетов', () {
      expect(AgeBracket.fromAge(18), AgeBracket.b18to24);
      expect(AgeBracket.fromAge(24), AgeBracket.b18to24);
      expect(AgeBracket.fromAge(25), AgeBracket.b25to29);
      expect(AgeBracket.fromAge(29), AgeBracket.b25to29);
      expect(AgeBracket.fromAge(34), AgeBracket.b30to34);
      expect(AgeBracket.fromAge(39), AgeBracket.b35to39);
      expect(AgeBracket.fromAge(44), AgeBracket.b40to44);
      expect(AgeBracket.fromAge(49), AgeBracket.b45to49);
      expect(AgeBracket.fromAge(50), AgeBracket.b50plus);
      expect(AgeBracket.fromAge(75), AgeBracket.b50plus);
    });

    test('младше 18 попадает в младший брэкет', () {
      expect(AgeBracket.fromAge(16), AgeBracket.b18to24);
    });
  });

  group('Cohort.forUser', () {
    test('день рождения уже прошёл в этом году', () {
      final c = Cohort.forUser(
        gender: Gender.male,
        dateOfBirth: DateTime(1994, 1, 15),
        asOf: DateTime(2026, 7, 31), // 32 года
      );
      expect(c.ageBracket, AgeBracket.b30to34);
      expect(c.gender, Gender.male);
    });

    test('день рождения ещё не наступил', () {
      final c = Cohort.forUser(
        gender: Gender.female,
        dateOfBirth: DateTime(1994, 12, 31),
        asOf: DateTime(2026, 7, 31), // ещё 31 → брэкет 30–34
      );
      expect(c.ageBracket, AgeBracket.b30to34);
    });

    test('ровно день рождения — возраст засчитан', () {
      final c = Cohort.forUser(
        gender: Gender.male,
        dateOfBirth: DateTime(2001, 7, 31),
        asOf: DateTime(2026, 7, 31), // ровно 25
      );
      expect(c.ageBracket, AgeBracket.b25to29);
    });
  });

  test('равенство и hashCode когорты', () {
    const a = Cohort(Gender.male, AgeBracket.b25to29);
    const b = Cohort(Gender.male, AgeBracket.b25to29);
    const c = Cohort(Gender.female, AgeBracket.b25to29);
    expect(a, b);
    expect(a.hashCode, b.hashCode);
    expect(a == c, isFalse);
    expect(c.label, contains('женщин'));
  });
}
