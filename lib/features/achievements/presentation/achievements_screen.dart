import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../application/achievements.dart';

/// Экран достижений/бейджей (ТЗ разд. 4.14).
class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(achievementsProvider);
    final unlocked = items.where((a) => a.unlocked).length;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.achievementsTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.emoji_events),
                const SizedBox(width: 8),
                Text('${l10n.achievementsUnlocked}: $unlocked / ${items.length}',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                  16, 0, 16, MediaQuery.viewPaddingOf(context).bottom),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final a = items[i];
                final scheme = Theme.of(context).colorScheme;
                return Card(
                  color: a.unlocked ? scheme.secondaryContainer : null,
                  child: ListTile(
                    leading: Icon(
                      a.unlocked ? Icons.emoji_events : Icons.lock_outline,
                      color: a.unlocked ? scheme.primary : scheme.outline,
                    ),
                    title: Text(context.tr(a.title)),
                    subtitle: Text(context.tr(a.description)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
