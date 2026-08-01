import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/profile_repository.dart';
import '../../features/achievements/presentation/achievements_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/education/presentation/science_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/tests/presentation/catalog_screen.dart';
import '../../features/tests/presentation/entry_screen.dart';
import '../../features/tests/presentation/reaction_screen.dart';

/// Роутер приложения. Пока профиль не заполнен — онбординг, иначе — дашборд
/// (ТЗ разд. 3, 4.1).
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _ProfileRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final hasProfile = ref.read(profileControllerProvider) != null;
      final atOnboarding = state.matchedLocation == '/onboarding';
      if (!hasProfile) return atOnboarding ? null : '/onboarding';
      if (atOnboarding) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => const DashboardScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(path: '/catalog', builder: (_, _) => const CatalogScreen()),
      GoRoute(path: '/history', builder: (_, _) => const HistoryScreen()),
      GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
      GoRoute(path: '/science', builder: (_, _) => const ScienceScreen()),
      GoRoute(path: '/reaction', builder: (_, _) => const ReactionScreen()),
      GoRoute(
          path: '/achievements',
          builder: (_, _) => const AchievementsScreen()),
      GoRoute(
        path: '/entry/:id',
        builder: (_, state) =>
            EntryScreen(exerciseId: state.pathParameters['id']!),
      ),
    ],
  );
});

/// Мостик Riverpod → Listenable: заставляет go_router пересчитать redirect
/// при изменении профиля.
class _ProfileRefresh extends ChangeNotifier {
  _ProfileRefresh(Ref ref) {
    _sub = ref.listen<Object?>(
      profileControllerProvider,
      (_, _) => notifyListeners(),
    );
  }

  late final ProviderSubscription _sub;

  @override
  void dispose() {
    _sub.close();
    super.dispose();
  }
}
