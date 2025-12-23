import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_tasks/modules/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.id,
    required super.jobId,
    required super.proposalId,
    required super.clientId,
    required super.freelancerId,
    required super.participants,
    required super.jobTitle,
    required super.jobCategory,
    super.jobCoverUrl,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.lastMessageText,
    super.lastMessageAt,
    super.lastMessageSenderId,
  });

  factory ChatModel.fromModel(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    DateTime dt(dynamic v) =>
        v is Timestamp ? v.toDate() : (v as DateTime? ?? DateTime.now());
    DateTime? dtn(dynamic v) => v is Timestamp ? v.toDate() : (v as DateTime?);

    return ChatModel(
      id: doc.id,
      jobId: data['jobId'] ?? '',
      proposalId: data['proposalId'] ?? '',
      clientId: data['clientId'] ?? '',
      freelancerId: data['freelancerId'] ?? '',
      participants:
          (data['participants'] as List? ?? []).map((e) => '$e').toList(),
      jobTitle: data['jobTitle'] ?? '-',
      jobCategory: data['jobCategory'] ?? '-',
      jobCoverUrl: data['jobCoverUrl'] as String?,
      status: data['status'] ?? 'open',
      createdAt: dt(data['createdAt']),
      updatedAt: dt(data['updatedAt']),
      lastMessageText: data['lastMessageText'] as String?,
      lastMessageAt: dtn(data['lastMessageAt']),
      lastMessageSenderId: data['lastMessageSenderId'] as String?,
    );
  }

  Map<String, dynamic> toModel() {
    return {
      'jobId': jobId,
      'proposalId': proposalId,
      'clientId': clientId,
      'freelancerId': freelancerId,
      'participants': participants,
      'jobTitle': jobTitle,
      'jobCategory': jobCategory,
      'jobCoverUrl': jobCoverUrl,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'lastMessageText': lastMessageText,
      'lastMessageAt':
          lastMessageAt != null ? Timestamp.fromDate(lastMessageAt!) : null,
      'lastMessageSenderId': lastMessageSenderId,
    };
  }
}
