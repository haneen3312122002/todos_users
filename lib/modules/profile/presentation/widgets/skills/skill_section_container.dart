import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/modules/profile/presentation/providers/skill/skills_provider.dart';
import 'package:notes_tasks/modules/profile/presentation/viewmodels/skill/skills_form_viewmodel.dart';
import 'package:notes_tasks/modules/profile/presentation/widgets/skills/profile_skill_section.dart';

class SkillsSectionContainer extends ConsumerWidget {
  const SkillsSectionContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final profileSkills = ref.watch(skillsProvider);


    final asyncState = ref.watch(skillsFormViewModelProvider);
    final vm = ref.read(skillsFormViewModelProvider.notifier);

    final vmState = asyncState.value ?? const SkillsFormState();
    final isEditing = vmState.isEditing;
    final isSaving = asyncState.isLoading;



    final displayedSkills = isEditing ? vmState.skills : profileSkills;

    return ProfileSkillsSection(
      titleKey: 'skills_title',
      skills: displayedSkills,
      isEditing: isEditing,
      isSaving: isSaving,
      onEdit: () {
        vm.startEditing(profileSkills);
      },
      onCancel: () {
        vm.cancelEditing();
      },
      onSave: () => vm.saveSkills(context),
      onAddSkill: (text) {
        vm.addSkill(text);
      },
      onRemoveSkillAt: (index) {
        vm.removeSkillAt(index);
      },
    );
  }
}