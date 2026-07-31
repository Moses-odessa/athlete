import '../../domain/entities/exercise_info.dart';
import '../../domain/entities/localized_text.dart';

LocalizedText _t(String ru, String en) => LocalizedText(ru: ru, en: en);

/// Контент инфо-модалок для 12 тестов MVP (ТЗ разд. 4.4).
/// TODO(content): выверить формулировки с методистом на этапе калибровки.
final Map<String, ExerciseInfo> kExerciseInfo = {
  // ── Сила ────────────────────────────────────────────────────────────────
  'bench_press': ExerciseInfo(
    whatMeasures: _t(
      'Максимальную силу мышц груди, плеч и трицепсов относительно массы тела.',
      'Maximal pressing strength of chest, shoulders and triceps relative to bodyweight.',
    ),
    whyNeeded: _t(
      'Жим — базовый показатель силы верха тела; важен для толчковых движений.',
      'The bench press is a core upper-body strength benchmark for pushing patterns.',
    ),
    howToPerform: [
      _t('Разомнитесь и выполните подводящие подходы.',
          'Warm up and do ramp-up sets.'),
      _t('Лягте на скамью, лопатки сведены, стопы на полу.',
          'Lie on the bench, shoulder blades retracted, feet on the floor.'),
      _t('Опустите штангу до груди и выжмите на прямые руки — 1 повтор с максимальным весом.',
          'Lower the bar to the chest and press to lockout — one rep at maximal load.'),
    ],
    howToEnter: _t(
      'Введите максимальный вес (1ПМ) в килограммах. Балл считается как доля от массы тела.',
      'Enter your one-rep max in kilograms. Score is computed as a bodyweight ratio.',
    ),
    commonMistakes: [
      _t('Отрыв таза от скамьи.', 'Lifting the hips off the bench.'),
      _t('Отбив штанги от груди.', 'Bouncing the bar off the chest.'),
      _t('Неполная амплитуда.', 'Partial range of motion.'),
    ],
    safety: _t(
      'Только со страхующим или в раме безопасности. Не тестируйте 1ПМ без опыта.',
      'Use a spotter or safety rack. Do not test a 1RM without experience.',
    ),
    radarImpact: _t('Балл идёт в категорию «Сила».', 'Contributes to Strength.'),
  ),
  'back_squat': ExerciseInfo(
    whatMeasures: _t(
      'Максимальную силу ног и спины в приседе относительно массы тела.',
      'Maximal leg and back strength in the squat relative to bodyweight.',
    ),
    whyNeeded: _t(
      'Присед — ключевой показатель силы нижней части тела и общей мощи.',
      'The squat is a key lower-body strength and overall power benchmark.',
    ),
    howToPerform: [
      _t('Разомнитесь, выставьте гриф на уровне верха лопаток.',
          'Warm up; set the bar on the upper back.'),
      _t('Опуститесь до параллели бёдер с полом или ниже.',
          'Descend until the hips reach at least parallel.'),
      _t('Встаньте в исходное положение — 1 повтор с максимальным весом.',
          'Stand back up — one rep at maximal load.'),
    ],
    howToEnter: _t(
      'Введите 1ПМ в килограммах. Балл — доля от массы тела.',
      'Enter your one-rep max in kilograms. Score is a bodyweight ratio.',
    ),
    commonMistakes: [
      _t('Недосед (выше параллели).', 'Squatting above parallel.'),
      _t('Округление спины.', 'Rounding the back.'),
      _t('Сведение коленей внутрь.', 'Knees caving inward.'),
    ],
    safety: _t(
      'Используйте стойки со страховочными упорами. Держите нейтральную спину.',
      'Use a rack with safety pins. Keep a neutral spine.',
    ),
    radarImpact: _t('Балл идёт в категорию «Сила».', 'Contributes to Strength.'),
  ),
  'deadlift': ExerciseInfo(
    whatMeasures: _t(
      'Максимальную силу тяги всей задней цепи относительно массы тела.',
      'Maximal posterior-chain pulling strength relative to bodyweight.',
    ),
    whyNeeded: _t(
      'Становая — интегральный показатель силы всего тела.',
      'The deadlift is an integral full-body strength indicator.',
    ),
    howToPerform: [
      _t('Подойдите к грифу, голени у штанги.',
          'Set up with shins near the bar.'),
      _t('Возьмитесь за гриф, спина нейтральна, оторвите штангу.',
          'Grip the bar, neutral back, break the bar off the floor.'),
      _t('Выпрямитесь до полного разгибания — 1 повтор с максимальным весом.',
          'Stand to full lockout — one rep at maximal load.'),
    ],
    howToEnter: _t(
      'Введите 1ПМ в килограммах. Балл — доля от массы тела.',
      'Enter your one-rep max in kilograms. Score is a bodyweight ratio.',
    ),
    commonMistakes: [
      _t('Округление поясницы.', 'Rounding the lower back.'),
      _t('Рывок вместо плавного отрыва.', 'Jerking the bar instead of a smooth pull.'),
      _t('Неполное разгибание в верхней точке.', 'Incomplete lockout at the top.'),
    ],
    safety: _t(
      'Приоритет — техника. При болях в спине не тестируйте максимум.',
      'Prioritise technique. Do not test a max with back pain.',
    ),
    radarImpact: _t('Балл идёт в категорию «Сила».', 'Contributes to Strength.'),
  ),
  'pull_ups': ExerciseInfo(
    whatMeasures: _t(
      'Силовую выносливость мышц спины и рук в подтягиваниях.',
      'Strength-endurance of the back and arms in pull-ups.',
    ),
    whyNeeded: _t(
      'Подтягивания отражают силу верха тела относительно собственного веса.',
      'Pull-ups reflect relative upper-body strength.',
    ),
    howToPerform: [
      _t('Повисните на турнике хватом сверху.',
          'Hang from the bar with an overhand grip.'),
      _t('Подтянитесь, пока подбородок не окажется выше перекладины.',
          'Pull until the chin clears the bar.'),
      _t('Опуститесь до полного выпрямления рук. Считайте строгие повторы.',
          'Lower to full arm extension. Count strict reps.'),
    ],
    howToEnter: _t(
      'Введите количество строгих повторов без раскачки.',
      'Enter the number of strict reps without kipping.',
    ),
    commonMistakes: [
      _t('Раскачка и киппинг.', 'Swinging and kipping.'),
      _t('Неполная амплитуда.', 'Partial range of motion.'),
      _t('Подбородок не выше перекладины.', 'Chin not clearing the bar.'),
    ],
    safety: _t(
      'Разомните плечи. При проблемах с плечами — осторожно.',
      'Warm up the shoulders. Be cautious with shoulder issues.',
    ),
    radarImpact: _t('Балл идёт в категорию «Сила».', 'Contributes to Strength.'),
  ),

  // ── Выносливость ──────────────────────────────────────────────────────────
  'run_3km': ExerciseInfo(
    whatMeasures: _t(
      'Аэробную выносливость на средней дистанции.',
      'Aerobic endurance over a middle distance.',
    ),
    whyNeeded: _t(
      'Бег 3 км — доступный тест аэробной работоспособности.',
      'The 3 km run is an accessible test of aerobic capacity.',
    ),
    howToPerform: [
      _t('Разомнитесь 10 минут лёгким бегом.',
          'Warm up with 10 minutes of easy jogging.'),
      _t('Пробегите 3 км по ровной трассе на максимум.',
          'Run 3 km on a flat course at maximal effort.'),
      _t('Зафиксируйте итоговое время.', 'Record the finishing time.'),
    ],
    howToEnter: _t(
      'Введите время в минутах и секундах. Меньше — лучше.',
      'Enter time in minutes and seconds. Lower is better.',
    ),
    commonMistakes: [
      _t('Слишком быстрый старт.', 'Starting too fast.'),
      _t('Отсутствие разминки.', 'Skipping the warm-up.'),
      _t('Замер по неточной дистанции.', 'Measuring an inaccurate distance.'),
    ],
    safety: _t(
      'Не тестируйте максимум при недомогании. Следите за пульсом.',
      'Do not test a max when unwell. Monitor your heart rate.',
    ),
    radarImpact: _t('Балл идёт в «Выносливость».', 'Contributes to Endurance.'),
  ),
  'run_5km': ExerciseInfo(
    whatMeasures: _t(
      'Аэробную выносливость на длинной дистанции.',
      'Aerobic endurance over a longer distance.',
    ),
    whyNeeded: _t(
      'Бег 5 км — популярный ориентир общей выносливости.',
      'The 5 km run is a popular endurance benchmark.',
    ),
    howToPerform: [
      _t('Разомнитесь 10 минут.', 'Warm up for 10 minutes.'),
      _t('Пробегите 5 км по ровной трассе на максимум.',
          'Run 5 km on a flat course at maximal effort.'),
      _t('Зафиксируйте итоговое время.', 'Record the finishing time.'),
    ],
    howToEnter: _t(
      'Введите время в минутах и секундах. Меньше — лучше.',
      'Enter time in minutes and seconds. Lower is better.',
    ),
    commonMistakes: [
      _t('Неравномерный темп.', 'Uneven pacing.'),
      _t('Старт без разминки.', 'Starting without a warm-up.'),
      _t('Неточная дистанция.', 'Inaccurate distance.'),
    ],
    safety: _t(
      'Пейте воду, не тестируйте максимум в жару без адаптации.',
      'Stay hydrated; avoid maximal tests in heat without acclimatisation.',
    ),
    radarImpact: _t('Балл идёт в «Выносливость».', 'Contributes to Endurance.'),
  ),
  'cooper_test': ExerciseInfo(
    whatMeasures: _t(
      'Максимальную дистанцию за 12 минут бега — оценку МПК.',
      'Maximal distance in a 12-minute run — a VO2max proxy.',
    ),
    whyNeeded: _t(
      'Тест Купера — классический полевой тест аэробной мощности.',
      'The Cooper test is a classic field test of aerobic power.',
    ),
    howToPerform: [
      _t('Разомнитесь.', 'Warm up.'),
      _t('Бегите 12 минут, покрывая максимально возможную дистанцию.',
          'Run for 12 minutes covering as much distance as possible.'),
      _t('Измерьте пройденную дистанцию в метрах.',
          'Measure the distance covered in metres.'),
    ],
    howToEnter: _t(
      'Введите дистанцию в метрах. Больше — лучше.',
      'Enter the distance in metres. Higher is better.',
    ),
    commonMistakes: [
      _t('Неверный замер дистанции.', 'Mis-measuring the distance.'),
      _t('Слишком быстрый старт.', 'Starting too fast.'),
      _t('Бег по неровной поверхности.', 'Running on uneven ground.'),
    ],
    safety: _t(
      'Требует высокой нагрузки — только при хорошем самочувствии.',
      'A high-intensity test — only when feeling well.',
    ),
    radarImpact: _t('Балл идёт в «Выносливость».', 'Contributes to Endurance.'),
  ),

  // ── Взрывная сила ─────────────────────────────────────────────────────────
  'vertical_jump': ExerciseInfo(
    whatMeasures: _t(
      'Взрывную силу ног по высоте вертикального выпрыгивания.',
      'Explosive leg power via vertical jump height.',
    ),
    whyNeeded: _t(
      'Вертикальный прыжок — стандартная оценка мощности ног.',
      'The vertical jump is a standard measure of leg power.',
    ),
    howToPerform: [
      _t('Встаньте у стены, отметьте высоту вытянутой руки.',
          'Stand by a wall and mark your standing reach.'),
      _t('Выпрыгните максимально вверх, коснитесь стены.',
          'Jump as high as possible and touch the wall.'),
      _t('Разница отметок — высота прыжка в см.',
          'The difference between marks is the jump height in cm.'),
    ],
    howToEnter: _t(
      'Введите высоту прыжка в сантиметрах. Больше — лучше.',
      'Enter the jump height in centimetres. Higher is better.',
    ),
    commonMistakes: [
      _t('Разбег вместо прыжка с места.', 'Using a run-up instead of a standing jump.'),
      _t('Неверная отметка вытянутой руки.', 'Incorrect standing-reach mark.'),
      _t('Мах руками не засчитан в технику.', 'Inconsistent arm swing.'),
    ],
    safety: _t(
      'Приземляйтесь мягко на носки с согнутыми коленями.',
      'Land softly on the balls of the feet with bent knees.',
    ),
    radarImpact: _t('Балл идёт во «Взрывную силу».',
        'Contributes to Explosive power.'),
  ),
  'standing_long_jump': ExerciseInfo(
    whatMeasures: _t(
      'Горизонтальную взрывную силу ног.',
      'Horizontal explosive leg power.',
    ),
    whyNeeded: _t(
      'Прыжок в длину с места — простая оценка мощности без оборудования.',
      'The standing long jump is a simple, equipment-free power test.',
    ),
    howToPerform: [
      _t('Встаньте носками у линии старта.', 'Stand with toes at the start line.'),
      _t('Прыгните вперёд как можно дальше с махом рук.',
          'Jump forward as far as possible with an arm swing.'),
      _t('Измерьте расстояние до ближней пятки.',
          'Measure to the nearest heel.'),
    ],
    howToEnter: _t(
      'Введите дальность в сантиметрах. Больше — лучше.',
      'Enter the distance in centimetres. Higher is better.',
    ),
    commonMistakes: [
      _t('Заступ за линию.', 'Stepping over the line.'),
      _t('Падение назад после приземления.', 'Falling backward on landing.'),
      _t('Замер до дальней ноги.', 'Measuring to the far foot.'),
    ],
    safety: _t(
      'Прыгайте на нескользкой поверхности.',
      'Jump on a non-slip surface.',
    ),
    radarImpact: _t('Балл идёт во «Взрывную силу».',
        'Contributes to Explosive power.'),
  ),
  'medicine_ball_throw': ExerciseInfo(
    whatMeasures: _t(
      'Взрывную силу верхней части тела и кора.',
      'Explosive power of the upper body and core.',
    ),
    whyNeeded: _t(
      'Бросок медбола оценивает мощность толчка верха тела.',
      'The medicine ball throw measures upper-body throwing power.',
    ),
    howToPerform: [
      _t('Встаньте, держа медбол (5 кг) за головой.',
          'Stand holding a 5 kg medicine ball overhead.'),
      _t('Бросьте мяч вперёд из-за головы максимально далеко.',
          'Throw the ball forward overhead as far as possible.'),
      _t('Измерьте дистанцию броска в метрах.',
          'Measure the throw distance in metres.'),
    ],
    howToEnter: _t(
      'Введите дальность в метрах. Больше — лучше.',
      'Enter the distance in metres. Higher is better.',
    ),
    commonMistakes: [
      _t('Заступ за линию броска.', 'Stepping over the throw line.'),
      _t('Бросок сбоку вместо из-за головы.', 'Throwing from the side instead of overhead.'),
      _t('Неверный вес мяча.', 'Using the wrong ball weight.'),
    ],
    safety: _t(
      'Разомните плечи и поясницу перед броском.',
      'Warm up shoulders and lower back before throwing.',
    ),
    radarImpact: _t('Балл идёт во «Взрывную силу».',
        'Contributes to Explosive power.'),
  ),

  // ── Гибкость ──────────────────────────────────────────────────────────────
  'sit_and_reach': ExerciseInfo(
    whatMeasures: _t(
      'Гибкость задней поверхности бедра и нижней части спины.',
      'Flexibility of the hamstrings and lower back.',
    ),
    whyNeeded: _t(
      'Наклон вперёд — базовая оценка гибкости задней цепи.',
      'The sit-and-reach is a basic posterior-chain flexibility test.',
    ),
    howToPerform: [
      _t('Сядьте, ноги прямые, стопы у отметки нуля.',
          'Sit with straight legs, feet at the zero mark.'),
      _t('Плавно наклонитесь вперёд, тянитесь руками.',
          'Reach forward slowly with both hands.'),
      _t('Зафиксируйте максимум относительно уровня стоп (см, ±).',
          'Record the furthest reach relative to the feet line (cm, ±).'),
    ],
    howToEnter: _t(
      'Введите результат в сантиметрах: за стопами — плюс, не достаёте — минус.',
      'Enter centimetres: past the feet is positive, short of them is negative.',
    ),
    commonMistakes: [
      _t('Сгибание коленей.', 'Bending the knees.'),
      _t('Рывок вместо плавного наклона.', 'Jerking instead of a smooth reach.'),
      _t('Разная длина рук при замере.', 'Uneven hand reach.'),
    ],
    safety: _t(
      'Не тянитесь до боли; выполняйте после разминки.',
      'Do not stretch into pain; perform after a warm-up.',
    ),
    radarImpact: _t('Балл идёт в «Гибкость».', 'Contributes to Flexibility.'),
  ),
  'deep_squat': ExerciseInfo(
    whatMeasures: _t(
      'Подвижность голеностопа, бёдер и грудного отдела в глубоком приседе.',
      'Ankle, hip and thoracic mobility in a deep squat.',
    ),
    whyNeeded: _t(
      'Глубокий присед — интегральная оценка мобильности нижней части тела.',
      'The deep squat is an integral lower-body mobility screen.',
    ),
    howToPerform: [
      _t('Встаньте, стопы на ширине плеч.', 'Stand with feet shoulder-width apart.'),
      _t('Опуститесь в глубокий присед без веса, руки вверх.',
          'Descend into a full bodyweight squat, arms overhead.'),
      _t('Оцените амплитуду и технику по шкале 1–5.',
          'Rate depth and quality on a 1–5 scale.'),
    ],
    howToEnter: _t(
      'Поставьте оценку 1–5: 5 — полная амплитуда, спина ровная, пятки на полу.',
      'Give a 1–5 rating: 5 = full depth, flat back, heels down.',
    ),
    commonMistakes: [
      _t('Отрыв пяток от пола.', 'Heels lifting off the floor.'),
      _t('Округление поясницы.', 'Rounding the lower back.'),
      _t('Завал корпуса вперёд.', 'Excessive forward lean.'),
    ],
    safety: _t(
      'Выполняйте без веса, в комфортной амплитуде.',
      'Perform unloaded, within a comfortable range.',
    ),
    radarImpact: _t('Балл идёт в «Гибкость».', 'Contributes to Flexibility.'),
  ),
};
