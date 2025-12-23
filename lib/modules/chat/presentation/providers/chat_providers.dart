import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/features/chat/chat_provider.dart';
import 'package:notes_tasks/modules/chat/domain/entities/chat_entity.dart';
import 'package:notes_tasks/modules/chat/domain/entities/message_entity.dart';

import 'package:notes_tasks/modules/chat/domain/usecases/send_message_usecase.dart';
import 'package:notes_tasks/modules/chat/domain/usecases/watch_messages_usecase.dart';
import 'package:notes_tasks/modules/chat/domain/usecases/watch_my_chats_usecase.dart';

//
// ----------------------------
// UseCases Providers
// ----------------------------

final watchMyChatsUseCaseProvider = Provider<WatchMyChatsUseCase>((ref) {
  final service = ref.watch(chatsServiceProvider);
  return WatchMyChatsUseCase(service);
});

final watchMessagesUseCaseProvider = Provider<WatchMessagesUseCase>((ref) {
  final service = ref.watch(chatsServiceProvider);
  return WatchMessagesUseCase(service);
});

final sendMessageUseCaseProvider = Provider<SendMessageUseCase>((ref) {
  final service = ref.watch(chatsServiceProvider);
  return SendMessageUseCase(service);
});

//
// ----------------------------
// Stream Providers
// ----------------------------

final myChatsStreamProvider = StreamProvider<List<ChatEntity>>((ref) {
  final uc = ref.watch(watchMyChatsUseCaseProvider);
  return uc();
});

final chatMessagesStreamProvider =
    StreamProvider.family<List<MessageEntity>, String>((ref, chatId) {
  final uc = ref.watch(watchMessagesUseCaseProvider);
  return uc(chatId);
});

//
// ----------------------------
// Actions ViewModel Provider
// ----------------------------
