/// Строка контента на поддерживаемых языках релиза (ТЗ разд. 1.4, 8.5).
/// В MVP — русский и английский; инфраструктура готова под доп. языки.
class LocalizedText {
  final String ru;
  final String en;

  const LocalizedText({required this.ru, required this.en});

  /// Значение для кода языка (по умолчанию — английский как fallback).
  String forLanguage(String languageCode) => languageCode == 'ru' ? ru : en;
}
