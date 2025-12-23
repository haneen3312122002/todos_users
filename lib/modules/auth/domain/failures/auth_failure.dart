class AuthFailure implements Exception {
  final String messageKey;

  const AuthFailure(this.messageKey);

  @override
  String toString() => 'AuthFailure($messageKey)';
}
