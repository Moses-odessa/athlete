import 'dart:convert';

import '../../../domain/entities/equipment.dart';
import '../../../domain/entities/gender.dart';
import '../../../domain/entities/test_result.dart';
import '../../../domain/entities/training_experience.dart';
import '../../../domain/entities/training_goal.dart';
import '../../../domain/entities/user_profile.dart';

/// Результат разбора импортируемых данных (ТЗ разд. 4.17, 8.2).
class UserData {
  final UserProfile? profile;
  final List<TestResult> results;
  const UserData(this.profile, this.results);
}

/// Сериализация профиля и результатов в переносимую структуру (JSON).
Map<String, Object?> encodeUserData({
  required UserProfile? profile,
  required List<TestResult> results,
  required DateTime now,
}) {
  return {
    'app': 'athlete_index',
    'version': 1,
    'exportedAt': now.toIso8601String(),
    'profile': profile == null
        ? null
        : {
            'gender': profile.gender.name,
            'dateOfBirth': profile.dateOfBirth.toIso8601String(),
            'weightKg': profile.weightKg,
            'heightCm': profile.heightCm,
            'experience': profile.experience.name,
            'equipment': profile.equipment.map((e) => e.name).toList(),
            'goal': profile.goal.name,
            'parqPassed': profile.parqPassed,
            'acceptedTerms': profile.acceptedTerms,
          },
    'results': [
      for (final r in results)
        {
          'id': r.id,
          'exerciseId': r.exerciseId,
          'value': r.value,
          'date': r.date.toIso8601String(),
          'note': r.note,
          'bodyweightKg': r.bodyweightKg,
          'heightCm': r.heightCm,
        },
    ],
  };
}

String encodeUserDataJson({
  required UserProfile? profile,
  required List<TestResult> results,
  required DateTime now,
}) =>
    const JsonEncoder.withIndent('  ')
        .convert(encodeUserData(profile: profile, results: results, now: now));

/// Разбор ранее экспортированного JSON. Бросает [FormatException] при неверной
/// структуре.
UserData decodeUserDataJson(String source) {
  final Object? root = jsonDecode(source);
  if (root is! Map<String, Object?>) {
    throw const FormatException('Ожидался объект JSON');
  }
  return decodeUserData(root);
}

/// Разбор структуры данных (напр. JSONB из облака) в [UserData].
UserData decodeUserData(Map<String, Object?> root) {
  UserProfile? profile;
  final p = root['profile'];
  if (p is Map<String, Object?>) {
    profile = UserProfile(
      id: 'local',
      gender: Gender.values.byName(p['gender'] as String),
      dateOfBirth: DateTime.parse(p['dateOfBirth'] as String),
      weightKg: (p['weightKg'] as num).toDouble(),
      heightCm: (p['heightCm'] as num).toDouble(),
      experience: TrainingExperience.values.byName(p['experience'] as String),
      equipment: {
        for (final e in (p['equipment'] as List? ?? const []))
          Equipment.values.byName(e as String),
      },
      goal: TrainingGoal.values.byName(p['goal'] as String),
      parqPassed: p['parqPassed'] as bool? ?? true,
      acceptedTerms: p['acceptedTerms'] as bool? ?? true,
    );
  }

  final results = <TestResult>[];
  final rs = root['results'];
  if (rs is List) {
    for (final item in rs) {
      if (item is! Map<String, Object?>) continue;
      results.add(TestResult(
        id: item['id'] as String? ??
            DateTime.parse(item['date'] as String).microsecondsSinceEpoch
                .toString(),
        exerciseId: item['exerciseId'] as String,
        value: item['value'] as num,
        date: DateTime.parse(item['date'] as String),
        note: item['note'] as String?,
        bodyweightKg: (item['bodyweightKg'] as num?)?.toDouble(),
        heightCm: (item['heightCm'] as num?)?.toDouble(),
      ));
    }
  }

  return UserData(profile, results);
}
