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

  // ── Скорость ──────────────────────────────────────────────────────────
  'sprint_30m': ExerciseInfo(
    whatMeasures: _t('Стартовое ускорение и максимальную скорость на 30 м.',
        'Start acceleration and top speed over 30 m.'),
    whyNeeded: _t('Короткий спринт отражает мощность и скорость атлета.',
        'A short sprint reflects athletic power and speed.'),
    howToPerform: [
      _t('Разомнитесь и сделайте несколько ускорений.',
          'Warm up with a few strides.'),
      _t('Пробегите 30 м на максимум с высокого старта.',
          'Run 30 m at maximal effort from a standing start.'),
      _t('Зафиксируйте время (секунды, десятые).',
          'Record the time (seconds, tenths).'),
    ],
    howToEnter: _t('Введите время в секундах (можно десятые). Меньше — лучше.',
        'Enter the time in seconds (tenths allowed). Lower is better.'),
    commonMistakes: [
      _t('Фальстарт и торможение на финише.',
          'False start and slowing before the line.'),
      _t('Замер без разминки.', 'Testing without a warm-up.'),
      _t('Неточная дистанция.', 'Inaccurate distance.'),
    ],
    safety: _t('Разомните мышцы задней поверхности бедра во избежание травм.',
        'Warm up the hamstrings to avoid injury.'),
    radarImpact: _t('Балл идёт в «Скорость».', 'Contributes to Speed.'),
  ),
  'sprint_60m': ExerciseInfo(
    whatMeasures: _t('Скорость на дистанции 60 м.', 'Speed over 60 m.'),
    whyNeeded: _t('60 м сочетают ускорение и удержание скорости.',
        '60 m blends acceleration and speed maintenance.'),
    howToPerform: [
      _t('Разомнитесь.', 'Warm up.'),
      _t('Пробегите 60 м на максимум.', 'Run 60 m at maximal effort.'),
      _t('Зафиксируйте время.', 'Record the time.'),
    ],
    howToEnter: _t('Введите время в секундах. Меньше — лучше.',
        'Enter the time in seconds. Lower is better.'),
    commonMistakes: [
      _t('Неравномерный разгон.', 'Uneven acceleration.'),
      _t('Отсутствие разминки.', 'No warm-up.'),
      _t('Замер по ветру.', 'Wind-aided measurement.'),
    ],
    safety: _t('Тщательно разомнитесь перед максимальным спринтом.',
        'Warm up thoroughly before a maximal sprint.'),
    radarImpact: _t('Балл идёт в «Скорость».', 'Contributes to Speed.'),
  ),
  'sprint_100m': ExerciseInfo(
    whatMeasures: _t('Максимальную скорость и скоростную выносливость на 100 м.',
        'Top speed and speed-endurance over 100 m.'),
    whyNeeded: _t('100 м — классический тест спринтерской скорости.',
        'The 100 m is a classic sprint-speed test.'),
    howToPerform: [
      _t('Разомнитесь.', 'Warm up.'),
      _t('Пробегите 100 м на максимум.', 'Run 100 m at maximal effort.'),
      _t('Зафиксируйте время.', 'Record the time.'),
    ],
    howToEnter: _t('Введите время в секундах. Меньше — лучше.',
        'Enter the time in seconds. Lower is better.'),
    commonMistakes: [
      _t('Ранний максимум и спад к финишу.',
          'Peaking early and fading at the finish.'),
      _t('Плохая разминка.', 'Poor warm-up.'),
      _t('Неточный хронометраж.', 'Inaccurate timing.'),
    ],
    safety: _t('Высокая нагрузка на мышцы — только после разминки.',
        'High muscle load — only after warming up.'),
    radarImpact: _t('Балл идёт в «Скорость».', 'Contributes to Speed.'),
  ),
  'shuttle_10x10': ExerciseInfo(
    whatMeasures: _t('Скорость с многократными разворотами (агилити).',
        'Speed with repeated direction changes (agility).'),
    whyNeeded: _t('Челнок отражает ускорения, торможения и развороты.',
        'The shuttle reflects accelerations, braking and turns.'),
    howToPerform: [
      _t('Отметьте две линии в 10 м.', 'Mark two lines 10 m apart.'),
      _t('Пробегите 10 отрезков туда-обратно на максимум.',
          'Run ten 10 m lengths back and forth at maximal effort.'),
      _t('Зафиксируйте суммарное время.', 'Record the total time.'),
    ],
    howToEnter: _t('Введите суммарное время в секундах. Меньше — лучше.',
        'Enter the total time in seconds. Lower is better.'),
    commonMistakes: [
      _t('Заступ за линию не считается.', 'Not touching the line.'),
      _t('Широкие развороты.', 'Wide turns.'),
      _t('Скользкая поверхность.', 'Slippery surface.'),
    ],
    safety: _t('Нужна нескользкая поверхность и разминка суставов.',
        'Requires a non-slip surface and joint warm-up.'),
    radarImpact: _t('Балл идёт в «Скорость».', 'Contributes to Speed.'),
  ),

  'reaction_test': ExerciseInfo(
    whatMeasures: _t('Скорость простой зрительно-моторной реакции.',
        'Simple visual-motor reaction speed.'),
    whyNeeded: _t('Реакция важна для спорта и безопасности движений.',
        'Reaction speed matters for sport and safe movement.'),
    howToPerform: [
      _t('Дождитесь смены цвета экрана на зелёный.',
          'Wait for the screen to turn green.'),
      _t('Коснитесь экрана как можно быстрее.',
          'Tap the screen as fast as possible.'),
      _t('Повторите 5 раз — берётся среднее.',
          'Repeat 5 times — the average is taken.'),
    ],
    howToEnter: _t(
        'Результат замеряется в приложении автоматически (миллисекунды).',
        'The result is measured automatically in the app (milliseconds).'),
    commonMistakes: [
      _t('Касание до зелёного (фальстарт).', 'Tapping before green (false start).'),
      _t('Отвлечение внимания.', 'Getting distracted.'),
      _t('Задержка из-за тормозного экрана.', 'Lag from a slow screen.'),
    ],
    safety: _t('Особых противопоказаний нет.', 'No special contraindications.'),
    radarImpact: _t('Балл идёт в «Скорость».', 'Contributes to Speed.'),
  ),

  // ── Координация ───────────────────────────────────────────────────────
  'illinois_agility': ExerciseInfo(
    whatMeasures: _t('Ловкость и координацию при смене направлений.',
        'Agility and coordination during direction changes.'),
    whyNeeded: _t('Стандартизированный тест ловкости с конусами.',
        'A standardised agility test with cones.'),
    howToPerform: [
      _t('Расставьте конусы по схеме Illinois.',
          'Set up cones in the Illinois layout.'),
      _t('Пройдите трассу максимально быстро.',
          'Complete the course as fast as possible.'),
      _t('Зафиксируйте время.', 'Record the time.'),
    ],
    howToEnter: _t('Введите время в секундах. Меньше — лучше.',
        'Enter the time in seconds. Lower is better.'),
    commonMistakes: [
      _t('Сбитые конусы.', 'Knocking over cones.'),
      _t('Неверная схема трассы.', 'Wrong course layout.'),
      _t('Широкие повороты.', 'Wide turns.'),
    ],
    safety: _t('Разомните голеностопы и колени.',
        'Warm up ankles and knees.'),
    radarImpact: _t('Балл идёт в «Координацию».', 'Contributes to Coordination.'),
  ),
  'catch_ball': ExerciseInfo(
    whatMeasures: _t('Зрительно-моторную координацию рук.',
        'Hand-eye coordination.'),
    whyNeeded: _t('Ловля мяча — простой тест координации «глаз-рука».',
        'Ball catching is a simple hand-eye coordination test.'),
    howToPerform: [
      _t('Партнёр бросает мяч 10 раз.', 'A partner throws the ball 10 times.'),
      _t('Ловите одной рукой.', 'Catch with one hand.'),
      _t('Считайте успешные ловли.', 'Count successful catches.'),
    ],
    howToEnter: _t('Введите число пойманных мячей из 10. Больше — лучше.',
        'Enter catches out of 10. Higher is better.'),
    commonMistakes: [
      _t('Разная сила/траектория бросков.', 'Inconsistent throws.'),
      _t('Ловля двумя руками.', 'Catching with two hands.'),
      _t('Слишком близко/далеко.', 'Distance too short or long.'),
    ],
    safety: _t('Особых противопоказаний нет.', 'No special contraindications.'),
    radarImpact: _t('Балл идёт в «Координацию».', 'Contributes to Coordination.'),
  ),
  'jump_rope_30s': ExerciseInfo(
    whatMeasures: _t('Ритмичную координацию и скорость стоп.',
        'Rhythmic coordination and foot speed.'),
    whyNeeded: _t('Скакалка отражает координацию и темп.',
        'Rope skipping reflects coordination and tempo.'),
    howToPerform: [
      _t('Возьмите скакалку по росту.', 'Use a rope sized to your height.'),
      _t('Прыгайте 30 секунд максимально быстро.',
          'Skip for 30 seconds as fast as possible.'),
      _t('Считайте число прыжков.', 'Count the skips.'),
    ],
    howToEnter: _t('Введите число прыжков за 30 с. Больше — лучше.',
        'Enter skips in 30 s. Higher is better.'),
    commonMistakes: [
      _t('Сбои и остановки.', 'Trips and stops.'),
      _t('Двойные прыжки на один оборот.', 'Double bouncing per turn.'),
      _t('Неверная длина скакалки.', 'Wrong rope length.'),
    ],
    safety: _t('Прыгайте на амортизирующей поверхности.',
        'Skip on a cushioned surface.'),
    radarImpact: _t('Балл идёт в «Координацию».', 'Contributes to Coordination.'),
  ),
  'movement_precision': ExerciseInfo(
    whatMeasures: _t('Точность выполнения координационного паттерна.',
        'Accuracy of a coordination pattern.'),
    whyNeeded: _t('Оценивает контроль и точность движений.',
        'Assesses movement control and precision.'),
    howToPerform: [
      _t('Выполните заданный координационный паттерн.',
          'Perform the prescribed coordination pattern.'),
      _t('Оцените точность и контроль по шкале 1–5.',
          'Rate accuracy and control on a 1–5 scale.'),
    ],
    howToEnter: _t('Поставьте оценку 1–5: 5 — высокая точность.',
        'Give a 1–5 rating: 5 = high precision.'),
    commonMistakes: [
      _t('Спешка в ущерб точности.', 'Rushing at the cost of accuracy.'),
      _t('Непостоянные критерии оценки.', 'Inconsistent scoring criteria.'),
    ],
    safety: _t('Особых противопоказаний нет.', 'No special contraindications.'),
    radarImpact: _t('Балл идёт в «Координацию».', 'Contributes to Coordination.'),
  ),

  // ── Баланс ────────────────────────────────────────────────────────────
  'single_leg_stand': ExerciseInfo(
    whatMeasures: _t('Статическое равновесие с закрытыми глазами.',
        'Static balance with eyes closed.'),
    whyNeeded: _t('Простой тест проприоцепции и стабильности.',
        'A simple proprioception and stability test.'),
    howToPerform: [
      _t('Встаньте на одну ногу, закройте глаза.',
          'Stand on one leg and close your eyes.'),
      _t('Удерживайте равновесие как можно дольше.',
          'Hold balance as long as possible.'),
      _t('Остановите время при потере равновесия.',
          'Stop the timer when balance is lost.'),
    ],
    howToEnter: _t('Введите время удержания в секундах. Больше — лучше.',
        'Enter the hold time in seconds. Higher is better.'),
    commonMistakes: [
      _t('Открывание глаз.', 'Opening the eyes.'),
      _t('Опора о предметы.', 'Touching supports.'),
      _t('Прыжки/шаги опорной ногой.', 'Hopping or stepping.'),
    ],
    safety: _t('Выполняйте рядом с опорой на случай падения.',
        'Perform near a support in case of a fall.'),
    radarImpact: _t('Балл идёт в «Баланс».', 'Contributes to Balance.'),
  ),
  'y_balance': ExerciseInfo(
    whatMeasures: _t('Динамическое равновесие при дотягивании.',
        'Dynamic balance during reaching.'),
    whyNeeded: _t('Оценивает контроль в трёх направлениях.',
        'Assesses control in three directions.'),
    howToPerform: [
      _t('Стоя на одной ноге, тянитесь другой в 3 направлениях.',
          'On one leg, reach the other in 3 directions.'),
      _t('Оцените нормированный результат по шкале 1–5.',
          'Rate the normalised reach on a 1–5 scale.'),
    ],
    howToEnter: _t('Поставьте оценку 1–5: 5 — максимальный контроль.',
        'Give a 1–5 rating: 5 = maximal control.'),
    commonMistakes: [
      _t('Перенос веса на опору.', 'Shifting weight onto a support.'),
      _t('Потеря нейтрали таза.', 'Losing pelvic neutral.'),
      _t('Касание пола дальней ногой.', 'Touching down with the reach leg.'),
    ],
    safety: _t('Разомните голеностоп и бедро.', 'Warm up ankle and hip.'),
    radarImpact: _t('Балл идёт в «Баланс».', 'Contributes to Balance.'),
  ),
  'star_excursion': ExerciseInfo(
    whatMeasures: _t('Динамическую стабильность по многим направлениям.',
        'Dynamic stability across many directions.'),
    whyNeeded: _t('Расширенная оценка динамического баланса.',
        'An extended dynamic-balance assessment.'),
    howToPerform: [
      _t('Дотягивайтесь ногой по лучам звезды.',
          'Reach along the star arms with one foot.'),
      _t('Оцените контроль и дальность по шкале 1–5.',
          'Rate control and reach on a 1–5 scale.'),
    ],
    howToEnter: _t('Поставьте оценку 1–5.', 'Give a 1–5 rating.'),
    commonMistakes: [
      _t('Опора дальней ногой.', 'Weighting the reach leg.'),
      _t('Наклон корпуса для компенсации.', 'Compensating by leaning.'),
      _t('Разная разметка.', 'Inconsistent markings.'),
    ],
    safety: _t('Выполняйте рядом с опорой.', 'Perform near a support.'),
    radarImpact: _t('Балл идёт в «Баланс».', 'Contributes to Balance.'),
  ),
  'beam_walk': ExerciseInfo(
    whatMeasures: _t('Динамическое равновесие при ходьбе по узкой опоре.',
        'Dynamic balance walking a narrow support.'),
    whyNeeded: _t('Оценивает контроль равновесия в движении.',
        'Assesses balance control while moving.'),
    howToPerform: [
      _t('Пройдите 10 м по бревну или ленте.',
          'Walk 10 m along a beam or a line.'),
      _t('Оцените проход без ошибок по шкале 1–5.',
          'Rate an error-free walk on a 1–5 scale.'),
    ],
    howToEnter: _t('Поставьте оценку 1–5: 5 — без ошибок.',
        'Give a 1–5 rating: 5 = error-free.'),
    commonMistakes: [
      _t('Сходы с опоры.', 'Stepping off.'),
      _t('Взгляд под ноги вместо горизонта.',
          'Looking down instead of ahead.'),
      _t('Слишком быстрый темп.', 'Walking too fast.'),
    ],
    safety: _t('Используйте невысокую опору.', 'Use a low beam.'),
    radarImpact: _t('Балл идёт в «Баланс».', 'Contributes to Balance.'),
  ),

  // ── Мобильность ───────────────────────────────────────────────────────
  'fms_overhead_squat': ExerciseInfo(
    whatMeasures: _t('Общую подвижность в приседе с руками над головой.',
        'Overall mobility in an overhead squat.'),
    whyNeeded: _t('Скрининг подвижности всей кинетической цепи.',
        'A whole-chain mobility screen.'),
    howToPerform: [
      _t('Присед с палкой/руками над головой.',
          'Squat with a dowel or arms overhead.'),
      _t('Оцените паттерн по шкале 1–5.',
          'Rate the pattern on a 1–5 scale.'),
    ],
    howToEnter: _t('Поставьте оценку 1–5: 5 — чистый паттерн.',
        'Give a 1–5 rating: 5 = clean pattern.'),
    commonMistakes: [
      _t('Завал рук вперёд.', 'Arms falling forward.'),
      _t('Отрыв пяток.', 'Heels lifting.'),
      _t('Округление спины.', 'Rounding the back.'),
    ],
    safety: _t('Выполняйте без веса.', 'Perform unloaded.'),
    radarImpact: _t('Балл идёт в «Мобильность».', 'Contributes to Mobility.'),
  ),
  'ankle_dorsiflexion': ExerciseInfo(
    whatMeasures: _t('Подвижность голеностопа (тыльное сгибание).',
        'Ankle dorsiflexion mobility.'),
    whyNeeded: _t('Важна для приседа, бега и амортизации.',
        'Key for squatting, running and shock absorption.'),
    howToPerform: [
      _t('Колено к стене, пятка на полу.',
          'Knee toward the wall, heel down.'),
      _t('Измерьте максимальное расстояние носка от стены (см).',
          'Measure the max toe-to-wall distance (cm).'),
    ],
    howToEnter: _t('Введите расстояние в сантиметрах. Больше — лучше.',
        'Enter the distance in centimetres. Higher is better.'),
    commonMistakes: [
      _t('Отрыв пятки.', 'Heel lifting.'),
      _t('Заваливание колена внутрь.', 'Knee caving inward.'),
      _t('Замер без контакта колена со стеной.',
          'Measuring without knee-to-wall contact.'),
    ],
    safety: _t('Не тянитесь через боль в голеностопе.',
        'Do not push through ankle pain.'),
    radarImpact: _t('Балл идёт в «Мобильность».', 'Contributes to Mobility.'),
  ),
  'shoulder_flexion': ExerciseInfo(
    whatMeasures: _t('Подвижность плеча при сгибании.',
        'Shoulder flexion mobility.'),
    whyNeeded: _t('Нужна для работы над головой и жимов.',
        'Needed for overhead work and pressing.'),
    howToPerform: [
      _t('Спиной к стене, поднимите руки над головой.',
          'Back to the wall, raise arms overhead.'),
      _t('Оцените прижатие рук к стене по шкале 1–5.',
          'Rate arms-to-wall contact on a 1–5 scale.'),
    ],
    howToEnter: _t('Поставьте оценку 1–5: 5 — руки полностью прижаты.',
        'Give a 1–5 rating: 5 = arms fully against the wall.'),
    commonMistakes: [
      _t('Прогиб в пояснице для компенсации.',
          'Arching the lower back to compensate.'),
      _t('Разведение локтей.', 'Elbows flaring.'),
      _t('Отрыв рёбер от стены.', 'Ribs lifting off the wall.'),
    ],
    safety: _t('Осторожно при проблемах с плечом.',
        'Be cautious with shoulder issues.'),
    radarImpact: _t('Балл идёт в «Мобильность».', 'Contributes to Mobility.'),
  ),
  'hip_internal_rotation': ExerciseInfo(
    whatMeasures: _t('Внутреннюю ротацию тазобедренного сустава.',
        'Hip internal rotation range.'),
    whyNeeded: _t('Влияет на присед, бег и ротационные движения.',
        'Affects squatting, running and rotational movements.'),
    howToPerform: [
      _t('Сидя, разверните голень наружу, оценив амплитуду.',
          'Seated, rotate the shin outward and assess the range.'),
      _t('Оцените амплитуду по шкале 1–5.',
          'Rate the range on a 1–5 scale.'),
    ],
    howToEnter: _t('Поставьте оценку 1–5: 5 — полная амплитуда.',
        'Give a 1–5 rating: 5 = full range.'),
    commonMistakes: [
      _t('Компенсация наклоном таза.', 'Compensating by tilting the pelvis.'),
      _t('Сравнение без учёта асимметрии.',
          'Ignoring left/right asymmetry.'),
      _t('Форсирование амплитуды.', 'Forcing the range.'),
    ],
    safety: _t('Не форсируйте через боль в суставе.',
        'Do not force through joint pain.'),
    radarImpact: _t('Балл идёт в «Мобильность».', 'Contributes to Mobility.'),
  ),
};
