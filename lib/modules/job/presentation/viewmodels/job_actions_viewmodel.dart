import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/modules/job/domain/entities/job_entity.dart';
import 'package:notes_tasks/modules/job/presentation/providers/job_usecases_providers.dart';

final jobActionsViewModelProvider =
    AsyncNotifierProvider<JobActionsViewModel, void>(JobActionsViewModel.new);

class JobActionsViewModel extends AsyncNotifier<void> {
  late final _delete = ref.read(deleteJobUseCaseProvider);
  late final _update = ref.read(updateJobUseCaseProvider);

  @override
  FutureOr<void> build() {}

  Future<void> deleteJob(BuildContext context, String jobId) async {
    state = const AsyncLoading();
    try {
      await _delete(jobId);
      AppSnackbar.show(context, 'job_deleted_success'.tr());
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }

  Future<void> setOpen(BuildContext context, JobEntity job, bool open) async {
    state = const AsyncLoading();
    try {
      await _update(
        id: job.id,
        title: job.title,
        description: job.description,
        skills: job.skills,
        imageUrl: job.imageUrl,
        jobUrl: job.jobUrl,
        budget: job.budget,
        deadline: job.deadline,
        isOpen: open,
        category: job.category, // ✅ مهم
      );

      AppSnackbar.show(
        context,
        open ? 'job_opened_success'.tr() : 'job_closed_success'.tr(),
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }
}
