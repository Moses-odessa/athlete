import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthException, Supabase, SupabaseClient;

import '../../../core/supabase/supabase_config.dart';
import '../../../data/remote/cloud_sync.dart';
import '../../../data/remote/supabase_cloud_sync.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../settings/application/data_transfer.dart';

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

  CloudState copyWith({String? email, bool clearEmail = false, bool? busy, String? errorText}) {
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
    return CloudState(
      configured: true,
      email: Supabase.instance.client.auth.currentUser?.email,
    );
  }

  SupabaseClient get _client => Supabase.instance.client;

  Future<bool> signIn(String email, String password) =>
      _auth(() => _client.auth.signInWithPassword(email: email, password: password));

  Future<bool> signUp(String email, String password) =>
      _auth(() => _client.auth.signUp(email: email, password: password));

  Future<bool> _auth(Future<void> Function() action) async {
    state = state.copyWith(busy: true, errorText: null);
    try {
      await action();
      state = state.copyWith(
          busy: false, email: _client.auth.currentUser?.email);
      return _client.auth.currentUser != null;
    } on AuthException catch (e) {
      state = state.copyWith(busy: false, errorText: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(busy: false, errorText: e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    state = state.copyWith(busy: false, clearEmail: true);
  }

  /// Выгрузить локальные данные в облако.
  Future<bool> backup() async {
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
