# AGENT.md — рабочие заметки по проекту

Контекст-хендофф для ассистента/разработчика. Кратко: что за проект, как
собирать, что настроено, где грабли. Подробности продукта — в
[ТЗ](ТЗ_Тренируйся_как_атлет_v2.md) и [README](README.md).

## Что это
Flutter-приложение «Тренируйся как атлет»: оценка разносторонней физподготовки —
Индекс атлета (0–100), радар 8 качеств, тесты с нормировкой по полу/возрасту.
Реализован весь функционал ТЗ (MVP + M2 + часть M3).

## Среда разработки (Windows)
- **Flutter SDK: `C:\src\flutter`**, канал **beta** (3.47.x / Dart 3.13.x),
  добавлен в PATH. На beta перешли ради `sentry_flutter 9.26` (на stable 3.44
  он не собирался). CI тоже на beta (env FLUTTER_VERSION/FLUTTER_CHANNEL).
  В PowerShell перед командами: `$env:PATH="$env:PATH;C:\src\flutter\bin"`.
- **git через schannel** (`git config --global http.sslBackend schannel`) — иначе
  SSL-ошибки за TLS-инспектирующим прокси.
- ⚠️ **Локально нельзя собрать APK/AAB**: Java-обёртка Gradle не скачивает
  дистрибутив через прокси (`PKIX/SSL`). Android/iOS сборки — только на GitHub CI.
  Локально доступны: `flutter analyze`, `flutter test`, `flutter build web`,
  `flutter gen-l10n`, `dart run build_runner build`.

## Команды
```bash
flutter pub get
dart run build_runner build   # кодоген Drift (app_database.g.dart)
flutter gen-l10n              # локализации из ARB → lib/core/l10n/
flutter analyze
flutter test                  # 97 тестов; scoring покрытие 100%
```

## Архитектура
Feature-first + clean layering (ТЗ разд. 10): `lib/core`, `lib/data`,
`lib/domain`, `lib/features`. Состояние — **Riverpod**, роутинг — **go_router**
(`lib/core/router/app_router.dart`), БД — **Drift**
(`lib/data/local/app_database.dart`), графики — fl_chart, PDF — pdf/printing.
Инвариант: `lib/domain/scoring` — чистые функции, без Flutter/БД, тесты ≥90%.

## Ключевые доменные правила
- **Скоринг силовых по весу тела на момент выполнения**: `TestResult.bodyweightKg`
  (снимок при сохранении). Везде брать `result.bodyweightKg ?? profile.weightKg`.
  Рост в скоринге НЕ участвует. См. `summarizeResults` в
  `lib/features/dashboard/application/athlete_summary.dart`.
- **Нормативы/коэффициенты** помечены `TODO(calibration)` — предварительные.
- **Peer comparison** — модель нормального распределения (`TODO(data)`), до бэкенда.

## Локализация
- ARB в `lib/core/l10n/arb/`: en (шаблон), ru, uk, de, it, fr — весь UI (~150 ключей).
- Доменный контент (названия тестов, инфо-модалки, «Научная база»,
  рекомендации) — `LocalizedText{ru,en}` в Dart; для uk/de/it/fr **фолбэк на en**.
  Полный перевод контента — отдельный этап (расширить LocalizedText до locale-map).
- Переводы uk/de/it/fr машинные — вычитать носителю перед релизом.

## CI (GitHub Actions, репо Moses-odessa/athlete, public)
- `ci.yml` — на каждый push/PR: кодоген → analyze → test+coverage → гейт
  scoring ≥90% → build web. Ветки `master` и `main`.
- `test-apk.yml` (ручной) — release-APK с debug-подписью (устанавливаемый тест).
- `release-apk.yml` (ручной) — подписанный APK; нужны секреты keystore.
- `build-ios.yml` (ручной, macOS) — неподписанная iOS-сборка (проверка компиляции).
- **Секреты репозитория**: `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SENTRY_DSN`
  (+ для release-apk: `ANDROID_KEYSTORE_BASE64`, `ANDROID_STORE_PASSWORD`,
  `ANDROID_KEY_PASSWORD`, `ANDROID_KEY_ALIAS`). Пробрасываются в сборки через
  `--dart-define`. Публиковать/пушить — через GitHub Desktop.

## Внешние сервисы
- **Supabase** (облачный бэкап/аккаунты): URL `https://yueustqvqmanevrvrkbv.supabase.co`,
  publishable key через `--dart-define=SUPABASE_URL/SUPABASE_ANON_KEY`. Инициализация
  `lib/core/supabase/supabase_config.dart`; без ключей — offline. Модель — снимок
  JSONB на пользователя (`CloudSync`/`SupabaseCloudSync`), схема+RLS в
  `supabase/schema.sql`. **Важно**: выполнить schema.sql (вкл. `GRANT ... TO
  authenticated`), и выключить Confirm email в Auth для теста.
- **Sentry**: `sentry_flutter`, DSN через `--dart-define=SENTRY_DSN`; init в
  `main.dart`, `sendDefaultPii=false`, `tracesSampleRate=0`.
- **PostHog** (аналитика, ТЗ 14): фасад `AnalyticsService`
  (`lib/core/analytics/analytics.dart`), сейчас LoggingAnalytics; реальная
  реализация + ключ — когда понадобится.

## Android-сборка: грабли
- Основной манифест содержит `INTERNET` (нужно для release, Flutter добавляет его
  только в debug/profile).
- `ndkVersion = "28.2.13676358"` (плагины требуют; см. app/build.gradle.kts).
- Подпись релиза — из `android/key.properties` (не в git), иначе debug-ключ.
- **Sentry**: на beta (`sentry_flutter 9.26`) собирается без хаков —
  `android/build.gradle.kts` и `app/build.gradle.kts` чистые (дефолтные
  compileSdk/ndk из Flutter). На stable 3.44 не собирался (Kotlin 1.6).

## Что вне репозитория / на будущее
- Полный перевод доменного контента на uk/de/it/fr.
- Реальный PostHog/Sentry-дашборд (ключи у владельца).
- Нормализованные таблицы Supabase + лидерборд когорты (сейчас — бэкап-снимок).
- Иконка приложения/сплэш (сейчас дефолтные Flutter).
- M4: видео-верификация, кабинет тренера, Apple Health/Google Fit.
