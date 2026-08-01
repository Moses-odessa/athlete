import 'package:athlete_index/data/models/categories_seed.dart';
import 'package:athlete_index/features/recommendations/application/weekly_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('пустой список слабых → пустой план', () {
    expect(generateWeeklyPlan(const []), isEmpty);
  });

  test('план на 7 дней с фокусом на слабых и днями отдыха', () {
    final plan = generateWeeklyPlan(
        [CategorySlugs.strength, CategorySlugs.endurance]);
    expect(plan.length, 7);
    // День 1 — фокус на первой слабой категории, с дриллами.
    expect(plan.first.categorySlug, CategorySlugs.strength);
    expect(plan.first.items, isNotEmpty);
    // День 2 — вторая слабая.
    expect(plan[1].categorySlug, CategorySlugs.endurance);
    // Последний день — отдых (без категории и дриллов).
    expect(plan.last.isRest, isTrue);
  });

  test('одна слабая категория → используется и как вторичная', () {
    final plan = generateWeeklyPlan([CategorySlugs.mobility]);
    expect(plan.length, 7);
    expect(plan.first.categorySlug, CategorySlugs.mobility);
    expect(plan[1].categorySlug, CategorySlugs.mobility);
  });
}
