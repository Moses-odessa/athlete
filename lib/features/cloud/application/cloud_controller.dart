import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthException, SignOutScope, Supabase, SupabaseClient;

import '../../../core/supabase/supabase_config.dart';
import '../../../data/remote/cloud_sync.dart';
import '../../../data/remote/supabase_cloud_sync.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../settings/application/data_transfer.dart';

/// Результат попытки входа/регистрации.
class AuthOutcome {
  final bool ok;
  final bool cloudHasData;
  final String? error;
  const AuthOutcome({required this.ok, this.cloudHasData = false, this.error});
}

/// Состояние облачного раздела (ТЗ разд. 4.17, roadmap M2).
class CloudState {
  final bool configured;
  final String? email;
  final bool busy;
  final String? errorText;

  const CloudState({
    required this.configured,
    this.email,
    this.busy = false,
    this.errorText,
  });

  bool get signedIn => email != null;

  CloudState copyWith(
      {String? email, bool clearEmail = false, bool? busy, String? errorText}) {
    return CloudState(
      configured: configured,
      email: clearEmail ? null : (email ?? this.email),
      busy: busy ?? this.busy,
      errorText: errorText,
    );
  }
}

final cloudSyncProvider = Provider<CloudSync>((ref) {
  if (SupabaseConfig.isConfigured) {
    return SupabaseCloudSync(Supabase.instance.client);
  }
  return const NoopCloudSync();
});

class CloudController extends Notifier<CloudState> {
  @override
  CloudState build() {
    if (!SupabaseConfig.isConfigured) return const CloudState(configured: false);
    // Реагируем на изменения сессии (в т.ч. форс-логаут с другого устройства).
    final sub = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final user = data.session?.user;
      state = user == null
          ? state.copyWith(clearEmail: true)
          : state.copyWith(email: user.email);
    });
    ref.onDispose(sub.cancel);
    return CloudState(
      configured: true,
      email: Supabase.instance.client.auth.currentUser?.email,
    );
  }

  SupabaseClient get _client => Supabase.instance.client;

  Future<AuthOutcome> signIn(String email, String password) =>
      _auth(() => _client.auth
          .signInWithPassword(email: email, password: password));

  Future<AuthOutcome> signUp(String email, String password) =>
      _auth(() => _client.auth.signUp(email: email, password: password));

  Future<AuthOutcome> _auth(Future<void> Function() action) async {
    state = state.copyWith(busy: true, errorText: null);
    try {
      await action();
      if (_client.auth.currentUser == null) {
        state = state.copyWith(busy: false);
        return const AuthOutcome(ok: false);
      }
      // Одно активное устройство: отзываем сессии остальных (ТЗ M2).
      try {
        await _client.auth.signOut(scope: SignOutScope.others);
      } catch (_) {}
      state = state.copyWith(busy: false, email: _client.auth.currentUser?.email);
      final hasCloud = await _cloudHasData();
      return AuthOutcome(ok: true, cloudHasData: hasCloud);
    } on AuthException catch (e) {
      state = state.copyWith(busy: false, errorText: e.message);
      return AuthOutcome(ok: false, error: e.message);
    } catch (e) {
      state = state.copyWith(busy: false, errorText: e.toString());
      return AuthOutcome(ok: false, error: e.toString());
    }
  }

  Future<bool> _cloudHasData() async {
    try {
      final uid = _client.auth.currentUser?.id;
      if (uid == null) return false;
      final row = await _client
          .from('backups')
          .select('user_id')
          .eq('user_id', uid)
          .maybeSingle();
      return row != null;
    } catch (_) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    state = state.copyWith(busy: false, clearEmail: true);
  }

  /// Выгрузить локальные данные в облако.
  Future<bool> backup() async {
    if (!state.signedIn) return false;
    state = state.copyWith(busy: true, errorText: null);
    try {
      final data = UserData(
        ref.read(profileControllerProvider),
        ref.read(resultsControllerProvider),
      );
      await ref.read(cloudSyncProvider).push(data);
      state = state.copyWith(busy: false);
      return true;
    } catch (e) {
      state = state.copyWith(busy: false, errorText: e.toString());
      return false;
    }
  }

  /// Восстановить данные из облака в локальные контроллеры.
  Future<bool> restore() async {
    state = state.copyWith(busy: true, errorText: null);
    try {
      final data = await ref.read(cloudSyncProvider).pull();
      if (data != null) {
        ref.read(resultsControllerProvider.notifier).setAll(data.results);
        if (data.profile != null) {
          ref.read(profileControllerProvider.notifier).save(data.profile!);
        }
      }
      state = state.copyWith(busy: false);
      return true;
    } catch (e) {
      state = state.copyWith(busy: false, errorText: e.toString());
      return false;
    }
  }
}

final cloudControllerProvider =
    NotifierProvider<CloudController, CloudState>(CloudController.new);
