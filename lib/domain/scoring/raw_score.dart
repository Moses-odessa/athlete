import 'dart:math';

import '../entities/scale_type.dart';

/// Линейный балл теста (ТЗ разд. 4.6). Результат ограничен [0; 100].
///
/// «Больше — лучше»:  Балл = ((Результат − Минимум) / (Эталон − Минимум)) × 100
/// «Меньше — лучше»:  Балл = ((Минимум − Результат) / (Минимум − Эталон)) × 100
double linearScore(
  num result,
  num min,
  num ref, {
  required bool higherIsBetter,
}) {
  final double raw;
  if (higherIsBetter) {
    // Вырожденный норматив: защита от деления на ноль.
    if (ref == min) return result >= ref ? 100 : 0;
    raw = (result - min) / (ref - min);
  } else {
    if (min == ref) return result <= ref ? 100 : 0;
    raw = (min - result) / (min - ref);
  }
  return (raw * 100).clamp(0, 100).toDouble();
}

/// Нелинейная («насыщающая») шкала (ТЗ разд. 4.6):
/// Балл = 100 × (1 − exp(−k × Балл_лин/100)) / (1 − exp(−k)).
/// Даёт быстрый рост в начале и «плато» ближе к 100. По умолчанию k = 2.5.
double nonlinearScore(double linear, {double k = 2.5}) {
  final l = linear.clamp(0, 100) / 100.0;
  return 100 * (1 - exp(-k * l)) / (1 - exp(-k));
}

/// Применить выбранную шкалу к линейному баллу (ТЗ разд. 4.17).
double applyScale(double linear, ScaleType scale, {double k = 2.5}) {
  return scale == ScaleType.nonlinear ? nonlinearScore(linear, k: k) : linear;
}

/// Качественная оценка 1–5 → 0–100 равномерной сеткой (ТЗ разд. 5.5).
double qualitativeToScore(int rating) {
  final r = rating.clamp(1, 5);
  return (r - 1) / 4 * 100;
}
