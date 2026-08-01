import '../../features/settings/application/data_transfer.dart';

/// Интерфейс облачной синхронизации (ТЗ разд. 8.2, roadmap M2).
///
/// Реальная реализация на Supabase подключается при наличии бэкенд-проекта и
/// ключей; до этого приложение работает offline-first, а перенос данных между
/// устройствами выполняется экспортом/импортом JSON (см. data_transfer.dart).
abstract class CloudSync {
  Future<void> push(UserData data);
  Future<UserData?> pull();
}

/// Заглушка без сети — синхронизация выключена.
class NoopCloudSync implements CloudSync {
  const NoopCloudSync();

  @override
  Future<void> push(UserData data) async {}

  @override
  Future<UserData?> pull() async => null;
}
