import '../../domain/entities/category.dart';
import '../../domain/entities/exercise.dart';
import 'categories_seed.dart';
import 'exercises_seed.dart';

export 'categories_seed.dart';
export 'exercises_seed.dart';

/// Каталог тестов MVP: удобный доступ к сид-данным (ТЗ разд. 4.3, 5, 12).
class Catalog {
  const Catalog._();

  static List<Category> get categories => kCategories;

  static List<Exercise> get exercises => kMvpExercises;

  /// Тесты выбранной категории.
  static List<Exercise> exercisesFor(String categorySlug) =>
      kMvpExercises.where((e) => e.categorySlug == categorySlug).toList();

  /// Тест по идентификатору (или null).
  static Exercise? exerciseById(String id) {
    for (final e in kMvpExercises) {
      if (e.id == id) return e;
    }
    return null;
  }

  /// Категория по slug (или null).
  static Category? categoryBySlug(String slug) {
    for (final c in kCategories) {
      if (c.slug == slug) return c;
    }
    return null;
  }
}
