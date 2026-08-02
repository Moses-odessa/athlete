/// Строка контента на поддерживаемых языках релиза (ТЗ разд. 1.4, 8.5).
/// Базовые языки — русский и английский (обязательные); украинский, немецкий,
/// итальянский и французский опциональны и при отсутствии падают на английский.
class LocalizedText {
  final String ru;
  final String en;
  final String? uk;
  final String? de;
  final String? it;
  final String? fr;

  const LocalizedText({
    required this.ru,
    required this.en,
    this.uk,
    this.de,
    this.it,
    this.fr,
  });

  /// Значение для кода языка (fallback — английский).
  String forLanguage(String languageCode) => switch (languageCode) {
        'ru' => ru,
        'uk' => uk ?? en,
        'de' => de ?? en,
        'it' => it ?? en,
        'fr' => fr ?? en,
        _ => en,
      };
}
