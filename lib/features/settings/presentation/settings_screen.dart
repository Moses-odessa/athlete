import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/repositories/results_repository.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../domain/entities/app_settings.dart';
import '../../../domain/entities/scale_type.dart';
import '../application/data_export.dart';
import '../application/data_transfer.dart';

/// Экран настроек (ТЗ разд. 4.17).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, 16 + MediaQuery.viewPaddingOf(context).bottom),
        children: [
          _Group(
            title: l10n.settingsUnits,
            child: SegmentedButton<UnitSystem>(
              segments: [
                ButtonSegment(
                    value: UnitSystem.metric, label: Text(l10n.unitsMetric)),
                ButtonSegment(
                    value: UnitSystem.imperial, label: Text(l10n.unitsImperial)),
              ],
              selected: {settings.units},
              onSelectionChanged: (s) => controller.setUnits(s.first),
            ),
          ),
          _Group(
            title: l10n.settingsTheme,
            child: SegmentedButton<AppThemeMode>(
              segments: [
                ButtonSegment(
                    value: AppThemeMode.system, label: Text(l10n.themeSystem)),
                ButtonSegment(
                    value: AppThemeMode.light, label: Text(l10n.themeLight)),
                ButtonSegment(
                    value: AppThemeMode.dark, label: Text(l10n.themeDark)),
              ],
              selected: {settings.themeMode},
              onSelectionChanged: (s) => controller.setThemeMode(s.first),
            ),
          ),
          _Group(
            title: l10n.settingsLanguage,
            child: DropdownButtonFormField<String?>(
              initialValue: settings.languageCode,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.languageSystem)),
                const DropdownMenuItem(value: 'ru', child: Text('Русский')),
                const DropdownMenuItem(value: 'en', child: Text('English')),
                const DropdownMenuItem(value: 'uk', child: Text('Українська')),
                const DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                const DropdownMenuItem(value: 'it', child: Text('Italiano')),
                const DropdownMenuItem(value: 'fr', child: Text('Français')),
              ],
              onChanged: controller.setLanguage,
            ),
          ),
          _Group(
            title: l10n.settingsScale,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SegmentedButton<ScaleType>(
                  segments: [
                    ButtonSegment(
                        value: ScaleType.linear, label: Text(l10n.scaleLinear)),
                    ButtonSegment(
                        value: ScaleType.nonlinear,
                        label: Text(l10n.scaleNonlinear)),
                  ],
                  selected: {settings.scaleType},
                  onSelectionChanged: (s) => controller.setScaleType(s.first),
                ),
                const SizedBox(height: 8),
                Text(l10n.scaleHint,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.settingsNotifications),
            value: settings.notificationsEnabled,
            onChanged: controller.setNotifications,
          ),
          const Divider(height: 32),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.cloud_sync),
            title: Text(l10n.cloudTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/cloud'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.emoji_events),
            title: Text(l10n.achievementsTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/achievements'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.school),
            title: Text(l10n.scienceTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/science'),
          ),
          const Divider(height: 32),
          Text(l10n.settingsData,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.ios_share),
            label: Text(l10n.exportData),
            onPressed: () => exportUserData(
              profile: ref.read(profileControllerProvider),
              results: ref.read(resultsControllerProvider),
              now: DateTime.now(),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.file_download),
            label: Text(l10n.importData),
            onPressed: () => _importData(context, ref),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: Icon(Icons.delete_forever,
                color: Theme.of(context).colorScheme.error),
            label: Text(l10n.deleteAccount,
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    ref.read(resultsControllerProvider.notifier).clear();
    ref.read(profileControllerProvider.notifier).clear();
    context.go('/onboarding');
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    final source = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.importData),
        content: TextField(
          controller: controller,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: l10n.importHint,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(l10n.importApply),
          ),
        ],
      ),
    );
    if (source == null || source.trim().isEmpty || !context.mounted) return;

    try {
      final data = decodeUserDataJson(source);
      ref.read(resultsControllerProvider.notifier).setAll(data.results);
      if (data.profile != null) {
        ref.read(profileControllerProvider.notifier).save(data.profile!);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.importSuccess)),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.importError)),
      );
    }
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
