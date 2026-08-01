import 'package:athlete_index/data/local/app_database.dart';
import 'package:athlete_index/domain/entities/entities.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('профиль: сохранение и загрузка (round-trip)', () async {
    expect(await db.loadProfile(), isNull);

    final profile = UserProfile(
      id: 'local',
      gender: Gender.female,
      dateOfBirth: DateTime(1995, 3, 10),
      weightKg: 62.5,
      heightCm: 168,
      experience: TrainingExperience.threePlusYears,
      equipment: const {Equipment.barbell, Equipment.pullUpBar},
      goal: TrainingGoal.competition,
      parqPassed: false,
      acceptedTerms: true,
    );
    await db.upsertProfile(profile);

    final loaded = await db.loadProfile();
    expect(loaded, isNotNull);
    expect(loaded!.gender, Gender.female);
    expect(loaded.weightKg, 62.5);
    expect(loaded.experience, TrainingExperience.threePlusYears);
    expect(loaded.equipment, {Equipment.barbell, Equipment.pullUpBar});
    expect(loaded.goal, TrainingGoal.competition);
    expect(loaded.parqPassed, isFalse);

    await db.clearProfile();
    expect(await db.loadProfile(), isNull);
  });

  test('результаты: replaceResults и загрузка по дате', () async {
    await db.replaceResults([
      TestResult(
        id: 'r1',
        exerciseId: 'pull_ups',
        value: 12,
        date: DateTime(2026, 6, 1),
        note: 'strict',
        bodyweightKg: 78.5,
        heightCm: 180,
      ),
      TestResult(
        id: 'r2',
        exerciseId: 'bench_press',
        value: 90,
        date: DateTime(2026, 5, 1),
      ),
    ]);

    final loaded = await db.loadResults();
    expect(loaded.length, 2);
    // Отсортировано по дате возрастанию.
    expect(loaded.first.exerciseId, 'bench_press');
    expect(loaded.first.value, 90);
    expect(loaded.last.exerciseId, 'pull_ups');
    expect(loaded.last.note, 'strict');
    expect(loaded.last.bodyweightKg, 78.5);
    expect(loaded.last.heightCm, 180);

    // Полная замена.
    await db.replaceResults([]);
    expect(await db.loadResults(), isEmpty);
  });

  test('настройки: сохранение и загрузка (round-trip)', () async {
    expect(await db.loadSettings(), isNull);

    const settings = AppSettings(
      units: UnitSystem.imperial,
      themeMode: AppThemeMode.light,
      languageCode: 'en',
      scaleType: ScaleType.nonlinear,
      notificationsEnabled: true,
    );
    await db.saveSettings(settings);

    final loaded = await db.loadSettings();
    expect(loaded, isNotNull);
    expect(loaded!.units, UnitSystem.imperial);
    expect(loaded.themeMode, AppThemeMode.light);
    expect(loaded.languageCode, 'en');
    expect(loaded.scaleType, ScaleType.nonlinear);
    expect(loaded.notificationsEnabled, isTrue);
  });
}
