import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/data/remote/firebase/providers/firebase_providers.dart';
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';
import 'package:notes_tasks/modules/auth/domain/mappers/auth_failure_mapper.dart';
import 'package:notes_tasks/modules/auth/domain/validators/auth_validators.dart';

final changePasswordUseCaseProvider = Provider<ChangePasswordUseCase>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  return ChangePasswordUseCase(auth);
});

class ChangePasswordUseCase {
  final fb.FirebaseAuth _auth;
  ChangePasswordUseCase(this._auth);

  Future<void> call({required String currentPassword}) async {
    final passKey = AuthValidators.validatePassword(currentPassword);
    if (passKey != null) throw AuthFailure(passKey);

    final user = _auth.currentUser;
    if (user == null) throw const AuthFailure('not_authenticated');

    final email = user.email;
    if (email == null || email.isEmpty) {
      throw const AuthFailure('no_email_for_user');
    }

    try {
      final credential = fb.EmailAuthProvider.credential(
        email: email,
        password: currentPassword.trim(),
      );

      await user
          .reauthenticateWithCredential(credential)
          .timeout(const Duration(seconds: 20));

      await _auth
          .sendPasswordResetEmail(email: email)
          .timeout(const Duration(seconds: 20));
    } on fb.FirebaseAuthException catch (e) {
      // هنا بدك رسالة “wrong_current_password” بدل “wrong_password”
      if (e.code == 'wrong-password') {
        throw const AuthFailure('wrong_current_password');
      }
      throw mapFirebaseAuthExceptionToFailure(e);
    } on TimeoutException {
      throw const AuthFailure('request_timeout');
    } catch (_) {
      throw const AuthFailure('something_went_wrong');
    }
  }
}
