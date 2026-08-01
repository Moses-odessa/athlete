import 'package:share_plus/share_plus.dart';

import '../../../domain/entities/test_result.dart';
import '../../../domain/entities/user_profile.dart';
import 'data_transfer.dart';

/// Экспорт данных пользователя в JSON и передача через share sheet
/// (переносимость данных, GDPR — ТЗ разд. 8.3, 4.17).
Future<void> exportUserData({
  required UserProfile? profile,
  required List<TestResult> results,
  required DateTime now,
}) async {
  final json =
      encodeUserDataJson(profile: profile, results: results, now: now);
  await SharePlus.instance.share(
    ShareParams(text: json, subject: 'Athlete data export'),
  );
}
