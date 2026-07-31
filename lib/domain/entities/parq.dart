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
    ),
    LocalizedText(
      ru: 'Возникает ли у вас боль в груди при физической активности?',
      en: 'Do you feel pain in your chest when you do physical activity?',
    ),
    LocalizedText(
      ru: 'За последний месяц была ли у вас боль в груди в состоянии покоя?',
      en: 'In the past month, have you had chest pain when you were not doing '
          'physical activity?',
    ),
    LocalizedText(
      ru: 'Теряете ли вы равновесие из-за головокружения или теряли ли '
          'сознание?',
      en: 'Do you lose your balance because of dizziness or do you ever lose '
          'consciousness?',
    ),
    LocalizedText(
      ru: 'Есть ли у вас проблемы с костями или суставами, которые могут '
          'ухудшиться при физической активности?',
      en: 'Do you have a bone or joint problem that could be made worse by a '
          'change in your physical activity?',
    ),
    LocalizedText(
      ru: 'Назначает ли вам врач лекарства от давления или сердца?',
      en: 'Is your doctor currently prescribing drugs for your blood pressure '
          'or heart condition?',
    ),
    LocalizedText(
      ru: 'Знаете ли вы о любой другой причине, по которой вам не следует '
          'заниматься физической активностью?',
      en: 'Do you know of any other reason why you should not do physical '
          'activity?',
    ),
  ];
}
