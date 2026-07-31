/// Сырой результат теста, введённый пользователем (ТЗ разд. 4.5, 11).
/// Персистентность (Drift) добавляется на data-итерации.
class TestResult {
  final String id;
  final String exerciseId;
  final num value;
  final DateTime date;
  final String? note;
  final String? videoPath;

  const TestResult({
    required this.id,
    required this.exerciseId,
    required this.value,
    required this.date,
    this.note,
    this.videoPath,
  });
}
