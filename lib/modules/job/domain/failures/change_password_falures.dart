class ChangePasswordFailure implements Exception {
  final String messageKey;

  const ChangePasswordFailure(this.messageKey);

  @override
  String toString() => 'ChangePasswordFailure($messageKey)';
}