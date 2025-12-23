import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/app_icon_button.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool sending;
  final Future<void> Function() onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.sending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.spaceMD),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                onTap: sending ? null : () => onSend(),
                decoration: InputDecoration(
                  hintText: 'type_message'.tr(),
                ),
              ),
            ),
            SizedBox(width: AppSpacing.spaceSM),
            AppIconButton(
              icon: Icons.send,
              onTap: sending ? null : onSend,
              // اختياري: خلي الخلفية مختلفة وقت الإرسال
            ),
          ],
        ),
      ),
    );
  }
}
