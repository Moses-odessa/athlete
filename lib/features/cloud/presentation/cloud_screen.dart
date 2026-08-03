import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../data/repositories/settings_repository.dart';
import '../application/cloud_controller.dart';

/// Что делать при входе, если в облаке уже есть данные (#2).
enum _MergeChoice { keepCloud, keepLocal, merge }

/// Экран облачного аккаунта: вход/регистрация, автоматический мультидевайс-синк,
/// объединение данных при входе (ТЗ 4.17, M2). Ручной синхронизации нет.
class CloudScreen extends ConsumerStatefulWidget {
  const CloudScreen({super.key});

  @override
  ConsumerState<CloudScreen> createState() => _CloudScreenState();
}

class _CloudScreenState extends ConsumerState<CloudScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _snack(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  CloudController get _controller => ref.read(cloudControllerProvider.notifier);
  AppLocalizations get _l10n => AppLocalizations.of(context);

  Future<void> _submit({required bool signUp}) async {
    final outcome = signUp
        ? await _controller.signUp(_email.text.trim(), _password.text)
        : await _controller.signIn(_email.text.trim(), _password.text);
    if (!mounted) return;
    if (!outcome.ok) {
      _snack(outcome.error ?? _l10n.cloudError);
      return;
    }
    // Аутентификация пройдена → welcome-гейт больше не показываем.
    ref.read(settingsControllerProvider.notifier).setAuthGatePassed(true);
    // Предложить менеджеру паролей ОС сохранить учётные данные (#3).
    TextInput.finishAutofillContext();
    if (outcome.cloudHasData) {
      await _reconcile();
    } else {
      // Новый аккаунт: выгружаем локальные данные в облако (#2).
      final ok = await _controller.backup();
      _snack(ok ? _l10n.cloudBackupDone : _error);
    }
    if (mounted) context.go('/');
  }

  /// Вход в существующий аккаунт с данными: выбрать, какие данные оставить (#2).
  Future<void> _reconcile() async {
    final l10n = _l10n;
    final choice = await showDialog<_MergeChoice>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.cloudFoundTitle),
        content: Text(l10n.cloudFoundBody),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(_MergeChoice.keepCloud),
            child: Text(l10n.cloudRestore),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(_MergeChoice.keepLocal),
            child: Text(l10n.cloudKeepLocal),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(_MergeChoice.merge),
            child: Text(l10n.cloudMerge),
          ),
        ],
      ),
    );
    if (choice == null || !mounted) return;
    final (ok, msg) = switch (choice) {
      _MergeChoice.keepCloud => (
          await _controller.restore(),
          l10n.cloudRestoreDone
        ),
      _MergeChoice.keepLocal => (
          await _controller.backup(),
          l10n.cloudBackupDone
        ),
      _MergeChoice.merge => (await _controller.merge(), l10n.cloudMergeDone),
    };
    _snack(ok ? msg : _error);
  }

  String get _error =>
      ref.read(cloudControllerProvider).errorText ?? _l10n.cloudError;

  @override
  Widget build(BuildContext context) {
    final l10n = _l10n;
    final state = ref.watch(cloudControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cloudTitle)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, 16 + MediaQuery.viewPaddingOf(context).bottom),
        children: [
          if (!state.configured)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l10n.cloudNotConfigured),
              ),
            )
          else if (!state.signedIn)
            _signInForm(state)
          else
            _signedInView(state),
          if (state.busy)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _signInForm(CloudState state) {
    final l10n = _l10n;
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.cloudSignInPrompt),
          const SizedBox(height: 16),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.username, AutofillHints.email],
            decoration: InputDecoration(
              labelText: l10n.fieldEmail,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _password,
            obscureText: true,
            autofillHints: const [AutofillHints.password],
            decoration: InputDecoration(
              labelText: l10n.fieldPassword,
              border: const OutlineInputBorder(),
            ),
          ),
          if (state.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(state.errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: state.busy ? null : () => _submit(signUp: false),
                  child: Text(l10n.signIn),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: state.busy ? null : () => _submit(signUp: true),
                  child: Text(l10n.signUp),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(l10n.cloudAutoSyncStatus,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _signedInView(CloudState state) {
    final l10n = _l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.account_circle),
          title: Text(l10n.cloudSignedInAs),
          subtitle: Text(state.email!),
          trailing: TextButton(
            onPressed: state.busy ? null : _controller.signOut,
            child: Text(l10n.signOut),
          ),
        ),
        const Divider(),
        Row(
          children: [
            Icon(Icons.cloud_done,
                size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(l10n.cloudAutoSyncStatus,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ],
    );
  }
}
