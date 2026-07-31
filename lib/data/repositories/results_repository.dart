import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/test_result.dart';

/// Хранилище введённых результатов тестов. Пока in-memory (offline-first);
/// персистентность через Drift — на data-итерации (ТЗ разд. 8.2).
class ResultsController extends Notifier<List<TestResult>> {
  @override
  List<TestResult> build() => const [];

  void add(TestResult result) => state = [...state, result];

  void setAll(List<TestResult> results) => state = List.unmodifiable(results);

  void clear() => state = const [];
}

final resultsControllerProvider =
    NotifierProvider<ResultsController, List<TestResult>>(
        ResultsController.new);
