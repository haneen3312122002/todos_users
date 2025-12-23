import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';
import 'package:notes_tasks/modules/auth/domain/usecases/send_reset_password_email_usecase.dart';
import 'package:notes_tasks/modules/auth/domain/validators/auth_validators.dart';

final resetPasswordViewModelProvider =
    AsyncNotifierProvider<ResetPasswordViewModel, void>(
  ResetPasswordViewModel.new,
);

class ResetPasswordViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> sendResetEmail({
    required String email,
  }) async {
    if (state.isLoading) {
      return;
    }
    final validationKey = AuthValidators.validateEmail(email);
    if (validationKey != null) {
      state = AsyncError(
        AuthFailure(validationKey),
        StackTrace.empty, // ✅ لا نضلل الستاك تريس
      );
      return;
    }
    state = const AsyncLoading();
    final usecase = ref.read(sendResetPasswordEmailUseCaseProvider);
    try {
      await usecase(email: email.trim());
      state = const AsyncData(null);
    } on AuthFailure catch (e, st) {
      // ✅ Failure جاهز برسالة messageKey
      state = AsyncError(e, st);
    } catch (e, st) {
      // ✅ خطأ عام برسالة موحدة + stacktrace الصحيح
      state = AsyncError(const AuthFailure('something_went_wrong'), st);
    }
  }
}
