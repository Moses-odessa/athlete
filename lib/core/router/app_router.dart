import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../features/achievements/presentation/achievements_screen.dart';
import '../../features/cloud/application/cloud_controller.dart';
import '../../features/cloud/presentation/cloud_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/dashboard/presentation/share_radar_screen.dart';
import '../../features/education/presentation/science_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/welcome_screen.dart';
import '../../features/peers/presentation/peers_screen.dart';
import '../../features/recommendations/presentation/recommendations_screen.dart';
import '../../features/recommendations/presentation/weekly_plan_screen.dart';
import '../../features/settings/presentation/profile_edit_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/tests/presentation/batteries_screen.dart';
import '../../features/tests/presentation/battery_runner_screen.dart';
import '../../features/tests/presentation/catalog_screen.dart';
import '../../features/tests/presentation/entry_screen.dart';
import '../../features/tests/presentation/reaction_screen.dart';

/// Роутер приложения. Пока профиль не заполнен — онбординг, иначе — дашборд
/// (ТЗ разд. 3, 4.1).
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _AuthGateRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final hasProfile = ref.read(profileControllerProvider) != null;
      final signedIn = ref.read(cloudControllerProvider).signedIn;
      final gatePassed =
          ref.read(settingsControllerProvider).authGatePassed;
      final loc = state.matchedLocation;

      // 1. Welcome-гейт: новый пользователь, ещё не выбрал вход/без аккаунта.
      if (!gatePassed && !hasProfile && !signedIn) {
        return loc == '/welcome' ? null : '/welcome';
      }
      // 2. Нет профиля → онбординг, но разрешаем экран входа (/cloud).
      if (!hasProfile) {
        if (loc == '/welcome') return '/onboarding';
        if (loc == '/onboarding' || loc == '/cloud') return null;
        return '/onboarding';
      }
      // 3. Профиль есть — welcome/онбординг больше не нужны.
      if (loc == '/welcome' || loc == '/onboarding') return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => const DashboardScreen()),
      GoRoute(path: '/welcome', builder: (_, _) => const WelcomeScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(path: '/catalog', builder: (_, _) => const CatalogScreen()),
      GoRoute(path: '/history', builder: (_, _) => const HistoryScreen()),
      GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
      GoRoute(
          path: '/profile-edit',
          builder: (_, _) => const ProfileEditScreen()),
      GoRoute(path: '/cloud', builder: (_, _) => const CloudScreen()),
      GoRoute(path: '/science', builder: (_, _) => const ScienceScreen()),
      GoRoute(path: '/reaction', builder: (_, _) => const ReactionScreen()),
      GoRoute(
          path: '/achievements',
          builder: (_, _) => const AchievementsScreen()),
      GoRoute(path: '/peers', builder: (_, _) => const PeersScreen()),
      GoRoute(
        path: '/improve/:slug',
        builder: (_, state) =>
            RecommendationsScreen(categorySlug: state.pathParameters['slug']!),
      ),
      GoRoute(path: '/plan', builder: (_, _) => const WeeklyPlanScreen()),
      GoRoute(
          path: '/share-radar', builder: (_, _) => const ShareRadarScreen()),
      GoRoute(path: '/batteries', builder: (_, _) => const BatteriesScreen()),
      GoRoute(
        path: '/battery/:id',
        builder: (_, state) =>
            BatteryRunnerScreen(batteryId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/entry/:id',
        builder: (_, state) =>
            EntryScreen(exerciseId: state.pathParameters['id']!),
      ),
    ],
  );
});

/// Мостик Riverpod → Listenable: пересчитывает redirect при изменении профиля,
/// состояния входа в облако и флага прохождения welcome-гейта.
class _AuthGateRefresh extends ChangeNotifier {
  _AuthGateRefresh(Ref ref) {
    _subs = [
      ref.listen<Object?>(
          profileControllerProvider, (_, _) => notifyListeners()),
      ref.listen<Object?>(
          cloudControllerProvider, (_, _) => notifyListeners()),
      ref.listen<Object?>(
          settingsControllerProvider, (_, _) => notifyListeners()),
    ];
  }

  late final List<ProviderSubscription> _subs;

  @override
  void dispose() {
    for (final s in _subs) {
      s.close();
    }
    super.dispose();
  }
}
