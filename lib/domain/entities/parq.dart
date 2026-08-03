import 'localized_text.dart';

/// Стандартный опросник готовности к физической активности PAR-Q (ТЗ разд. 4.1).
/// 7 вопросов; ответ «да» хотя бы на один — повод для консультации врача перед
/// максимальными тестами (ТЗ разд. 15).
class ParqQuestionnaire {
  /// Ответы на 7 вопросов; true — «да».
  final List<bool> answers;

  ParqQuestionnaire(this.answers)
      : assert(answers.length == questionCount);

  static const int questionCount = 7;

  /// Все ответы «нет».
  factory ParqQuestionnaire.allNegative() =>
      ParqQuestionnaire(List<bool>.filled(questionCount, false));

  bool get hasPositiveAnswer => answers.any((a) => a);

  /// Прошёл без ограничений (нет ни одного «да»).
  bool get passed => !hasPositiveAnswer;

  static const List<LocalizedText> questions = [
    LocalizedText(
      ru: 'Говорил ли вам врач, что у вас есть проблемы с сердцем и что вам '
          'следует выполнять физическую активность только под наблюдением врача?',
      en: 'Has your doctor ever said that you have a heart condition and that '
          'you should only do physical activity recommended by a doctor?',
      uk: 'Чи казав вам лікар, що у вас проблеми з серцем і що вам слід '
          'виконувати фізичні навантаження лише під наглядом лікаря?',
      de: 'Hat Ihr Arzt jemals gesagt, dass Sie ein Herzleiden haben und dass '
          'Sie körperliche Aktivität nur unter ärztlicher Aufsicht ausüben sollten?',
      it: 'Il medico le ha mai detto che soffre di una malattia cardiaca e che '
          'dovrebbe svolgere attività fisica solo dietro consiglio del medico?',
      fr: 'Votre médecin vous a-t-il déjà dit que vous souffriez d\'un problème '
          'cardiaque et que vous ne deviez faire de l\'activité physique que sur '
          'recommandation d\'un médecin?',
    ),
    LocalizedText(
      ru: 'Возникает ли у вас боль в груди при физической активности?',
      en: 'Do you feel pain in your chest when you do physical activity?',
      uk: 'Чи відчуваєте ви біль у грудях під час фізичної активності?',
      de: 'Verspüren Sie Schmerzen in der Brust, wenn Sie körperlich aktiv sind?',
      it: 'Avverte dolore al petto quando svolge attività fisica?',
      fr: 'Ressentez-vous une douleur à la poitrine lorsque vous faites de '
          'l\'activité physique?',
    ),
    LocalizedText(
      ru: 'За последний месяц была ли у вас боль в груди в состоянии покоя?',
      en: 'In the past month, have you had chest pain when you were not doing '
          'physical activity?',
      uk: 'Чи виникав у вас за останній місяць біль у грудях у стані спокою?',
      de: 'Hatten Sie im letzten Monat Schmerzen in der Brust, wenn Sie sich '
          'nicht körperlich betätigt haben?',
      it: 'Nell\'ultimo mese ha avuto dolore al petto mentre non svolgeva '
          'attività fisica?',
      fr: 'Au cours du dernier mois, avez-vous ressenti une douleur à la '
          'poitrine alors que vous ne faisiez pas d\'activité physique?',
    ),
    LocalizedText(
      ru: 'Теряете ли вы равновесие из-за головокружения или теряли ли '
          'сознание?',
      en: 'Do you lose your balance because of dizziness or do you ever lose '
          'consciousness?',
      uk: 'Чи втрачаєте ви рівновагу через запаморочення або чи втрачали ви '
          'свідомість?',
      de: 'Verlieren Sie aufgrund von Schwindel das Gleichgewicht oder haben '
          'Sie schon einmal das Bewusstsein verloren?',
      it: 'Perde l\'equilibrio a causa di vertigini o ha mai perso conoscenza?',
      fr: 'Perdez-vous l\'équilibre à cause d\'étourdissements ou vous '
          'arrive-t-il de perdre connaissance?',
    ),
    LocalizedText(
      ru: 'Есть ли у вас проблемы с костями или суставами, которые могут '
          'ухудшиться при физической активности?',
      en: 'Do you have a bone or joint problem that could be made worse by a '
          'change in your physical activity?',
      uk: 'Чи маєте ви проблеми з кістками або суглобами, які можуть '
          'погіршитися через зміну фізичної активності?',
      de: 'Haben Sie Knochen- oder Gelenkprobleme, die sich durch eine '
          'Veränderung Ihrer körperlichen Aktivität verschlimmern könnten?',
      it: 'Ha problemi alle ossa o alle articolazioni che potrebbero peggiorare '
          'con un cambiamento della sua attività fisica?',
      fr: 'Avez-vous des problèmes osseux ou articulaires qui pourraient '
          's\'aggraver avec un changement de votre activité physique?',
    ),
    LocalizedText(
      ru: 'Назначает ли вам врач лекарства от давления или сердца?',
      en: 'Is your doctor currently prescribing drugs for your blood pressure '
          'or heart condition?',
      uk: 'Чи призначає вам лікар ліки від тиску або серцевого захворювання?',
      de: 'Verschreibt Ihnen Ihr Arzt derzeit Medikamente gegen Bluthochdruck '
          'oder ein Herzleiden?',
      it: 'Il suo medico le sta attualmente prescrivendo farmaci per la '
          'pressione sanguigna o per una malattia cardiaca?',
      fr: 'Votre médecin vous prescrit-il actuellement des médicaments pour '
          'votre tension artérielle ou un problème cardiaque?',
    ),
    LocalizedText(
      ru: 'Знаете ли вы о любой другой причине, по которой вам не следует '
          'заниматься физической активностью?',
      en: 'Do you know of any other reason why you should not do physical '
          'activity?',
      uk: 'Чи знаєте ви про будь-яку іншу причину, через яку вам не слід '
          'займатися фізичною активністю?',
      de: 'Ist Ihnen ein anderer Grund bekannt, aus dem Sie keine körperliche '
          'Aktivität ausüben sollten?',
      it: 'È a conoscenza di qualsiasi altro motivo per cui non dovrebbe '
          'svolgere attività fisica?',
      fr: 'Connaissez-vous une autre raison pour laquelle vous ne devriez pas '
          'faire d\'activité physique?',
    ),
  ];
}
