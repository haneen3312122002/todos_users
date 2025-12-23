class ResetPasswordFailure implements Exception {
  final String messageKey;
  const ResetPasswordFailure(this.messageKey);

  @override
  String toString() => 'ResetPasswordFailure($messageKey)';
}