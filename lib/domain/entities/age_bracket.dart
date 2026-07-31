/// Возрастные брэкеты когорты (ТЗ разд. 4.9).
enum AgeBracket {
  b18to24,
  b25to29,
  b30to34,
  b35to39,
  b40to44,
  b45to49,
  b50plus;

  /// Брэкет по полному числу лет. Возраст младше 18 попадает в младший брэкет
  /// (18–24) — целевая аудитория 18+, но допускается 16+ (ТЗ разд. 1.3, 15).
  static AgeBracket fromAge(int age) {
    if (age < 25) return AgeBracket.b18to24;
    if (age < 30) return AgeBracket.b25to29;
    if (age < 35) return AgeBracket.b30to34;
    if (age < 40) return AgeBracket.b35to39;
    if (age < 45) return AgeBracket.b40to44;
    if (age < 50) return AgeBracket.b45to49;
    return AgeBracket.b50plus;
  }

  /// Человекочитаемая подпись брэкета (напр. «25–29»).
  String get label {
    switch (this) {
      case AgeBracket.b18to24:
        return '18–24';
      case AgeBracket.b25to29:
        return '25–29';
      case AgeBracket.b30to34:
        return '30–34';
      case AgeBracket.b35to39:
        return '35–39';
      case AgeBracket.b40to44:
        return '40–44';
      case AgeBracket.b45to49:
        return '45–49';
      case AgeBracket.b50plus:
        return '50+';
    }
  }
}
