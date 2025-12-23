import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'package:notes_tasks/core/features/chat/chat_dervices.dart';

final chatsServiceProvider = Provider<ChatsService>((ref) {
  return ChatsService(
    db: FirebaseFirestore.instance,
    auth: fb.FirebaseAuth.instance,
  );
});
