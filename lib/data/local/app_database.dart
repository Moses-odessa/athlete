import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../domain/entities/equipment.dart';
import '../../domain/entities/gender.dart';
import '../../domain/entities/test_result.dart';
import '../../domain/entities/training_experience.dart';
import '../../domain/entities/training_goal.dart';
import '../../domain/entities/user_profile.dart';

part 'app_database.g.dart';

/// Профиль пользователя — одна строка (id = 1). Enum'ы хранятся по `.name`,
/// оборудование — списком имён через запятую.
class Profiles extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get gender => text()();
  DateTimeColumn get dateOfBirth => dateTime()();
  RealColumn get weightKg => real()();
  RealColumn get heightCm => real()();
  TextColumn get experience => text()();
  TextColumn get equipment => text()();
  TextColumn get goal => text()();
  BoolColumn get parqPassed => boolean()();
  BoolColumn get acceptedTerms => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Введённые результаты тестов (ТЗ разд. 11).
class Results extends Table {
  TextColumn get id => text()();
  TextColumn get exerciseId => text()();
  RealColumn get value => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();
  TextColumn get videoPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Локальная БД (offline-first, ТЗ разд. 8.2). На web без wasm-ассетов запросы
/// бросают исключение — вызывающая сторона откатывается в режим без сохранения.
@DriftDatabase(tables: [Profiles, Results])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'athlete_db'));

  @override
  int get schemaVersion => 1;

  Future<UserProfile?> loadProfile() async {
    final row =
        await (select(profiles)..where((t) => t.id.equals(1))).getSingleOrNull();
    return row == null ? null : _toProfile(row);
  }

  Future<void> upsertProfile(UserProfile profile) =>
      into(profiles).insertOnConflictUpdate(_toProfileRow(profile));

  Future<void> clearProfile() => delete(profiles).go();

  Future<List<TestResult>> loadResults() async {
    final rows = await (select(results)
          ..orderBy([(t) => OrderingTerm(expression: t.date)]))
        .get();
    return rows.map(_toResult).toList();
  }

  Future<void> replaceResults(List<TestResult> items) => batch((b) {
        b.deleteWhere(results, (_) => const Constant(true));
        b.insertAll(results, items.map(_toResultRow).toList());
      });

  // ── Мапперы ────────────────────────────────────────────────────────────
  UserProfile _toProfile(Profile row) => UserProfile(
        id: 'local',
        gender: Gender.values.byName(row.gender),
        dateOfBirth: row.dateOfBirth,
        weightKg: row.weightKg,
        heightCm: row.heightCm,
        experience: TrainingExperience.values.byName(row.experience),
        equipment: row.equipment.isEmpty
            ? <Equipment>{}
            : row.equipment
                .split(',')
                .map((n) => Equipment.values.byName(n))
                .toSet(),
        goal: TrainingGoal.values.byName(row.goal),
        parqPassed: row.parqPassed,
        acceptedTerms: row.acceptedTerms,
      );

  ProfilesCompanion _toProfileRow(UserProfile p) => ProfilesCompanion(
        id: const Value(1),
        gender: Value(p.gender.name),
        dateOfBirth: Value(p.dateOfBirth),
        weightKg: Value(p.weightKg),
        heightCm: Value(p.heightCm),
        experience: Value(p.experience.name),
        equipment: Value(p.equipment.map((e) => e.name).join(',')),
        goal: Value(p.goal.name),
        parqPassed: Value(p.parqPassed),
        acceptedTerms: Value(p.acceptedTerms),
      );

  TestResult _toResult(Result row) => TestResult(
        id: row.id,
        exerciseId: row.exerciseId,
        value: row.value,
        date: row.date,
        note: row.note,
        videoPath: row.videoPath,
      );

  ResultsCompanion _toResultRow(TestResult r) => ResultsCompanion.insert(
        id: r.id,
        exerciseId: r.exerciseId,
        value: r.value.toDouble(),
        date: r.date,
        note: Value(r.note),
        videoPath: Value(r.videoPath),
      );
}
