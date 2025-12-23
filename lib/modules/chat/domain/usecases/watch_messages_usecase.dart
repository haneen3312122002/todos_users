import 'package:notes_tasks/core/features/chat/chat_dervices.dart';
import 'package:notes_tasks/modules/chat/domain/entities/message_entity.dart';

class WatchMessagesUseCase {
  final ChatsService _service;
  WatchMessagesUseCase(this._service);

  Stream<List<MessageEntity>> call(String chatId) =>
      _service.watchMessages(chatId);
}
