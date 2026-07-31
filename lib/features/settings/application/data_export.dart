import 'dart:convert';

import 'package:share_plus/share_plus.dart';

import '../../../domain/entities/test_result.dart';
import '../../../domain/entities/user_profile.dart';

/// Экспорт данных пользователя в JSON и передача через share sheet
/// (переносимость данных, GDPR — ТЗ разд. 8.3, 4.17).
Future<void> exportUserData({
  required UserProfile? profile,
  required List<TestResult> results,
  required DateTime now,
}) async {
  final data = <String, Object?>{
    'app': 'athlete_index',
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
          },
    'results': [
      for (final r in results)
        {
          'exerciseId': r.exerciseId,
          'value': r.value,
          'date': r.date.toIso8601String(),
          'note': r.note,
        },
    ],
  };

  final json = const JsonEncoder.withIndent('  ').convert(data);
  await SharePlus.instance.share(
    ShareParams(text: json, subject: 'Athlete data export'),
  );
}
