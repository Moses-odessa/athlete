import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../application/cloud_controller.dart';

/// Экран облачной синхронизации: аккаунт + бэкап/восстановление (ТЗ 4.17, M2).
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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(cloudControllerProvider);
    final controller = ref.read(cloudControllerProvider.notifier);

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
          else if (!state.signedIn) ...[
            Text(l10n.cloudSignInPrompt),
            const SizedBox(height: 16),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(
                labelText: l10n.fieldEmail,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.fieldPassword,
                border: const OutlineInputBorder(),
              ),
            ),
            if (state.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(state.errorText!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error)),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: state.busy
                        ? null
                        : () async {
                            final ok = await controller.signIn(
                                _email.text.trim(), _password.text);
                            _snack(ok
                                ? l10n.cloudSignedIn
                                : (ref.read(cloudControllerProvider).errorText ??
                                    l10n.cloudError));
                          },
                    child: Text(l10n.signIn),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: state.busy
                        ? null
                        : () async {
                            final ok = await controller.signUp(
                                _email.text.trim(), _password.text);
                            _snack(ok
                                ? l10n.cloudSignedIn
                                : (ref.read(cloudControllerProvider).errorText ??
                                    l10n.cloudError));
                          },
                    child: Text(l10n.signUp),
                  ),
                ),
              ],
            ),
          ] else ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.account_circle),
              title: Text(l10n.cloudSignedInAs),
              subtitle: Text(state.email!),
              trailing: TextButton(
                onPressed: state.busy ? null : controller.signOut,
                child: Text(l10n.signOut),
              ),
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
                      final ok = await controller.backup();
                      _snack(ok
                          ? l10n.cloudBackupDone
                          : (ref.read(cloudControllerProvider).errorText ??
                              l10n.cloudError));
                    },
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.cloud_download),
              label: Text(l10n.cloudRestore),
              onPressed: state.busy
                  ? null
                  : () async {
                      final ok = await controller.restore();
                      _snack(ok
                          ? l10n.cloudRestoreDone
                          : (ref.read(cloudControllerProvider).errorText ??
                              l10n.cloudError));
                    },
            ),
          ],
          if (state.busy)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
