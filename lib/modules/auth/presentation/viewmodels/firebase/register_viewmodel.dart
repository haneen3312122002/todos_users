import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';
import 'package:notes_tasks/modules/auth/domain/usecases/register_usecase.dart';

final registerViewModelProvider =
    AsyncNotifierProvider<RegisterViewModel, void>(
  RegisterViewModel.new,
);

class RegisterViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    if (state.isLoading) return;

    state = const AsyncLoading();

    try {
      final registerUseCase = ref.read(firebaseRegisterUseCaseProvider);
      await registerUseCase(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      // ✅ نجاح العملية (بدون fb.User)
      state = const AsyncData(null);
    } on AuthFailure catch (f, st) {
      // ✅ Failure موحد جاهز للـUI
      state = AsyncError(f, st);
    } catch (e, st) {
      // ✅ أي خطأ غير متوقع يتحول لرسالة عامة
      state = AsyncError(const AuthFailure('something_went_wrong'), st);
    }
  }
}
