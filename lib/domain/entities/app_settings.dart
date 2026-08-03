import 'scale_type.dart';

/// Система единиц измерения (ТЗ разд. 4.17, 8.5).
enum UnitSystem { metric, imperial }

/// Режим темы (ТЗ разд. 4.17). Тёмная — по умолчанию (ТЗ разд. 8.4).
enum AppThemeMode { system, light, dark }

/// Пользовательские настройки приложения (ТЗ разд. 4.17).
class AppSettings {
  final UnitSystem units;
  final AppThemeMode themeMode;

  /// Код языка интерфейса; null — язык системы.
  final String? languageCode;

  /// Тип шкалы расчёта балла (ТЗ разд. 4.6).
  final ScaleType scaleType;

  final bool notificationsEnabled;

  /// Автоматически сохранять данные в облако при изменениях (ТЗ M2).
  final bool autoCloudSync;

  /// Пройден ли стартовый экран выбора «вход / регистрация / без аккаунта».
  /// false у нового пользователя → показываем welcome-гейт до онбординга (#2).
  final bool authGatePassed;

  const AppSettings({
    this.units = UnitSystem.metric,
    this.themeMode = AppThemeMode.dark,
    this.languageCode,
    this.scaleType = ScaleType.linear,
    this.notificationsEnabled = false,
    this.autoCloudSync = true,
    this.authGatePassed = false,
  });

  static const defaults = AppSettings();

  AppSettings copyWith({
    UnitSystem? units,
    AppThemeMode? themeMode,
    String? languageCode,
    bool clearLanguage = false,
    ScaleType? scaleType,
    bool? notificationsEnabled,
    bool? autoCloudSync,
    bool? authGatePassed,
  }) {
    return AppSettings(
      units: units ?? this.units,
      themeMode: themeMode ?? this.themeMode,
      languageCode: clearLanguage ? null : (languageCode ?? this.languageCode),
      scaleType: scaleType ?? this.scaleType,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      autoCloudSync: autoCloudSync ?? this.autoCloudSync,
      authGatePassed: authGatePassed ?? this.authGatePassed,
    );
  }
}
