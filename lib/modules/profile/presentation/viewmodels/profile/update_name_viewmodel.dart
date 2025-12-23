import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/modules/profile/domain/usecases/profile/update_name_usecase.dart';

final updateNameViewModelProvider =
    AsyncNotifierProvider<UpdateNameViewModel, String?>(
  UpdateNameViewModel.new,
);

class UpdateNameViewModel extends AsyncNotifier<String?> {
  late final UpdateNameUseCase _updateNameUseCase =
      ref.read(updateNameUseCaseProvider);

  @override
  FutureOr<String?> build() async => null;

  Future<void> submit(BuildContext context, {required String rawName}) async {
    if (state.isLoading) return;

    final name = rawName.trim();
    if (name.isEmpty) {
      AppSnackbar.show(context, 'please_enter_name'.tr());
      return;
    }

    FocusScope.of(context).unfocus();
    state = const AsyncLoading();

    try {
      await _updateNameUseCase(name);
      state = AsyncData(name);
      AppSnackbar.show(context, 'name_updated'.tr());
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }
}