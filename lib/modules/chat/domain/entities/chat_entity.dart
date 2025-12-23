class ChatEntity {
  final String id;
  final String jobId;
  final String proposalId;
  final String clientId;
  final String freelancerId;
  final List<String> participants;

  final String jobTitle;
  final String jobCategory;
  final String? jobCoverUrl;

  final String status; // open/closed
  final DateTime createdAt;
  final DateTime updatedAt;

  final String? lastMessageText;
  final DateTime? lastMessageAt;
  final String? lastMessageSenderId;

  const ChatEntity({
    required this.id,
    required this.jobId,
    required this.proposalId,
    required this.clientId,
    required this.freelancerId,
    required this.participants,
    required this.jobTitle,
    required this.jobCategory,
    this.jobCoverUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessageText,
    this.lastMessageAt,
    this.lastMessageSenderId,
  });

  bool get isOpen => status == 'open';
}
