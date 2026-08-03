import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../domain/entities/entities.dart';

/// Просмотр и корректировка данных, введённых в онбординге (ТЗ 4.1, 4.17).
class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  late UserProfile _p;
  final _weight = TextEditingController();
  final _height = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Профиль здесь всегда есть: экран доступен только из настроек.
    _p = ref.read(profileControllerProvider)!;
    _weight.text = _p.weightKg.toString();
    _height.text = _p.heightCm.toString();
  }

  @override
  void dispose() {
    _weight.dispose();
    _height.dispose();
    super.dispose();
  }

  void _save() {
    ref.read(profileControllerProvider.notifier).save(_p);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).savedSnack)),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dob = _p.dateOfBirth;
    final genderLabels = {
      Gender.male: l10n.genderMale,
      Gender.female: l10n.genderFemale,
      Gender.unspecified: l10n.genderUnspecified,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsProfile)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            16, 16, 16, 16 + MediaQuery.viewPaddingOf(context).bottom),
        children: [
          // Пол
          Text(l10n.onboardingStepGender,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final g in Gender.values)
                ChoiceChip(
                  label: Text(genderLabels[g]!),
                  selected: _p.gender == g,
                  onSelected: (_) => setState(() => _p = _p.copyWith(gender: g)),
                ),
            ],
          ),
          const SizedBox(height: 20),
          // Дата рождения
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldDateOfBirth),
            subtitle: Text('${dob.day.toString().padLeft(2, '0')}.'
                '${dob.month.toString().padLeft(2, '0')}.${dob.year}'),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: dob,
                firstDate: DateTime(now.year - 90),
                lastDate: DateTime(now.year - 10),
              );
              if (picked != null) {
                setState(() => _p = _p.copyWith(dateOfBirth: picked));
              }
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _weight,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldWeightKg,
              border: const OutlineInputBorder(),
            ),
            onChanged: (v) {
              final parsed = double.tryParse(v.replaceAll(',', '.'));
              if (parsed != null && parsed > 0) {
                _p = _p.copyWith(weightKg: parsed);
              }
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _height,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldHeightCm,
              border: const OutlineInputBorder(),
            ),
            onChanged: (v) {
              final parsed = double.tryParse(v.replaceAll(',', '.'));
              if (parsed != null && parsed > 0) {
                _p = _p.copyWith(heightCm: parsed);
              }
            },
          ),
          const SizedBox(height: 20),
          // Опыт
          Text(l10n.fieldExperience,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final e in TrainingExperience.values)
                ChoiceChip(
                  label: Text(context.tr(e.label)),
                  selected: _p.experience == e,
                  onSelected: (_) =>
                      setState(() => _p = _p.copyWith(experience: e)),
                ),
            ],
          ),
          const SizedBox(height: 20),
          // Цель
          Text(l10n.fieldGoal, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final g in TrainingGoal.values)
                ChoiceChip(
                  label: Text(context.tr(g.label)),
                  selected: _p.goal == g,
                  onSelected: (_) => setState(() => _p = _p.copyWith(goal: g)),
                ),
            ],
          ),
          const SizedBox(height: 20),
          // Оборудование
          Text(l10n.onboardingStepEquipment,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final e in Equipment.values)
                FilterChip(
                  label: Text(context.tr(e.label)),
                  selected: _p.equipment.contains(e),
                  onSelected: (_) {
                    final next = Set<Equipment>.from(_p.equipment);
                    next.contains(e) ? next.remove(e) : next.add(e);
                    setState(() => _p = _p.copyWith(equipment: next));
                  },
                ),
            ],
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _save,
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
