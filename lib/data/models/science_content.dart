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
  uk: 'Застосунок оцінює різнобічну підготовку за вісьмома якостями. '
      'Тести обрані як відтворювані польові протоколи, широко описані в '
      'літературі зі спортивної науки та доступні без лабораторного обладнання.',
  de: 'Die App bewertet die vielseitige Fitness anhand von acht Eigenschaften. '
      'Die Tests wurden als reproduzierbare Feldprotokolle gewählt, die in der '
      'sportwissenschaftlichen Literatur umfassend dokumentiert und ohne '
      'Laborausrüstung durchführbar sind.',
  it: 'L\'app valuta la preparazione a tutto tondo attraverso otto qualità. '
      'I test sono scelti come protocolli sul campo riproducibili, ampiamente '
      'documentati nella letteratura di scienze motorie ed eseguibili senza '
      'attrezzatura da laboratorio.',
  fr: 'L\'application évalue la condition physique globale selon huit qualités. '
      'Les tests sont choisis comme des protocoles de terrain reproductibles, '
      'largement documentés dans la littérature en sciences du sport et réalisables '
      'sans équipement de laboratoire.',
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
  uk: 'Кожен результат нормується між «мінімумом» (0 балів) та «еталоном» '
      '(100 балів) когорти. Лінійна шкала пропорційна результату; '
      'нелінійна (k ≈ 2.5) швидше зростає на початку та виходить на плато біля 100, '
      'що реалістичніше відображає тренувальний прогрес. Бал обмежений 0–100.',
  de: 'Jedes Ergebnis wird zwischen dem „Minimum" (0 Punkte) und der „Referenz" '
      '(100 Punkte) der Kohorte normiert. Die lineare Skala ist proportional zum '
      'Ergebnis; die nichtlineare (k ≈ 2,5) steigt anfangs schneller und flacht '
      'nahe 100 ab, was den Trainingsfortschritt realistischer abbildet. Der Wert '
      'ist auf 0–100 begrenzt.',
  it: 'Ogni risultato è normalizzato tra il «minimo» (0 punti) e il «riferimento» '
      '(100 punti) della coorte. La scala lineare è proporzionale al risultato; '
      'quella non lineare (k ≈ 2,5) cresce più rapidamente all\'inizio e si '
      'stabilizza vicino a 100, riflettendo in modo più realistico i progressi '
      'dell\'allenamento. Il punteggio è limitato a 0–100.',
  fr: 'Chaque résultat est normalisé entre le « minimum » (0 point) et la '
      '« référence » (100 points) de la cohorte. L\'échelle linéaire est '
      'proportionnelle au résultat ; la non linéaire (k ≈ 2,5) croît plus vite au '
      'début et atteint un plateau près de 100, reflétant plus fidèlement la '
      'progression à l\'entraînement. Le score est borné à 0–100.',
);

const List<LocalizedText> kScienceFormulas = [
  LocalizedText(
    ru: 'Больше — лучше:  Балл = ((Результат − Мин) / (Эталон − Мин)) × 100',
    en: 'Higher is better:  Score = ((Result − Min) / (Ref − Min)) × 100',
    uk: 'Більше — краще:  Бал = ((Результат − Мін) / (Еталон − Мін)) × 100',
    de: 'Mehr ist besser:  Punkte = ((Ergebnis − Min) / (Referenz − Min)) × 100',
    it: 'Più è meglio:  Punteggio = ((Risultato − Min) / (Rif − Min)) × 100',
    fr: 'Plus, c\'est mieux :  Score = ((Résultat − Min) / (Réf − Min)) × 100',
  ),
  LocalizedText(
    ru: 'Меньше — лучше:  Балл = ((Мин − Результат) / (Мин − Эталон)) × 100',
    en: 'Lower is better:  Score = ((Min − Result) / (Min − Ref)) × 100',
    uk: 'Менше — краще:  Бал = ((Мін − Результат) / (Мін − Еталон)) × 100',
    de: 'Weniger ist besser:  Punkte = ((Min − Ergebnis) / (Min − Referenz)) × 100',
    it: 'Meno è meglio:  Punteggio = ((Min − Risultato) / (Min − Rif)) × 100',
    fr: 'Moins, c\'est mieux :  Score = ((Min − Résultat) / (Min − Réf)) × 100',
  ),
  LocalizedText(
    ru: 'Нелинейная:  Балл = 100 × (1 − e^(−k·Балл/100)) / (1 − e^(−k))',
    en: 'Non-linear:  Score = 100 × (1 − e^(−k·Score/100)) / (1 − e^(−k))',
    uk: 'Нелінійна:  Бал = 100 × (1 − e^(−k·Бал/100)) / (1 − e^(−k))',
    de: 'Nichtlinear:  Punkte = 100 × (1 − e^(−k·Punkte/100)) / (1 − e^(−k))',
    it: 'Non lineare:  Punteggio = 100 × (1 − e^(−k·Punteggio/100)) / (1 − e^(−k))',
    fr: 'Non linéaire :  Score = 100 × (1 − e^(−k·Score/100)) / (1 − e^(−k))',
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
  uk: 'Нормативи зберігаються за когортами {стать, вікова група}. За еталон '
      'узято когорту чоловіків 25–29 років; для інших когорт планка '
      'коригується коефіцієнтами статі та віку. 100 балів — рівень '
      'різнобічного атлета-натурала, який тренується роками, а не світовий '
      'рекорд. Нормативи попередні й уточнюються на етапі калібрування зі '
      'спортивним експертом.',
  de: 'Die Normen werden pro Kohorte {Geschlecht, Altersgruppe} gespeichert. Als '
      'Referenz gilt die Kohorte der Männer im Alter von 25–29 Jahren; für andere '
      'Kohorten wird die Messlatte über Geschlechts- und Altersfaktoren angepasst. '
      '100 Punkte entsprechen einem vielseitigen Natural-Athleten, der seit Jahren '
      'trainiert, nicht einem Weltrekord. Die Normen sind vorläufig und werden '
      'während der Kalibrierung mit einem sportwissenschaftlichen Experten '
      'verfeinert.',
  it: 'Le norme sono memorizzate per coorte {sesso, fascia d\'età}. La coorte di '
      'riferimento è quella degli uomini di 25–29 anni; per le altre coorti '
      'l\'asticella è corretta con fattori di sesso ed età. 100 punti '
      'rappresentano un atleta natural a tutto tondo che si allena da anni, non un '
      'record mondiale. Le norme sono preliminari e vengono affinate durante la '
      'taratura con un esperto di scienze motorie.',
  fr: 'Les normes sont stockées par cohorte {sexe, tranche d\'âge}. La cohorte de '
      'référence est celle des hommes de 25–29 ans ; pour les autres cohortes, le '
      'seuil est ajusté par des facteurs de sexe et d\'âge. 100 points '
      'correspondent à un athlète natural polyvalent s\'entraînant depuis des '
      'années, pas à un record du monde. Les normes sont préliminaires et affinées '
      'lors du calibrage avec un expert en sciences du sport.',
);

const kScienceDisclaimer = LocalizedText(
  ru: 'Приложение не заменяет медицинскую консультацию. Перед максимальными '
      'тестами убедитесь в отсутствии противопоказаний и при необходимости '
      'проконсультируйтесь с врачом.',
  en: 'The app does not replace medical advice. Before maximal tests, make sure '
      'you have no contraindications and consult a doctor if needed.',
  uk: 'Застосунок не замінює медичну консультацію. Перед максимальними '
      'тестами переконайтеся у відсутності протипоказань і за потреби '
      'проконсультуйтеся з лікарем.',
  de: 'Die App ersetzt keine ärztliche Beratung. Stellen Sie vor Maximaltests '
      'sicher, dass keine Kontraindikationen vorliegen, und konsultieren Sie bei '
      'Bedarf einen Arzt.',
  it: 'L\'app non sostituisce il parere medico. Prima dei test massimali, '
      'assicurati di non avere controindicazioni e consulta un medico se '
      'necessario.',
  fr: 'L\'application ne remplace pas un avis médical. Avant les tests maximaux, '
      'assurez-vous de n\'avoir aucune contre-indication et consultez un médecin si '
      'nécessaire.',
);
