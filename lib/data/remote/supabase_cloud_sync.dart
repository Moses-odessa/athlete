import 'package:supabase_flutter/supabase_flutter.dart' show SupabaseClient;

import '../../features/settings/application/data_transfer.dart';
import 'cloud_sync.dart';

/// Реализация [CloudSync] поверх Supabase: снимок данных пользователя хранится
/// одной строкой JSONB в таблице `backups` (RLS: только своя строка).
class SupabaseCloudSync implements CloudSync {
  SupabaseCloudSync(this.client);

  final SupabaseClient client;

  @override
  Future<void> push(UserData data) async {
    final uid = client.auth.currentUser?.id;
    if (uid == null) {
      throw StateError('Не выполнен вход в аккаунт');
    }
    await client.from('backups').upsert({
      'user_id': uid,
      'data': encodeUserData(
        profile: data.profile,
        results: data.results,
        now: DateTime.now(),
      ),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<UserData?> pull() async {
    final uid = client.auth.currentUser?.id;
    if (uid == null) return null;
    final row = await client
        .from('backups')
        .select('data')
        .eq('user_id', uid)
        .maybeSingle();
    if (row == null) return null;
    return decodeUserData(Map<String, Object?>.from(row['data'] as Map));
  }
}
