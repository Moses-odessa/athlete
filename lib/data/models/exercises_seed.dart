import '../../domain/entities/exercise.dart';
import '../../domain/entities/localized_text.dart';
import '../../domain/entities/measurement.dart';
import '../../domain/entities/standards.dart';
import 'categories_seed.dart';

/// 12 тестов MVP (ТЗ разд. 5, 12). Нормативы — для эталонной когорты
/// (мужчины 25–29); женские/возрастные коэффициенты применяются в scoring.
///
/// TODO(calibration): все числовые нормативы и femaleFactor предварительные,
/// требуют валидации со спортивным экспертом (ТЗ разд. 6, 16 п.1).
const List<Exercise> kMvpExercises = [
  // ── Сила ──────────────────────────────────────────────────────────────
  Exercise(
    id: 'bench_press',
    categorySlug: CategorySlugs.strength,
    name: LocalizedText(ru: 'Жим лёжа', en: 'Bench press'),
    shortDescription: LocalizedText(
      ru: 'Максимальный вес в жиме лёжа относительно массы тела.',
      en: 'One-rep max bench press relative to bodyweight.',
    ),
    unit: MeasurementUnit.bodyweightMultiple,
    higherIsBetter: true,
    usesBodyweight: true,
    standards: CohortStandards(baseMin: 0.3, baseMax: 2.0, femaleFactor: 0.65),
  ),
  Exercise(
    id: 'back_squat',
    categorySlug: CategorySlugs.strength,
    name: LocalizedText(ru: 'Присед со штангой', en: 'Back squat'),
    shortDescription: LocalizedText(
      ru: 'Максимальный вес в приседе относительно массы тела.',
      en: 'One-rep max back squat relative to bodyweight.',
    ),
    unit: MeasurementUnit.bodyweightMultiple,
    higherIsBetter: true,
    usesBodyweight: true,
    standards: CohortStandards(baseMin: 0.5, baseMax: 2.7, femaleFactor: 0.70),
  ),
  Exercise(
    id: 'deadlift',
    categorySlug: CategorySlugs.strength,
    name: LocalizedText(ru: 'Становая тяга', en: 'Deadlift'),
    shortDescription: LocalizedText(
      ru: 'Максимальный вес в становой тяге относительно массы тела.',
      en: 'One-rep max deadlift relative to bodyweight.',
    ),
    unit: MeasurementUnit.bodyweightMultiple,
    higherIsBetter: true,
    usesBodyweight: true,
    standards: CohortStandards(baseMin: 0.6, baseMax: 3.2, femaleFactor: 0.70),
  ),
  Exercise(
    id: 'pull_ups',
    categorySlug: CategorySlugs.strength,
    name: LocalizedText(ru: 'Подтягивания (строгие)', en: 'Pull-ups (strict)'),
    shortDescription: LocalizedText(
      ru: 'Максимум строгих подтягиваний без раскачки.',
      en: 'Max strict pull-ups without kipping.',
    ),
    unit: MeasurementUnit.reps,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 0, baseMax: 50, femaleFactor: 0.55),
  ),

  // ── Выносливость ──────────────────────────────────────────────────────
  Exercise(
    id: 'run_3km',
    categorySlug: CategorySlugs.endurance,
    name: LocalizedText(ru: 'Бег 3 км', en: '3 km run'),
    shortDescription: LocalizedText(
      ru: 'Время преодоления 3 км. Меньше — лучше.',
      en: 'Time to run 3 km. Lower is better.',
    ),
    unit: MeasurementUnit.seconds,
    higherIsBetter: false,
    usesBodyweight: false,
    // 20:00 → 10:00
    standards: CohortStandards(baseMin: 1200, baseMax: 600, femaleFactor: 0.88),
  ),
  Exercise(
    id: 'run_5km',
    categorySlug: CategorySlugs.endurance,
    name: LocalizedText(ru: 'Бег 5 км', en: '5 km run'),
    shortDescription: LocalizedText(
      ru: 'Время преодоления 5 км. Меньше — лучше.',
      en: 'Time to run 5 km. Lower is better.',
    ),
    unit: MeasurementUnit.seconds,
    higherIsBetter: false,
    usesBodyweight: false,
    // 35:00 → 17:30
    standards: CohortStandards(baseMin: 2100, baseMax: 1050, femaleFactor: 0.88),
  ),
  Exercise(
    id: 'cooper_test',
    categorySlug: CategorySlugs.endurance,
    name: LocalizedText(ru: 'Тест Купера (12 мин)', en: 'Cooper test (12 min)'),
    shortDescription: LocalizedText(
      ru: 'Дистанция за 12 минут бега. Больше — лучше.',
      en: 'Distance covered in a 12-minute run. Higher is better.',
    ),
    unit: MeasurementUnit.meters,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 1600, baseMax: 3600, femaleFactor: 0.85),
  ),

  // ── Взрывная сила ─────────────────────────────────────────────────────
  Exercise(
    id: 'vertical_jump',
    categorySlug: CategorySlugs.explosive,
    name: LocalizedText(ru: 'Вертикальный прыжок', en: 'Vertical jump'),
    shortDescription: LocalizedText(
      ru: 'Высота вертикального выпрыгивания с места.',
      en: 'Standing vertical jump height.',
    ),
    unit: MeasurementUnit.centimeters,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 20, baseMax: 80, femaleFactor: 0.75),
  ),
  Exercise(
    id: 'standing_long_jump',
    categorySlug: CategorySlugs.explosive,
    name: LocalizedText(ru: 'Прыжок в длину с места', en: 'Standing long jump'),
    shortDescription: LocalizedText(
      ru: 'Дальность прыжка в длину с места.',
      en: 'Standing broad jump distance.',
    ),
    unit: MeasurementUnit.centimeters,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 140, baseMax: 280, femaleFactor: 0.80),
  ),
  Exercise(
    id: 'medicine_ball_throw',
    categorySlug: CategorySlugs.explosive,
    name: LocalizedText(ru: 'Бросок медбола (5 кг)', en: 'Medicine ball throw (5 kg)'),
    shortDescription: LocalizedText(
      ru: 'Дальность броска медбола из-за головы.',
      en: 'Overhead medicine ball throw distance.',
    ),
    unit: MeasurementUnit.meters,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 3, baseMax: 10, femaleFactor: 0.72),
  ),

  // ── Гибкость ──────────────────────────────────────────────────────────
  Exercise(
    id: 'sit_and_reach',
    categorySlug: CategorySlugs.flexibility,
    name: LocalizedText(ru: 'Наклон вперёд (сидя)', en: 'Sit and reach'),
    shortDescription: LocalizedText(
      ru: 'Наклон вперёд сидя; отсчёт от уровня стоп (см, ±).',
      en: 'Seated forward bend, measured from the feet line (cm, ±).',
    ),
    unit: MeasurementUnit.centimeters,
    higherIsBetter: true,
    usesBodyweight: false,
    // −20 → +20; гибкость по полу — паритет (ТЗ разд. 4.9).
    standards: CohortStandards(baseMin: -20, baseMax: 20, femaleFactor: 1.0),
  ),
  Exercise(
    id: 'deep_squat',
    categorySlug: CategorySlugs.flexibility,
    name: LocalizedText(ru: 'Глубокий присед (без веса)', en: 'Deep squat (bodyweight)'),
    shortDescription: LocalizedText(
      ru: 'Качественная оценка амплитуды приседа 1–5.',
      en: 'Qualitative squat depth/quality rating 1–5.',
    ),
    unit: MeasurementUnit.qualitative1to5,
    higherIsBetter: true,
    usesBodyweight: false,
    // Для качественного теста нормативы не используются (балл по таблице 1–5).
    standards: CohortStandards(
      baseMin: 1,
      baseMax: 5,
      femaleFactor: 1.0,
      ageAdjusted: false,
    ),
  ),
];
