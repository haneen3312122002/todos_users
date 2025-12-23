import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/shared/providers/date_range_provider.dart';

class DateRangeUtils {

  static void setInitial(
    WidgetRef ref, {
    DateTime? start,
    DateTime? end,
  }) {
    if (start == null && end == null) {
      ref.read(dateRangeProvider.notifier).state = null;
    } else {
      ref.read(dateRangeProvider.notifier).state = DateTimeRange(
        start: start ?? end ?? DateTime.now(),
        end: end ?? start ?? DateTime.now(),
      );
    }
  }


  static void setStart(WidgetRef ref, DateTime date) {
    final current = ref.read(dateRangeProvider);
    DateTime? end = current?.end;

    if (end != null && end.isBefore(date)) {
      end = null; // نخليه null لو صار قبله (بالمخزن)
    }

    ref.read(dateRangeProvider.notifier).state = DateTimeRange(
      start: date,
      end: end ?? date,
    );
  }


  static void setEnd(WidgetRef ref, DateTime date) {
    final current = ref.read(dateRangeProvider);
    final start = current?.start ?? date;

    ref.read(dateRangeProvider.notifier).state = DateTimeRange(
      start: start,
      end: date,
    );
  }




  static void clearEnd(WidgetRef ref) {
    final current = ref.read(dateRangeProvider);
    if (current == null) return;

    ref.read(dateRangeProvider.notifier).state = DateTimeRange(
      start: current.start,
      end: current.start,
    );
  }
}


class DatePickerService {





  static Future<DateTime?> pickDate({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: "Select date",
      builder: (context, child) {
        final theme = Theme.of(context);


        if (child == null) {
          return const SizedBox.shrink();
        }

        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
            ),
          ),
          child: child,
        );
      },
    );
  }
}


class DateFormatUtils {


  static String formatYearMonth(
    BuildContext context,
    DateTime? date, {
    String? fallback,
  }) {
    if (date == null) {
      return fallback ?? '';
    }

    final locale = context.locale.toString();
    final formatter = DateFormat('yyyy/MM', locale);
    return formatter.format(date);
  }
}