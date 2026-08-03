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
    name: LocalizedText(
      ru: 'Силовая баттерея',
      en: 'Strength battery',
      uk: 'Силова батарея',
      de: 'Kraft-Testbatterie',
      it: 'Batteria di forza',
      fr: 'Batterie de force',
    ),
    description: LocalizedText(
      ru: 'Жим, присед, становая, подтягивания.',
      en: 'Bench, squat, deadlift, pull-ups.',
      uk: 'Жим, присід, станова, підтягування.',
      de: 'Bankdrücken, Kniebeuge, Kreuzheben, Klimmzüge.',
      it: 'Panca, squat, stacco, trazioni.',
      fr: 'Développé couché, squat, soulevé de terre, tractions.',
    ),
    exerciseIds: ['bench_press', 'back_squat', 'deadlift', 'pull_ups'],
  ),
  TestBattery(
    id: 'speed',
    name: LocalizedText(
      ru: 'Скоростная баттерея',
      en: 'Speed battery',
      uk: 'Швидкісна батарея',
      de: 'Schnelligkeits-Testbatterie',
      it: 'Batteria di velocità',
      fr: 'Batterie de vitesse',
    ),
    description: LocalizedText(
      ru: 'Спринты 30 и 60 м, тест реакции.',
      en: '30 m and 60 m sprints, reaction test.',
      uk: 'Спринти 30 і 60 м, тест реакції.',
      de: 'Sprints über 30 und 60 m, Reaktionstest.',
      it: 'Sprint di 30 e 60 m, test di reazione.',
      fr: 'Sprints de 30 et 60 m, test de réaction.',
    ),
    exerciseIds: ['sprint_30m', 'sprint_60m', 'reaction_test'],
  ),
  TestBattery(
    id: 'explosive',
    name: LocalizedText(
      ru: 'Взрывная баттерея',
      en: 'Explosive battery',
      uk: 'Вибухова батарея',
      de: 'Schnellkraft-Testbatterie',
      it: 'Batteria di forza esplosiva',
      fr: 'Batterie de puissance explosive',
    ),
    description: LocalizedText(
      ru: 'Вертикальный прыжок, прыжок в длину, бросок медбола.',
      en: 'Vertical jump, long jump, medicine ball throw.',
      uk: 'Вертикальний стрибок, стрибок у довжину, кидок медболу.',
      de: 'Vertikalsprung, Weitsprung, Medizinballwurf.',
      it: 'Salto verticale, salto in lungo, lancio della palla medica.',
      fr: 'Saut vertical, saut en longueur, lancer de médecine-ball.',
    ),
    exerciseIds: [
      'vertical_jump',
      'standing_long_jump',
      'medicine_ball_throw'
    ],
  ),
  TestBattery(
    id: 'endurance',
    name: LocalizedText(
      ru: 'Баттерея выносливости',
      en: 'Endurance battery',
      uk: 'Батарея витривалості',
      de: 'Ausdauer-Testbatterie',
      it: 'Batteria di resistenza',
      fr: 'Batterie d\'endurance',
    ),
    description: LocalizedText(
      ru: 'Бег 3 км и тест Купера.',
      en: '3 km run and Cooper test.',
      uk: 'Біг 3 км і тест Купера.',
      de: '3-km-Lauf und Cooper-Test.',
      it: 'Corsa di 3 km e test di Cooper.',
      fr: 'Course de 3 km et test de Cooper.',
    ),
    exerciseIds: ['run_3km', 'cooper_test'],
  ),
  TestBattery(
    id: 'mobility',
    name: LocalizedText(
      ru: 'Баттерея гибкости и мобильности',
      en: 'Flexibility & mobility battery',
      uk: 'Батарея гнучкості та мобільності',
      de: 'Beweglichkeits- und Mobilitäts-Testbatterie',
      it: 'Batteria di flessibilità e mobilità',
      fr: 'Batterie de souplesse et mobilité',
    ),
    description: LocalizedText(
      ru: 'Наклон вперёд, глубокий присед, дорсифлексия голеностопа.',
      en: 'Sit-and-reach, deep squat, ankle dorsiflexion.',
      uk: 'Нахил уперед, глибокий присід, дорсифлексія гомілковостопу.',
      de: 'Rumpfbeuge, tiefe Kniebeuge, Sprunggelenk-Dorsalflexion.',
      it: 'Flessione in avanti, squat profondo, dorsiflessione della caviglia.',
      fr: 'Flexion avant, squat profond, dorsiflexion de la cheville.',
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
