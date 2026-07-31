import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/entities/scale_type.dart';

/// Настройки приложения (ТЗ разд. 4.17). Персистятся через bootstrap в Drift.
class SettingsController extends Notifier<AppSettings> {
  @override
  AppSettings build() => AppSettings.defaults;

  void replace(AppSettings settings) => state = settings;

  void setUnits(UnitSystem units) => state = state.copyWith(units: units);

  void setThemeMode(AppThemeMode mode) =>
      state = state.copyWith(themeMode: mode);

  void setLanguage(String? languageCode) => state = languageCode == null
      ? state.copyWith(clearLanguage: true)
      : state.copyWith(languageCode: languageCode);

  void setScaleType(ScaleType scaleType) =>
      state = state.copyWith(scaleType: scaleType);

  void setNotifications(bool enabled) =>
      state = state.copyWith(notificationsEnabled: enabled);
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);
