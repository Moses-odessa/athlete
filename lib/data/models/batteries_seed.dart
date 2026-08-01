import '../../domain/entities/localized_text.dart';

/// Готовый набор тестов на одну сессию (ТЗ разд. 4.13).
class TestBattery {
  final String id;
  final LocalizedText name;
  final LocalizedText description;
  final List<String> exerciseIds;

  const TestBattery({
    required this.id,
    required this.name,
    required this.description,
    required this.exerciseIds,
  });
}

const List<TestBattery> kBatteries = [
  TestBattery(
    id: 'strength',
    name: LocalizedText(ru: 'Силовая баттерея', en: 'Strength battery'),
    description: LocalizedText(
      ru: 'Жим, присед, становая, подтягивания.',
      en: 'Bench, squat, deadlift, pull-ups.',
    ),
    exerciseIds: ['bench_press', 'back_squat', 'deadlift', 'pull_ups'],
  ),
  TestBattery(
    id: 'speed',
    name: LocalizedText(ru: 'Скоростная баттерея', en: 'Speed battery'),
    description: LocalizedText(
      ru: 'Спринты 30 и 60 м, тест реакции.',
      en: '30 m and 60 m sprints, reaction test.',
    ),
    exerciseIds: ['sprint_30m', 'sprint_60m', 'reaction_test'],
  ),
  TestBattery(
    id: 'explosive',
    name:
        LocalizedText(ru: 'Взрывная баттерея', en: 'Explosive battery'),
    description: LocalizedText(
      ru: 'Вертикальный прыжок, прыжок в длину, бросок медбола.',
      en: 'Vertical jump, long jump, medicine ball throw.',
    ),
    exerciseIds: [
      'vertical_jump',
      'standing_long_jump',
      'medicine_ball_throw'
    ],
  ),
  TestBattery(
    id: 'endurance',
    name:
        LocalizedText(ru: 'Баттерея выносливости', en: 'Endurance battery'),
    description: LocalizedText(
      ru: 'Бег 3 км и тест Купера.',
      en: '3 km run and Cooper test.',
    ),
    exerciseIds: ['run_3km', 'cooper_test'],
  ),
  TestBattery(
    id: 'mobility',
    name: LocalizedText(
        ru: 'Баттерея гибкости и мобильности',
        en: 'Flexibility & mobility battery'),
    description: LocalizedText(
      ru: 'Наклон вперёд, глубокий присед, дорсифлексия голеностопа.',
      en: 'Sit-and-reach, deep squat, ankle dorsiflexion.',
    ),
    exerciseIds: ['sit_and_reach', 'deep_squat', 'ankle_dorsiflexion'],
  ),
];

TestBattery? batteryById(String id) {
  for (final b in kBatteries) {
    if (b.id == id) return b;
  }
  return null;
}
