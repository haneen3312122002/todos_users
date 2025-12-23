class ChatFailure implements Exception {
  final String messageKey;
  const ChatFailure(this.messageKey);

  @override
  String toString() => 'ChatFailure($messageKey)';
}
