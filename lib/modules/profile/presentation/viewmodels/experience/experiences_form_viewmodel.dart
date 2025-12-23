import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';

import 'package:notes_tasks/modules/profile/domain/usecases/experience/add_experience_usecase.dart';
import 'package:notes_tasks/modules/profile/domain/usecases/experience/update_experience_usecase.dart';
import 'package:notes_tasks/modules/profile/domain/usecases/experience/delete_experience_usecase.dart'; // 👈 الجديد

final experienceFormViewModelProvider =
    AsyncNotifierProvider<ExperienceFormViewModel, void>(
  ExperienceFormViewModel.new,
);

class ExperienceFormViewModel extends AsyncNotifier<void> {
  late final AddExperienceUseCase _addExperienceUseCase =
      ref.read(addExperienceUseCaseProvider);
  late final UpdateExperienceUseCase _updateExperienceUseCase =
      ref.read(updateExperienceUseCaseProvider);
  late final DeleteExperienceUseCase _deleteExperienceUseCase =
      ref.read(deleteExperienceUseCaseProvider); // 👈 الجديد

  @override
  FutureOr<void> build() async {}

  Future<void> addExperience(
    BuildContext context, {
    required String title,
    required String company,
    DateTime? startDate,
    DateTime? endDate,
    required String location,
    required String description,
  }) async {
    if (state.isLoading) return;

    if (title.trim().isEmpty || company.trim().isEmpty) {
      AppSnackbar.show(context, 'experience_form_missing_fields'.tr());
      return;
    }

    state = const AsyncLoading();
    try {
      await _addExperienceUseCase(
        title: title.trim(),
        company: company.trim(),
        startDate: startDate,
        endDate: endDate,
        location: location.trim(),
        description: description.trim(),
      );
      state = const AsyncData(null);
      AppSnackbar.show(context, 'experience_added_success'.tr());
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }

  Future<void> updateExperience(
    BuildContext context, {
    required String id,
    required String title,
    required String company,
    DateTime? startDate,
    DateTime? endDate,
    required String location,
    required String description,
  }) async {
    if (state.isLoading) return;

    if (title.trim().isEmpty || company.trim().isEmpty) {
      AppSnackbar.show(context, 'experience_form_missing_fields'.tr());
      return;
    }

    state = const AsyncLoading();
    try {
      await _updateExperienceUseCase(
        id: id,
        title: title.trim(),
        company: company.trim(),
        startDate: startDate,
        endDate: endDate,
        location: location.trim(),
        description: description.trim(),
      );
      state = const AsyncData(null);
      AppSnackbar.show(context, 'experience_updated_success'.tr());
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }

  Future<void> deleteExperience(
    BuildContext context, {
    required String id,
  }) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      await _deleteExperienceUseCase(id);
      state = const AsyncData(null);
      AppSnackbar.show(context, 'experience_deleted_success'.tr());
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }
}