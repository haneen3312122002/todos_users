import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'package:notes_tasks/core/data/remote/firebase/providers/firebase_providers.dart';
import 'package:notes_tasks/core/features/auth/services/auth_service.dart';
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';
import 'package:notes_tasks/modules/auth/domain/mappers/auth_failure_mapper.dart';
import 'package:notes_tasks/modules/auth/domain/validators/auth_validators.dart';

final firebaseLoginUseCaseProvider = Provider<FirebaseLoginUseCase>((ref) {
  final authService = ref.read(authServiceProvider);
  return FirebaseLoginUseCase(authService);
});

class FirebaseLoginUseCase {
  final AuthService _authService;
  FirebaseLoginUseCase(this._authService);

  Future<void> call({
    required String email,
    required String password,
  }) async {
    final emailKey = AuthValidators.validateEmail(email);
    if (emailKey != null) throw AuthFailure(emailKey);

    final passKey = AuthValidators.validatePassword(password);
    if (passKey != null) throw AuthFailure(passKey);

    try {
      await _authService
          .login(email: email.trim(), password: password.trim())
          .timeout(const Duration(seconds: 20));

      // ✅ نجاح = void
      return;
    } on fb.FirebaseAuthException catch (e) {
      throw mapFirebaseAuthExceptionToFailure(e);
    } on TimeoutException {
      throw const AuthFailure('request_timeout');
    } catch (_) {
      throw const AuthFailure('something_went_wrong');
    }
  }
}
