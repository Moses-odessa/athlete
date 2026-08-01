import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_profile.dart';

/// Хранилище профиля пользователя. Пока in-memory (offline-first);
/// персистентность через Drift добавляется на data-итерации (ТЗ разд. 8.2).
class ProfileController extends Notifier<UserProfile?> {
  @override
  UserProfile? build() => null;

  void save(UserProfile profile) => state = profile;

  void updateWeight(double weightKg) =>
      state = state?.copyWith(weightKg: weightKg);

  void updateHeight(double heightCm) =>
      state = state?.copyWith(heightCm: heightCm);

  void clear() => state = null;
}

final profileControllerProvider =
    NotifierProvider<ProfileController, UserProfile?>(ProfileController.new);
