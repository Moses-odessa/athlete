import '../../domain/entities/localized_text.dart';

/// Первоисточник для раздела «Научная база» (ТЗ разд. 4.16).
class ScienceReference {
  final String title;
  final String source;
  final String url;
  const ScienceReference(this.title, this.source, this.url);
}

const List<ScienceReference> kScienceReferences = [
  ScienceReference(
    "ACSM's Guidelines for Exercise Testing and Prescription",
    'ACSM',
    'https://www.acsm.org',
  ),
  ScienceReference(
    'Essentials of Strength Training and Conditioning',
    'NSCA',
    'https://www.nsca.com',
  ),
  ScienceReference(
    'Guidelines on Physical Activity and Sedentary Behaviour (2020)',
    'WHO',
    'https://www.who.int/publications/i/item/9789240015128',
  ),
  ScienceReference(
    'Cooper KH. A means of assessing maximal oxygen intake. JAMA, 1968',
    'JAMA',
    'https://jamanetwork.com/journals/jama/article-abstract/337382',
  ),
  ScienceReference(
    'Functional Movement Screen (FMS)',
    'Cook G. et al.',
    'https://www.functionalmovement.com',
  ),
];

const kScienceIntro = LocalizedText(
  ru: 'Приложение оценивает разностороннюю подготовку по восьми качествам. '
      'Тесты выбраны как воспроизводимые полевые протоколы, широко описанные в '
      'литературе по спортивной науке и доступные без лабораторного оборудования.',
  en: 'The app assesses all-round fitness across eight qualities. Tests are '
      'chosen as reproducible field protocols, widely documented in sports-science '
      'literature and doable without lab equipment.',
);

const kScienceFormulaBody = LocalizedText(
  ru: 'Каждый результат нормируется между «минимумом» (0 баллов) и «эталоном» '
      '(100 баллов) когорты. Линейная шкала пропорциональна результату; '
      'нелинейная (k ≈ 2.5) быстрее растёт в начале и выходит на плато у 100, '
      'что реалистичнее отражает тренировочный прогресс. Балл ограничен 0–100.',
  en: 'Each result is normalised between the cohort "minimum" (0 points) and '
      '"reference" (100 points). The linear scale is proportional to the result; '
      'the non-linear one (k ≈ 2.5) grows faster early and plateaus near 100, more '
      'realistically reflecting training progress. The score is clamped to 0–100.',
);

const List<LocalizedText> kScienceFormulas = [
  LocalizedText(
    ru: 'Больше — лучше:  Балл = ((Результат − Мин) / (Эталон − Мин)) × 100',
    en: 'Higher is better:  Score = ((Result − Min) / (Ref − Min)) × 100',
  ),
  LocalizedText(
    ru: 'Меньше — лучше:  Балл = ((Мин − Результат) / (Мин − Эталон)) × 100',
    en: 'Lower is better:  Score = ((Min − Result) / (Min − Ref)) × 100',
  ),
  LocalizedText(
    ru: 'Нелинейная:  Балл = 100 × (1 − e^(−k·Балл/100)) / (1 − e^(−k))',
    en: 'Non-linear:  Score = 100 × (1 − e^(−k·Score/100)) / (1 − e^(−k))',
  ),
];

const kScienceNormsBody = LocalizedText(
  ru: 'Нормативы хранятся по когортам {пол, возрастная группа}. За эталон '
      'принята когорта мужчин 25–29 лет; для остальных когорт планка '
      'корректируется коэффициентами пола и возраста. 100 баллов — уровень '
      'разностороннего атлета-натурала, тренирующегося годами, а не мировой '
      'рекорд. Нормативы предварительные и уточняются на этапе калибровки со '
      'спортивным экспертом.',
  en: 'Norms are stored per cohort {sex, age group}. The reference cohort is '
      'men aged 25–29; other cohorts are adjusted by sex and age factors. '
      '100 points represents an all-round natural athlete training for years, not '
      'a world record. Norms are preliminary and refined during calibration with a '
      'sports-science expert.',
);

const kScienceDisclaimer = LocalizedText(
  ru: 'Приложение не заменяет медицинскую консультацию. Перед максимальными '
      'тестами убедитесь в отсутствии противопоказаний и при необходимости '
      'проконсультируйтесь с врачом.',
  en: 'The app does not replace medical advice. Before maximal tests, make sure '
      'you have no contraindications and consult a doctor if needed.',
);
