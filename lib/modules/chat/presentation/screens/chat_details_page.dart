import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/widgets/animation/chat/chat_input_bar.dart';
import 'package:notes_tasks/core/shared/widgets/animation/chat/chat_message_bubble.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/core/shared/widgets/common/error_view.dart';
import 'package:notes_tasks/core/data/remote/firebase/providers/firebase_providers.dart';

import 'package:notes_tasks/modules/chat/presentation/providers/chat_providers.dart';
import 'package:notes_tasks/modules/chat/domain/failures/chat_failure.dart';

import 'package:notes_tasks/core/shared/widgets/common/empty_view.dart';
import 'package:notes_tasks/modules/chat/presentation/viewmodels/chat_actions_viewmodel.dart';

class ChatDetailsScreen extends ConsumerStatefulWidget {
  final String chatId;
  const ChatDetailsScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends ConsumerState<ChatDetailsScreen> {
  final _ctrl = TextEditingController();
  late final ProviderSubscription _chatSub;

  @override
  void initState() {
    super.initState();

    _chatSub = ref.listenManual(chatActionsViewModelProvider, (prev, next) {
      final wasLoading = prev?.isLoading ?? false;
      final nowSuccess = next.hasValue && !next.isLoading && !next.hasError;
      if (wasLoading && nowSuccess) {
        if (!mounted) return;
        _ctrl.clear();
      }
      next.whenOrNull(
        error: (e, _) {
          if (!mounted) return;
          final key =
              (e is ChatFailure) ? e.messageKey : 'something_went_wrong';
          AppSnackbar.show(context, key.tr());
        },
      );
    });
  }

  @override
  void dispose() {
    _chatSub.close();
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (ref.read(chatActionsViewModelProvider).isLoading) return;

    await ref.read(chatActionsViewModelProvider.notifier).send(
          chatId: widget.chatId,
          text: _ctrl.text,
        );

    final result = ref.read(chatActionsViewModelProvider);
    if (!result.hasError && mounted) {
      _ctrl.clear(); // ✅ مضمون
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesStreamProvider(widget.chatId));
    final sending = ref.watch(chatActionsViewModelProvider).isLoading;

    final currentUserId = ref.read(firebaseAuthProvider).currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: Text('chat'.tr())),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => ErrorView(
                message: 'something_went_wrong'.tr(),
                fullScreen: false,
                onRetry: () =>
                    ref.refresh(chatMessagesStreamProvider(widget.chatId)),
              ),
              data: (messages) {
                if (messages.isEmpty) {
                  return const EmptyView(
                    // استعملي key إذا بدك
                    message: null,
                    icon: Icons.chat_bubble_outline,
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(AppSpacing.spaceMD),
                  itemCount: messages.length,
                  // إذا messages عندك مرتبة من الأقدم للأحدث خلي reverse=true
                  // reverse: true,
                  itemBuilder: (_, i) {
                    final m = messages[i];

                    // ✅ عدلي حسب موديلك: senderId / fromId / uid ...
                    final senderId =
                        ref.read(firebaseAuthProvider).currentUser?.uid;
                    final isMe =
                        (currentUserId != null && m.senderId == currentUserId);

                    return ChatMessageBubble(
                      text: m.text,
                      isMe: isMe,
                    );
                  },
                );
              },
            ),
          ),
          ChatInputBar(
            controller: _ctrl,
            sending: sending,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}
