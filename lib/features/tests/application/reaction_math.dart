/// Среднее время реакции по попыткам, мс (ТЗ разд. 5.2).
double averageMs(List<int> samples) {
  if (samples.isEmpty) return 0;
  return samples.reduce((a, b) => a + b) / samples.length;
}
