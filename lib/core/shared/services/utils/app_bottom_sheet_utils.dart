import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/widgets/pages/app_bottom_sheet.dart';


Future<T?> showAppFormBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
  EdgeInsetsGeometry? padding,
  bool useSafeArea = true,
  bool enableScroll = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (ctx) {
      return AppBottomSheet(
        padding: padding,
        useSafeArea: useSafeArea,
        enableScroll: enableScroll,
        child: child,
      );
    },
  );
}