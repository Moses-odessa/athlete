import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../data/repositories/settings_repository.dart';

/// Стартовый экран выбора: войти / зарегистрироваться / продолжить без аккаунта
/// (ТЗ M2, #2). Показывается новому пользователю до онбординга — если аккаунт
/// уже есть, онбординг не нужен: данные подтянутся из облака.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  void _pass(WidgetRef ref) =>
      ref.read(settingsControllerProvider.notifier).setAuthGatePassed(true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.radar, size: 96, color: scheme.primary),
              const SizedBox(height: 24),
              Text(
                l10n.appTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.welcomeBody,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  _pass(ref);
                  context.go('/cloud');
                },
                child: Text(l10n.welcomeAuth),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  _pass(ref);
                  context.go('/');
                },
                child: Text(l10n.welcomeContinue),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
