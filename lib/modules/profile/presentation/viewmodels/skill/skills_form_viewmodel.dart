import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/modules/profile/domain/usecases/skill/set_skills_usecase.dart';


class SkillsFormState {
  final List<String> skills;
  final bool isEditing;

  const SkillsFormState({
    this.skills = const [],
    this.isEditing = false,
  });

  SkillsFormState copyWith({
    List<String>? skills,
    bool? isEditing,
  }) {
    return SkillsFormState(
      skills: skills ?? this.skills,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

final skillsFormViewModelProvider =
    AsyncNotifierProvider<SkillsFormViewModel, SkillsFormState>(
  SkillsFormViewModel.new,
);

class SkillsFormViewModel extends AsyncNotifier<SkillsFormState> {
  late final SetSkillsUseCase _setSkillsUseCase =
      ref.read(setSkillsUseCaseProvider);

  @override
  FutureOr<SkillsFormState> build() async {

    return const SkillsFormState();
  }


  void startEditing(List<String> initialSkills) {
    final cleaned =
        initialSkills.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    final current = state.value ?? const SkillsFormState();

    state = AsyncData(
      current.copyWith(
        skills: cleaned,
        isEditing: true,
      ),
    );
  }


  void cancelEditing() {
    final current = state.value ?? const SkillsFormState();
    state = AsyncData(
      current.copyWith(

        isEditing: false,
      ),
    );
  }

  void addSkill(String skill) {
    final text = skill.trim();
    if (text.isEmpty) return;

    final current = state.value ?? const SkillsFormState();
    final updated = [...current.skills, text];

    state = AsyncData(
      current.copyWith(skills: updated),
    );
  }

  void removeSkillAt(int index) {
    final current = state.value ?? const SkillsFormState();
    if (index < 0 || index >= current.skills.length) return;

    final updated = [...current.skills]..removeAt(index);

    state = AsyncData(
      current.copyWith(skills: updated),
    );
  }

  Future<void> saveSkills(BuildContext context) async {
    if (state.isLoading) return;

    final current = state.value ?? const SkillsFormState();

    final cleaned =
        current.skills.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    state = const AsyncLoading();
    try {
      await _setSkillsUseCase(cleaned);

      state = AsyncData(
        current.copyWith(
          skills: cleaned,
          isEditing: false, // نطلع من وضع التعديل بعد الحفظ
        ),
      );

      AppSnackbar.show(context, 'skills_updated_success'.tr());
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }
}