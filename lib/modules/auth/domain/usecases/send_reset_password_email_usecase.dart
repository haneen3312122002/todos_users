import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'package:notes_tasks/core/features/auth/services/auth_service.dart';
import 'package:notes_tasks/core/data/remote/firebase/providers/firebase_providers.dart';
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';
import 'package:notes_tasks/modules/auth/domain/mappers/auth_failure_mapper.dart';
import 'package:notes_tasks/modules/auth/domain/validators/auth_validators.dart';

final sendResetPasswordEmailUseCaseProvider =
    Provider<SendResetPasswordEmailUseCase>((ref) {
  final authService = ref.read(authServiceProvider);
  return SendResetPasswordEmailUseCase(authService);
});

class SendResetPasswordEmailUseCase {
  final AuthService _authService;
  SendResetPasswordEmailUseCase(this._authService);

  Future<void> call({required String email}) async {
    final emailKey = AuthValidators.validateEmail(email);
    if (emailKey != null) throw AuthFailure(emailKey);

    try {
      await _authService
          .sendPasswordResetEmail(email: email.trim())
          .timeout(const Duration(seconds: 20));
    } on fb.FirebaseAuthException catch (e) {
      throw mapFirebaseAuthExceptionToFailure(e);
    } on TimeoutException {
      throw const AuthFailure('request_timeout');
    } catch (_) {
      throw const AuthFailure('something_went_wrong');
    }
  }
}
