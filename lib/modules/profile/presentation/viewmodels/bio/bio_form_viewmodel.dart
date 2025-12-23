import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/modules/profile/domain/usecases/bio/set_bio_usecase.dart';

final bioFormViewModelProvider =
    AsyncNotifierProvider<BioFormViewModel, String?>(
  BioFormViewModel.new,
);

class BioFormViewModel extends AsyncNotifier<String?> {
  late final SetBioUseCase _setBioUseCase = ref.read(setBioUseCaseProvider);

  @override
  FutureOr<String?> build() async {
    return null;
  }

  void init(String? initialBio) {
    final current = state.value;
    if (current == null) {
      state = AsyncData(
        initialBio?.trim(),
      );
    }
  }

  void onChanged(String value) {
    state = AsyncData(value);
  }

  Future<void> saveBio(BuildContext context) async {
    if (state.isLoading) return;

    final current = state.value?.trim();

    final valueToSave = (current != null && current.isEmpty) ? null : current;

    state = const AsyncLoading();
    try {
      await _setBioUseCase(valueToSave);
      state = AsyncData(valueToSave);

      AppSnackbar.show(context, 'bio_updated_success'.tr());
    } catch (e, st) {
      state = AsyncError(e, st);
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
    }
  }
}