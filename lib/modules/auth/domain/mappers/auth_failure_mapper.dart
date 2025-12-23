import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:notes_tasks/modules/auth/domain/failures/auth_failure.dart';

AuthFailure mapFirebaseAuthExceptionToFailure(fb.FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return const AuthFailure('invalid_email');
    case 'user-not-found':
      return const AuthFailure('user_not_found');
    case 'wrong-password':
      return const AuthFailure('wrong_password');
    case 'user-disabled':
      return const AuthFailure('user_disabled');
    case 'too-many-requests':
      return const AuthFailure('too_many_requests');
    case 'network-request-failed':
      return const AuthFailure('network_error');
    case 'missing-email':
      return const AuthFailure('please_enter_email');
    default:
      return const AuthFailure('something_went_wrong');
  }
}
