import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:notes_tasks/modules/chat/data/models/chat_model.dart';
import 'package:notes_tasks/modules/chat/data/models/message_model.dart';

import 'package:notes_tasks/modules/chat/domain/entities/chat_entity.dart';
import 'package:notes_tasks/modules/chat/domain/entities/message_entity.dart';

class ChatsService {
  final FirebaseFirestore db;
  final fb.FirebaseAuth auth;

  ChatsService({required this.db, required this.auth});

  fb.User? get currentUser => auth.currentUser;

  CollectionReference<Map<String, dynamic>> get _chatsCol =>
      db.collection('chats');

  CollectionReference<Map<String, dynamic>> _messagesCol(String chatId) =>
      _chatsCol.doc(chatId).collection('messages');

  /// ✅ deterministic chatId per job + freelancer
  String chatIdForJob(String jobId, String freelancerId) =>
      '${jobId}_$freelancerId';

  // ==========================
  // Streams
  // ==========================
  Stream<List<ChatEntity>> watchMyChats() {
    final u = currentUser;
    if (u == null) return const Stream.empty();

    return _chatsCol
        .where('participants', arrayContains: u.uid)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => ChatModel.fromModel(d)).toList());
  }

  Stream<ChatEntity?> watchChatById(String chatId) {
    return _chatsCol.doc(chatId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return ChatModel.fromModel(doc);
    });
  }

  Stream<List<MessageEntity>> watchMessages(String chatId) {
    return _messagesCol(chatId)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((s) => s.docs.map((d) => MessageModel.fromFirestore(d)).toList());
  }

  // ==========================
  // Actions
  // ==========================
  Future<void> sendMessage({
    required String chatId,
    required String text,
  }) async {
    final u = currentUser;
    if (u == null) throw Exception('No logged in user');
    final t = text.trim();
    if (t.isEmpty) return;

    // check chat status
    final chatDoc = await _chatsCol.doc(chatId).get();
    final chat = chatDoc.data();
    if (chat == null) throw Exception('Chat not found');
    if ((chat['status'] ?? 'open') != 'open') {
      throw Exception('Chat is closed');
    }

    final msgRef = _messagesCol(chatId).doc();

    final msg = MessageModel(
      id: msgRef.id,
      chatId: chatId,
      senderId: u.uid,
      text: t,
      createdAt: DateTime.now(),
    );

    final batch = db.batch();
    batch.set(msgRef, msg.toFirestore());
    batch.update(_chatsCol.doc(chatId), {
      'lastMessageText': t,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'lastMessageSenderId': u.uid,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  Future<void> closeChat(String chatId) async {
    final u = currentUser;
    if (u == null) throw Exception('No logged in user');

    final doc = await _chatsCol.doc(chatId).get();
    final data = doc.data();
    if (data == null) throw Exception('Chat not found');

    final isParticipant = (data['participants'] as List? ?? []).contains(u.uid);
    if (!isParticipant) throw Exception('Not allowed');

    await _chatsCol.doc(chatId).update({
      'status': 'closed',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
