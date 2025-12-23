import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';
import 'package:notes_tasks/modules/auth/domain/mappers/auth_failure_mapper.dart';
import 'package:notes_tasks/modules/auth/domain/usecases/login_usecase.dart';
import 'package:notes_tasks/modules/auth/domain/usecases/logout_usecase.dart';

final firebaseLoginVMProvider =
    AsyncNotifierProvider<FirebaseLoginViewModel, void>(
  //-> the state is result not data
  //success: asyncvaldata=null / error:asyncerror()
  FirebaseLoginViewModel.new,
  name: 'FirebaseLoginVM',
);

class FirebaseLoginViewModel extends AsyncNotifier<void> {
  //only turn on login / logout
  @override
  FutureOr<void> build() async {
    //first operation: no data / user
    return;
  }

  Future<void> login({required String email, required String password}) async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    try {
      final loginUseCase = ref.read(firebaseLoginUseCaseProvider);
      await loginUseCase(email: email, password: password);
      state = AsyncData(null); //login success , no need to get the user data
    } on fb.FirebaseAuthException catch (e, st) {
      final failure = mapFirebaseAuthExceptionToFailure(e);
      state = AsyncError(failure, st);
    } catch (e, st) {
      state = AsyncError(const AuthFailure('something_went_wrong'), st);
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      final logoutUseCase = ref.read(logoutUseCaseProvider);
      await logoutUseCase();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(const AuthFailure('something_went_wrong'), st);
    }
  }
}
