import 'package:supabase_flutter/supabase_flutter.dart';

/// Подключение к Supabase (ТЗ разд. 9, roadmap M2). Ключи задаются при сборке:
///   --dart-define=SUPABASE_URL=https://xxxx.supabase.co
///   --dart-define=SUPABASE_ANON_KEY=sb_publishable_...
/// Пусто → облачные функции выключены, приложение работает offline-first.
class SupabaseConfig {
  static const url = String.fromEnvironment('SUPABASE_URL');
  static const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;
}

/// Инициализирует Supabase, если заданы ключи. Иначе — no-op.
Future<void> initSupabase() async {
  if (!SupabaseConfig.isConfigured) return;
  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.anonKey,
  );
}
