import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/models/batteries_seed.dart';

/// Список тест-баттерей (ТЗ разд. 4.13).
class BatteriesScreen extends StatelessWidget {
  const BatteriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.batteriesTitle)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            8, 8, 8, 8 + MediaQuery.viewPaddingOf(context).bottom),
        children: [
          for (final b in kBatteries)
            Card(
              child: ListTile(
                leading: const Icon(Icons.fitness_center),
                title: Text(context.tr(b.name)),
                subtitle: Text(context.tr(b.description)),
                trailing: Text('${b.exerciseIds.length}'),
                onTap: () => context.push('/battery/${b.id}'),
              ),
            ),
        ],
      ),
    );
  }
}
