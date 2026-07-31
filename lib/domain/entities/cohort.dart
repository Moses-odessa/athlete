import 'age_bracket.dart';
import 'gender.dart';

/// Когорта пользователя — пара {пол, возрастной брэкет} (ТЗ разд. 4.9).
/// По ней подбираются нормативы теста (минимум и эталон).
class Cohort {
  final Gender gender;
  final AgeBracket ageBracket;

  const Cohort(this.gender, this.ageBracket);

  /// Когорта пользователя по полу и дате рождения.
  /// [asOf] — момент расчёта возраста (по умолчанию — сейчас; передаётся в тестах).
  factory Cohort.forUser({
    required Gender gender,
    required DateTime dateOfBirth,
    required DateTime asOf,
  }) {
    var age = asOf.year - dateOfBirth.year;
    final hadBirthdayThisYear = asOf.month > dateOfBirth.month ||
        (asOf.month == dateOfBirth.month && asOf.day >= dateOfBirth.day);
    if (!hadBirthdayThisYear) age -= 1;
    return Cohort(gender, AgeBracket.fromAge(age));
  }

  /// Подпись для UI: «Стандарт для мужчин 25–29 лет» (ТЗ разд. 4.9).
  String get label {
    final g = switch (gender) {
      Gender.male => 'мужчин',
      Gender.female => 'женщин',
      Gender.unspecified => 'атлетов',
    };
    return '$g ${ageBracket.label}';
  }

  @override
  bool operator ==(Object other) =>
      other is Cohort &&
      other.gender == gender &&
      other.ageBracket == ageBracket;

  @override
  int get hashCode => Object.hash(gender, ageBracket);

  @override
  String toString() => 'Cohort($gender, ${ageBracket.label})';
}
