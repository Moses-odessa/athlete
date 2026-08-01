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

  // ── Скорость ──────────────────────────────────────────────────────────
  Exercise(
    id: 'sprint_30m',
    categorySlug: CategorySlugs.speed,
    name: LocalizedText(ru: 'Спринт 30 м', en: '30 m sprint'),
    shortDescription: LocalizedText(
      ru: 'Время на 30 м с высокого старта. Меньше — лучше.',
      en: 'Time over 30 m from a standing start. Lower is better.',
    ),
    unit: MeasurementUnit.seconds,
    higherIsBetter: false,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 7.0, baseMax: 3.9, femaleFactor: 0.90),
  ),
  Exercise(
    id: 'sprint_60m',
    categorySlug: CategorySlugs.speed,
    name: LocalizedText(ru: 'Спринт 60 м', en: '60 m sprint'),
    shortDescription: LocalizedText(
      ru: 'Время на 60 м. Меньше — лучше.',
      en: 'Time over 60 m. Lower is better.',
    ),
    unit: MeasurementUnit.seconds,
    higherIsBetter: false,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 12.0, baseMax: 6.9, femaleFactor: 0.90),
  ),
  Exercise(
    id: 'sprint_100m',
    categorySlug: CategorySlugs.speed,
    name: LocalizedText(ru: 'Спринт 100 м', en: '100 m sprint'),
    shortDescription: LocalizedText(
      ru: 'Время на 100 м. Меньше — лучше.',
      en: 'Time over 100 m. Lower is better.',
    ),
    unit: MeasurementUnit.seconds,
    higherIsBetter: false,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 18.0, baseMax: 10.8, femaleFactor: 0.90),
  ),
  Exercise(
    id: 'shuttle_10x10',
    categorySlug: CategorySlugs.speed,
    name: LocalizedText(ru: 'Челночный бег 10×10 м', en: 'Shuttle run 10×10 m'),
    shortDescription: LocalizedText(
      ru: 'Суммарное время 10 отрезков по 10 м. Меньше — лучше.',
      en: 'Total time for ten 10 m shuttles. Lower is better.',
    ),
    unit: MeasurementUnit.seconds,
    higherIsBetter: false,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 40, baseMax: 23, femaleFactor: 0.90),
  ),

  Exercise(
    id: 'reaction_test',
    categorySlug: CategorySlugs.speed,
    name: LocalizedText(ru: 'Тест реакции', en: 'Reaction test'),
    shortDescription: LocalizedText(
      ru: 'Среднее время визуальной реакции из 5 попыток. Меньше — лучше.',
      en: 'Average visual reaction time over 5 trials. Lower is better.',
    ),
    unit: MeasurementUnit.milliseconds,
    higherIsBetter: false,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 400, baseMax: 180, femaleFactor: 0.98),
  ),

  // ── Координация ───────────────────────────────────────────────────────
  Exercise(
    id: 'illinois_agility',
    categorySlug: CategorySlugs.coordination,
    name: LocalizedText(ru: 'Illinois Agility Test', en: 'Illinois Agility Test'),
    shortDescription: LocalizedText(
      ru: 'Время прохождения стандартной трассы с конусами. Меньше — лучше.',
      en: 'Time on the standard cone course. Lower is better.',
    ),
    unit: MeasurementUnit.seconds,
    higherIsBetter: false,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 25, baseMax: 15, femaleFactor: 0.93),
  ),
  Exercise(
    id: 'catch_ball',
    categorySlug: CategorySlugs.coordination,
    name: LocalizedText(ru: 'Ловля мяча одной рукой', en: 'One-hand ball catch'),
    shortDescription: LocalizedText(
      ru: 'Успешные ловли из 10 попыток. Больше — лучше.',
      en: 'Successful catches out of 10. Higher is better.',
    ),
    unit: MeasurementUnit.reps,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 0, baseMax: 10, femaleFactor: 0.95),
  ),
  Exercise(
    id: 'jump_rope_30s',
    categorySlug: CategorySlugs.coordination,
    name: LocalizedText(ru: 'Скакалка за 30 с', en: 'Jump rope in 30 s'),
    shortDescription: LocalizedText(
      ru: 'Количество прыжков за 30 секунд. Больше — лучше.',
      en: 'Number of skips in 30 seconds. Higher is better.',
    ),
    unit: MeasurementUnit.reps,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 40, baseMax: 100, femaleFactor: 0.95),
  ),
  Exercise(
    id: 'movement_precision',
    categorySlug: CategorySlugs.coordination,
    name: LocalizedText(
        ru: 'Точность движений', en: 'Movement precision'),
    shortDescription: LocalizedText(
      ru: 'Качественная оценка точности координационного паттерна 1–5.',
      en: 'Qualitative rating of coordination pattern accuracy 1–5.',
    ),
    unit: MeasurementUnit.qualitative1to5,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(
        baseMin: 1, baseMax: 5, femaleFactor: 1.0, ageAdjusted: false),
  ),

  // ── Баланс ────────────────────────────────────────────────────────────
  Exercise(
    id: 'single_leg_stand',
    categorySlug: CategorySlugs.balance,
    name: LocalizedText(
        ru: 'Стойка на одной ноге (глаза закрыты)',
        en: 'Single-leg stand (eyes closed)'),
    shortDescription: LocalizedText(
      ru: 'Время удержания равновесия. Больше — лучше.',
      en: 'Time holding balance. Higher is better.',
    ),
    unit: MeasurementUnit.seconds,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 5, baseMax: 60, femaleFactor: 1.0),
  ),
  Exercise(
    id: 'y_balance',
    categorySlug: CategorySlugs.balance,
    name: LocalizedText(ru: 'Y-Balance Test', en: 'Y-Balance Test'),
    shortDescription: LocalizedText(
      ru: 'Качественная оценка нормированного результата 1–5.',
      en: 'Qualitative rating of the normalised reach 1–5.',
    ),
    unit: MeasurementUnit.qualitative1to5,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(
        baseMin: 1, baseMax: 5, femaleFactor: 1.0, ageAdjusted: false),
  ),
  Exercise(
    id: 'star_excursion',
    categorySlug: CategorySlugs.balance,
    name: LocalizedText(
        ru: 'Star Excursion Balance', en: 'Star Excursion Balance'),
    shortDescription: LocalizedText(
      ru: 'Качественная оценка дотягивания по направлениям 1–5.',
      en: 'Qualitative rating of multi-direction reach 1–5.',
    ),
    unit: MeasurementUnit.qualitative1to5,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(
        baseMin: 1, baseMax: 5, femaleFactor: 1.0, ageAdjusted: false),
  ),
  Exercise(
    id: 'beam_walk',
    categorySlug: CategorySlugs.balance,
    name: LocalizedText(ru: 'Проход по бревну (10 м)', en: 'Balance beam walk (10 m)'),
    shortDescription: LocalizedText(
      ru: 'Качественная оценка прохода без ошибок 1–5.',
      en: 'Qualitative rating of an error-free walk 1–5.',
    ),
    unit: MeasurementUnit.qualitative1to5,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(
        baseMin: 1, baseMax: 5, femaleFactor: 1.0, ageAdjusted: false),
  ),

  // ── Мобильность ───────────────────────────────────────────────────────
  Exercise(
    id: 'fms_overhead_squat',
    categorySlug: CategorySlugs.mobility,
    name: LocalizedText(
        ru: 'FMS: присед с руками вверх', en: 'FMS overhead squat'),
    shortDescription: LocalizedText(
      ru: 'Качественная оценка паттерна приседа 1–5.',
      en: 'Qualitative rating of the overhead squat pattern 1–5.',
    ),
    unit: MeasurementUnit.qualitative1to5,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(
        baseMin: 1, baseMax: 5, femaleFactor: 1.0, ageAdjusted: false),
  ),
  Exercise(
    id: 'ankle_dorsiflexion',
    categorySlug: CategorySlugs.mobility,
    name: LocalizedText(
        ru: 'Тыльное сгибание голеностопа', en: 'Ankle dorsiflexion'),
    shortDescription: LocalizedText(
      ru: 'Расстояние колена от стены (тест у стены), см. Больше — лучше.',
      en: 'Knee-to-wall distance, cm. Higher is better.',
    ),
    unit: MeasurementUnit.centimeters,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(baseMin: 2, baseMax: 12, femaleFactor: 1.0),
  ),
  Exercise(
    id: 'shoulder_flexion',
    categorySlug: CategorySlugs.mobility,
    name: LocalizedText(ru: 'Сгибание плеча (у стены)', en: 'Shoulder flexion (wall)'),
    shortDescription: LocalizedText(
      ru: 'Качественная оценка амплитуды у стены 1–5.',
      en: 'Qualitative rating of wall shoulder flexion 1–5.',
    ),
    unit: MeasurementUnit.qualitative1to5,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(
        baseMin: 1, baseMax: 5, femaleFactor: 1.0, ageAdjusted: false),
  ),
  Exercise(
    id: 'hip_internal_rotation',
    categorySlug: CategorySlugs.mobility,
    name: LocalizedText(
        ru: 'Внутренняя ротация бедра', en: 'Hip internal rotation'),
    shortDescription: LocalizedText(
      ru: 'Качественная оценка амплитуды ротации 1–5.',
      en: 'Qualitative rating of hip internal rotation 1–5.',
    ),
    unit: MeasurementUnit.qualitative1to5,
    higherIsBetter: true,
    usesBodyweight: false,
    standards: CohortStandards(
        baseMin: 1, baseMax: 5, femaleFactor: 1.0, ageAdjusted: false),
  ),
];
