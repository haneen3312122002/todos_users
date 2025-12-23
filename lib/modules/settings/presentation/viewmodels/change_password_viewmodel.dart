import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/modules/auth/domain/usecases/change_password_usecase.dart';

final changePasswordViewModelProvider =
    AsyncNotifierProvider<ChangePasswordViewModel, void>(
  ChangePasswordViewModel.new,
);

class ChangePasswordViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> submit({
    required BuildContext context,
    required String currentPassword,
  }) async {
    if (state.isLoading) return;

    final trimmed = currentPassword.trim();
    if (trimmed.isEmpty) {
      AppSnackbar.show(context, 'please_enter_current_password'.tr());
      return;
    }

    state = const AsyncLoading();
    final usecase = ref.read(changePasswordUseCaseProvider);

    try {
      await usecase(currentPassword: trimmed);
      state = const AsyncData(null);

      AppSnackbar.show(context, 'password_reset_link_sent'.tr());
    } on Autocomplete catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(context, e.toString());
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(context, 'something_went_wrong'.tr());
    }
  }
}
