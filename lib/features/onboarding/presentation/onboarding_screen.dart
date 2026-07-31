import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/localized_text_ext.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../domain/entities/entities.dart';
import '../application/onboarding_controller.dart';

/// Многошаговый онбординг с PAR-Q (ТЗ разд. 4.1). Цель — пройти за ≤ 3 минуты
/// (критерий приёмки, ТЗ разд. 17).
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  int _step = 0;
  static const _stepCount = 6;

  @override
  void dispose() {
    _pageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _goTo(int step) {
    setState(() => _step = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  bool _canAdvance(OnboardingDraft d) {
    switch (_step) {
      case 0:
        return d.gender != null;
      case 1:
        return d.dateOfBirth != null &&
            (d.weightKg ?? 0) > 0 &&
            (d.heightCm ?? 0) > 0;
      case 2:
        return d.experience != null && d.goal != null;
      case 3:
        return true; // оборудование опционально
      case 4:
        return true; // PAR-Q: ответы по умолчанию «нет»
      case 5:
        return d.acceptedTerms;
      default:
        return false;
    }
  }

  String _stepTitle(AppLocalizations l10n) {
    switch (_step) {
      case 0:
        return l10n.onboardingStepGender;
      case 1:
        return l10n.onboardingStepBasics;
      case 2:
        return l10n.onboardingStepExperience;
      case 3:
        return l10n.onboardingStepEquipment;
      case 4:
        return l10n.onboardingStepHealth;
      default:
        return l10n.onboardingStepConsent;
    }
  }

  void _finish() {
    final controller = ref.read(onboardingControllerProvider.notifier);
    if (!controller.isComplete) return;
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    ref.read(profileControllerProvider.notifier).save(controller.buildProfile(id));
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final draft = ref.watch(onboardingControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_stepTitle(l10n)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: (_step + 1) / _stepCount),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _GenderStep(draft: draft),
          _BasicsStep(
            draft: draft,
            weightController: _weightController,
            heightController: _heightController,
          ),
          _ExperienceGoalStep(draft: draft),
          _EquipmentStep(draft: draft),
          _ParqStep(draft: draft),
          _ConsentStep(draft: draft),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (_step > 0)
                OutlinedButton(
                  onPressed: () => _goTo(_step - 1),
                  child: Text(l10n.back),
                ),
              const Spacer(),
              FilledButton(
                onPressed: _canAdvance(draft)
                    ? () {
                        if (_step == _stepCount - 1) {
                          _finish();
                        } else {
                          _goTo(_step + 1);
                        }
                      }
                    : null,
                child: Text(_step == _stepCount - 1 ? l10n.finish : l10n.next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepBody extends StatelessWidget {
  const _StepBody({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }
}

class _GenderStep extends ConsumerWidget {
  const _GenderStep({required this.draft});
  final OnboardingDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final labels = {
      Gender.male: l10n.genderMale,
      Gender.female: l10n.genderFemale,
      Gender.unspecified: l10n.genderUnspecified,
    };
    return _StepBody(
      child: RadioGroup<Gender>(
        groupValue: draft.gender,
        onChanged: (v) {
          if (v != null) controller.setGender(v);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final g in Gender.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RadioListTile<Gender>(
                  value: g,
                  title: Text(labels[g]!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BasicsStep extends ConsumerWidget {
  const _BasicsStep({
    required this.draft,
    required this.weightController,
    required this.heightController,
  });
  final OnboardingDraft draft;
  final TextEditingController weightController;
  final TextEditingController heightController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final dob = draft.dateOfBirth;
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fieldDateOfBirth),
            subtitle: Text(
              dob == null
                  ? '—'
                  : '${dob.day.toString().padLeft(2, '0')}.'
                      '${dob.month.toString().padLeft(2, '0')}.${dob.year}',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: dob ?? DateTime(now.year - 25),
                firstDate: DateTime(now.year - 90),
                lastDate: DateTime(now.year - 10),
              );
              if (picked != null) controller.setDateOfBirth(picked);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldWeightKg,
              border: const OutlineInputBorder(),
            ),
            onChanged: (v) {
              final parsed = double.tryParse(v.replaceAll(',', '.'));
              if (parsed != null) controller.setWeight(parsed);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.fieldHeightCm,
              border: const OutlineInputBorder(),
            ),
            onChanged: (v) {
              final parsed = double.tryParse(v.replaceAll(',', '.'));
              if (parsed != null) controller.setHeight(parsed);
            },
          ),
        ],
      ),
    );
  }
}

class _ExperienceGoalStep extends ConsumerWidget {
  const _ExperienceGoalStep({required this.draft});
  final OnboardingDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.fieldExperience,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final e in TrainingExperience.values)
                ChoiceChip(
                  label: Text(context.tr(e.label)),
                  selected: draft.experience == e,
                  onSelected: (_) => controller.setExperience(e),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(l10n.fieldGoal, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final g in TrainingGoal.values)
                ChoiceChip(
                  label: Text(context.tr(g.label)),
                  selected: draft.goal == g,
                  onSelected: (_) => controller.setGoal(g),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EquipmentStep extends ConsumerWidget {
  const _EquipmentStep({required this.draft});
  final OnboardingDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.equipmentHint),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final e in Equipment.values)
                FilterChip(
                  label: Text(context.tr(e.label)),
                  selected: draft.equipment.contains(e),
                  onSelected: (_) => controller.toggleEquipment(e),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ParqStep extends ConsumerWidget {
  const _ParqStep({required this.draft});
  final OnboardingDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.parqIntro),
          const SizedBox(height: 12),
          for (var i = 0; i < ParqQuestionnaire.questionCount; i++)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr(ParqQuestionnaire.questions[i])),
                    const SizedBox(height: 8),
                    SegmentedButton<bool>(
                      segments: [
                        ButtonSegment(value: false, label: Text(l10n.parqAnswerNo)),
                        ButtonSegment(value: true, label: Text(l10n.parqAnswerYes)),
                      ],
                      selected: {draft.parqAnswers[i]},
                      onSelectionChanged: (s) =>
                          controller.setParqAnswer(i, s.first),
                    ),
                  ],
                ),
              ),
            ),
          if (draft.parq.hasPositiveAnswer)
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber),
                    const SizedBox(width: 8),
                    Expanded(child: Text(l10n.parqWarning)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ConsentStep extends ConsumerWidget {
  const _ConsentStep({required this.draft});
  final OnboardingDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: draft.acceptedTerms,
            title: Text(l10n.consentText),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (v) => controller.setAcceptedTerms(v ?? false),
          ),
          if (!draft.acceptedTerms)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l10n.consentRequired,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          const SizedBox(height: 24),
          Text(
            l10n.medicalDisclaimer,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
