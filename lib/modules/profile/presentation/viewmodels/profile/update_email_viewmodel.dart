import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/modules/profile/domain/usecases/profile/update_email_usecase.dart';

final updateEmailViewModelProvider =
    AsyncNotifierProvider<UpdateEmailViewModel, String?>(
  UpdateEmailViewModel.new,
);

class UpdateEmailViewModel extends AsyncNotifier<String?> {
  late final UpdateEmailUseCase _updateEmailUseCase =
      ref.read(updateEmailUseCaseProvider);

  @override
  FutureOr<String?> build() async => null;

  Future<void> submit(BuildContext context, {required String rawEmail}) async {
    if (state.isLoading) return;

    final email = rawEmail.trim();
    if (email.isEmpty) {
      AppSnackbar.show(context, 'please_enter_email'.tr());
      return;
    }

    FocusScope.of(context).unfocus();
    state = const AsyncLoading();

    try {
      await _updateEmailUseCase(email);
      state = AsyncData(email);
      AppSnackbar.show(context, 'email_updated'.tr());
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }
}