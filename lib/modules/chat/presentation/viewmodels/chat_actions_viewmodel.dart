import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/chat/domain/failures/chat_failure.dart';
import 'package:notes_tasks/modules/chat/presentation/providers/chat_providers.dart';

final chatActionsViewModelProvider =
    AsyncNotifierProvider<ChatActionsViewModel, void>(ChatActionsViewModel.new);

class ChatActionsViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> send({required String chatId, required String text}) async {
    if (state.isLoading) return;

    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      state = AsyncError(
        const ChatFailure('chat_empty_message'),
        StackTrace.empty,
      );
      return;
    }

    state = const AsyncLoading();

    try {
      final sendUseCase = ref.read(sendMessageUseCaseProvider);
      await sendUseCase(chatId: chatId, text: trimmed);
      state = const AsyncData(null);
    } on ChatFailure catch (f, st) {
      state = AsyncError(f, st);
    } catch (_, st) {
      state = AsyncError(const ChatFailure('chat_send_failed'), st);
    }
  }
}
