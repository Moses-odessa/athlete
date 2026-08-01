/// Сырой результат теста, введённый пользователем (ТЗ разд. 4.5, 11).
class TestResult {
  final String id;
  final String exerciseId;
  final num value;
  final DateTime date;
  final String? note;
  final String? videoPath;

  /// Масса тела на момент выполнения теста, кг. Нужна для корректного расчёта
  /// баллов силовых тестов (×BW): балл считается по весу «тогда», а не текущему.
  /// null — для старых записей (откат на текущий вес профиля).
  final double? bodyweightKg;

  /// Рост на момент выполнения, см (историческая справка; в баллах не участвует).
  final double? heightCm;

  const TestResult({
    required this.id,
    required this.exerciseId,
    required this.value,
    required this.date,
    this.note,
    this.videoPath,
    this.bodyweightKg,
    this.heightCm,
  });
}
