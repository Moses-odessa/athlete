import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../data/repositories/settings_repository.dart';
import '../application/cloud_controller.dart';

/// Экран облачной синхронизации: аккаунт, автосинк, реконсиляция (ТЗ 4.17, M2).
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
    // Предложить менеджеру паролей ОС сохранить учётные данные (#3).
    TextInput.finishAutofillContext();
    if (outcome.cloudHasData) {
      await _reconcile();
    } else {
      final ok = await _controller.backup();
      _snack(ok ? _l10n.cloudBackupDone : _error);
    }
  }

  /// Первый вход: в облаке есть данные — загрузить или заменить локальными (#2).
  Future<void> _reconcile() async {
    final download = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_l10n.cloudFoundTitle),
        content: Text(_l10n.cloudFoundBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(_l10n.cloudKeepLocal),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(_l10n.cloudRestore),
          ),
        ],
      ),
    );
    if (download == null || !mounted) return;

    if (download) {
      final ok = await _controller.restore();
      _snack(ok ? _l10n.cloudRestoreDone : _error);
      return;
    }
    // Оставить локальные → предупредить, что облако будет заменено.
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_l10n.cloudOverwriteTitle),
        content: Text(_l10n.cloudOverwriteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(_l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(_l10n.cloudReplace),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      final ok = await _controller.backup();
      _snack(ok ? _l10n.cloudBackupDone : _error);
    }
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
            _signedInView(),
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
          Text(l10n.cloudSingleDeviceHint,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _signedInView() {
    final l10n = _l10n;
    final state = ref.watch(cloudControllerProvider);
    final autoSync = ref.watch(settingsControllerProvider).autoCloudSync;

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
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.cloudAutoSync),
          value: autoSync,
          onChanged: (v) =>
              ref.read(settingsControllerProvider.notifier).setAutoCloudSync(v),
        ),
        const Divider(),
        Text(l10n.cloudBackupHint,
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        FilledButton.icon(
          icon: const Icon(Icons.cloud_upload),
          label: Text(l10n.cloudBackup),
          onPressed: state.busy
              ? null
              : () async {
                  final ok = await _controller.backup();
                  _snack(ok ? l10n.cloudBackupDone : _error);
                },
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          icon: const Icon(Icons.cloud_download),
          label: Text(l10n.cloudRestore),
          onPressed: state.busy
              ? null
              : () async {
                  final ok = await _controller.restore();
                  _snack(ok ? l10n.cloudRestoreDone : _error);
                },
        ),
        const SizedBox(height: 16),
        Text(l10n.cloudSingleDeviceHint,
            style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
