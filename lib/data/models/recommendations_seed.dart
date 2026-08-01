import '../../domain/entities/localized_text.dart';
import 'categories_seed.dart';

/// Упражнение/паттерн для прокачки категории (ТЗ разд. 4.11).
class Recommendation {
  final LocalizedText title;
  final LocalizedText description;
  const Recommendation({required this.title, required this.description});
}

LocalizedText _t(String ru, String en) => LocalizedText(ru: ru, en: en);

/// Статичные рекомендации по категориям (ТЗ разд. 4.11, MVP-контент).
/// TODO(content): выверить с методистом; пост-MVP — генерация недельного плана.
final Map<String, List<Recommendation>> kRecommendations = {
  CategorySlugs.strength: [
    Recommendation(
      title: _t('Прогрессия в базовых', 'Progressive overload'),
      description: _t(
          'Добавляйте вес в жиме/приседе/становой 2.5–5 кг в неделю, 3–5 повторов.',
          'Add 2.5–5 kg weekly on bench/squat/deadlift, 3–5 reps.'),
    ),
    Recommendation(
      title: _t('Подтягивания с прогрессией', 'Weighted pull-ups'),
      description: _t('3–4 подхода, добавляйте вес или повторы каждую неделю.',
          '3–4 sets, add weight or reps each week.'),
    ),
    Recommendation(
      title: _t('Вспомогательные тяги/жимы', 'Rows and presses'),
      description: _t('Тяги в наклоне, жим стоя — 3×8–12 для баланса мышц.',
          'Bent-over rows, overhead press — 3×8–12 for balance.'),
    ),
    Recommendation(
      title: _t('Работа над хватом', 'Grip work'),
      description: _t('Прогулка фермера и удержания — 3–4 подхода.',
          "Farmer's walks and holds — 3–4 sets."),
    ),
  ],
  CategorySlugs.speed: [
    Recommendation(
      title: _t('Спринты с ускорением', 'Acceleration sprints'),
      description: _t('6–8 забегов по 20–30 м с полным отдыхом.',
          '6–8 runs of 20–30 m with full recovery.'),
    ),
    Recommendation(
      title: _t('Забеги в гору', 'Hill sprints'),
      description: _t('6–10 коротких забегов в горку для мощности.',
          '6–10 short hill sprints for power.'),
    ),
    Recommendation(
      title: _t('Техника бега', 'Running drills'),
      description: _t('A/B-скипинг, захлёст — 3×20 м на технику.',
          'A/B skips, butt kicks — 3×20 m for technique.'),
    ),
    Recommendation(
      title: _t('Плиометрика', 'Plyometrics'),
      description: _t('Прыжковые упражнения 2×/нед для реактивности.',
          'Jump drills 2×/week for reactivity.'),
    ),
  ],
  CategorySlugs.endurance: [
    Recommendation(
      title: _t('Долгий лёгкий бег (Zone 2)', 'Long easy runs (Zone 2)'),
      description: _t('1–2 раза в неделю 40–70 мин в лёгком темпе.',
          '1–2×/week, 40–70 min at an easy pace.'),
    ),
    Recommendation(
      title: _t('Интервалы', 'Intervals'),
      description: _t('4–6×3 мин быстро / 2 мин трусцой.',
          '4–6×3 min hard / 2 min jog.'),
    ),
    Recommendation(
      title: _t('Темповый бег', 'Tempo runs'),
      description: _t('20–30 мин в комфортно-тяжёлом темпе.',
          '20–30 min at a comfortably-hard pace.'),
    ),
    Recommendation(
      title: _t('Кросс-тренинг', 'Cross-training'),
      description: _t('Гребля/велосипед для объёма без ударной нагрузки.',
          'Rowing/cycling for volume without impact.'),
    ),
  ],
  CategorySlugs.explosive: [
    Recommendation(
      title: _t('Прыжковая подготовка', 'Jump training'),
      description: _t('Прыжки в высоту/длину — 3–5×3–5 с полным отдыхом.',
          'Vertical/broad jumps — 3–5×3–5 with full rest.'),
    ),
    Recommendation(
      title: _t('Варианты рывка/толчка', 'Olympic lift variations'),
      description: _t('Взятие в стойку, толчок — техника и мощность.',
          'Power cleans, push press — technique and power.'),
    ),
    Recommendation(
      title: _t('Броски медбола', 'Medicine ball throws'),
      description: _t('Броски из-за головы и от груди — 4×5 взрывно.',
          'Overhead and chest throws — 4×5 explosively.'),
    ),
    Recommendation(
      title: _t('Депт-джампы', 'Depth jumps'),
      description: _t('С невысокой опоры, акцент на быстрый контакт.',
          'From a low box, focus on quick ground contact.'),
    ),
  ],
  CategorySlugs.coordination: [
    Recommendation(
      title: _t('Координационная лестница', 'Agility ladder'),
      description: _t('5–8 паттернов быстрых ног ежедневно 5–10 мин.',
          '5–8 quick-feet patterns, 5–10 min daily.'),
    ),
    Recommendation(
      title: _t('Скакалка', 'Jump rope'),
      description: _t('Разные стили 3×1 мин для ритма и стоп.',
          'Varied styles 3×1 min for rhythm and feet.'),
    ),
    Recommendation(
      title: _t('Реакционные дриллы', 'Reaction drills'),
      description: _t('Старт по сигналу, ловля мяча одной рукой.',
          'Start-on-cue, one-hand ball catches.'),
    ),
    Recommendation(
      title: _t('Жонглирование/мяч', 'Ball skills'),
      description: _t('Простое жонглирование для глаз-рука.',
          'Simple juggling for hand-eye coordination.'),
    ),
  ],
  CategorySlugs.flexibility: [
    Recommendation(
      title: _t('Статическая растяжка', 'Static stretching'),
      description: _t('Задняя поверхность и спина — 3×30–45 с ежедневно.',
          'Hamstrings and back — 3×30–45 s daily.'),
    ),
    Recommendation(
      title: _t('PNF-растяжка', 'PNF stretching'),
      description: _t('Напряжение-расслабление 2–3×/нед.',
          'Contract-relax 2–3×/week.'),
    ),
    Recommendation(
      title: _t('Ежедневная мобилити-рутина', 'Daily mobility routine'),
      description: _t('10 мин на бёдра, спину, плечи.',
          '10 min for hips, back, shoulders.'),
    ),
    Recommendation(
      title: _t('Глубокий присед-хват', 'Deep squat holds'),
      description: _t('Удержания в приседе 3×30–60 с.',
          'Bodyweight squat holds 3×30–60 s.'),
    ),
  ],
  CategorySlugs.balance: [
    Recommendation(
      title: _t('Стойки на одной ноге', 'Single-leg stands'),
      description: _t('С открытыми/закрытыми глазами, 3×30–60 с.',
          'Eyes open/closed, 3×30–60 s.'),
    ),
    Recommendation(
      title: _t('Нестабильная опора', 'Unstable surface'),
      description: _t('Балансборд/подушка — контроль корпуса.',
          'Balance board/cushion — core control.'),
    ),
    Recommendation(
      title: _t('Y-Balance практика', 'Y-Balance practice'),
      description: _t('Дотягивания по 3 направлениям, 3 круга.',
          '3-direction reaches, 3 rounds.'),
    ),
    Recommendation(
      title: _t('Динамические выпады', 'Dynamic lunges'),
      description: _t('Выпады с паузой на удержание равновесия.',
          'Lunges with a balance pause.'),
    ),
  ],
  CategorySlugs.mobility: [
    Recommendation(
      title: _t('Мобилити голеностопа', 'Ankle mobility'),
      description: _t('Колено-к-стене 3×10 на каждую ногу ежедневно.',
          'Knee-to-wall 3×10 per side daily.'),
    ),
    Recommendation(
      title: _t('Ротация грудного отдела', 'Thoracic rotations'),
      description: _t('Открытая книга 2×10 на сторону.',
          'Open-book 2×10 per side.'),
    ),
    Recommendation(
      title: _t('CARs тазобедренного', 'Hip CARs'),
      description: _t('Контролируемые круги 3–5 на сторону.',
          'Controlled articular rotations 3–5 per side.'),
    ),
    Recommendation(
      title: _t('Дрилл приседа над головой', 'Overhead squat drill'),
      description: _t('С палкой — амплитуда и контроль 3×8.',
          'With a dowel — range and control 3×8.'),
    ),
  ],
};

List<Recommendation> recommendationsFor(String categorySlug) =>
    kRecommendations[categorySlug] ?? const [];
