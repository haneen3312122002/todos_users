import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';

class ChatMessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  final EdgeInsetsGeometry? margin;

  const ChatMessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final bg = isMe ? colors.primary : colors.surface;
    final fg = isMe ? colors.onPrimary : colors.onSurface;

    final align = isMe ? Alignment.centerRight : Alignment.centerLeft;

    // مثل واتساب/تلغرام: زوايا مختلفة حسب الاتجاه
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isMe ? 16 : 4),
      bottomRight: Radius.circular(isMe ? 4 : 16),
    );

    return Align(
      alignment: align,
      child: Container(
        margin: margin ??
            EdgeInsets.only(
              bottom: AppSpacing.spaceSM,
              left: isMe ? AppSpacing.spaceLG : 0,
              right: isMe ? 0 : AppSpacing.spaceLG,
            ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spaceMD,
          vertical: AppSpacing.spaceSM,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border:
              isMe ? null : Border.all(color: colors.outline.withOpacity(.35)),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withOpacity(isMe ? .12 : .06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: fg),
        ),
      ),
    );
  }
}
