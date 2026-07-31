import 'localized_text.dart';

/// Содержимое инфо-модалки теста (ТЗ разд. 4.4). Семь обязательных разделов.
class ExerciseInfo {
  /// Что измеряет — какое физическое качество и почему.
  final LocalizedText whatMeasures;

  /// Зачем нужен — ценность для разностороннего атлета.
  final LocalizedText whyNeeded;

  /// Как выполнять — пошаговая инструкция.
  final List<LocalizedText> howToPerform;

  /// Как ввести результат — формат, единицы, что учитывать.
  final LocalizedText howToEnter;

  /// Типичные ошибки (3–5 пунктов).
  final List<LocalizedText> commonMistakes;

  /// Противопоказания и безопасность.
  final LocalizedText safety;

  /// Влияние на радар — на какие категории идёт балл.
  final LocalizedText radarImpact;

  const ExerciseInfo({
    required this.whatMeasures,
    required this.whyNeeded,
    required this.howToPerform,
    required this.howToEnter,
    required this.commonMistakes,
    required this.safety,
    required this.radarImpact,
  });
}
