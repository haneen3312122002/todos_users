import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/providers/date_range_provider.dart';
import 'package:notes_tasks/core/shared/services/utils/date_picker_service.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';

class AppDateRangeFields extends ConsumerWidget {
  final String startLabelKey;
  final String endLabelKey;
  final String presentLabelKey;
  final String markPresentLabelKey;

  const AppDateRangeFields({
    super.key,
    required this.startLabelKey,
    required this.endLabelKey,
    required this.presentLabelKey,
    required this.markPresentLabelKey,
  });

  bool _isPresentRange(DateTimeRange? range) {
    if (range == null) return false;
    return range.start == range.end;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateRange = ref.watch(dateRangeProvider);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final buttonStyle = OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceMD,
        vertical: AppSpacing.spaceSM,
      ),
      side: BorderSide(
        color: colors.outline.withOpacity(0.7),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundColor: colors.onSurface,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ===== تاريخ البداية =====
        OutlinedButton.icon(
          style: buttonStyle,
          onPressed: () async {
            final current = ref.read(dateRangeProvider);

            final picked = await DatePickerService.pickDate(
              context: context,
              initialDate: current?.start ?? DateTime.now(),
              firstDate: DateTime(1980),
              lastDate: DateTime(DateTime.now().year + 5),
            );

            if (picked != null) {
              DateRangeUtils.setStart(ref, picked);
            }
          },
          icon: Icon(
            Icons.date_range,
            size: 18,
            color: colors.primary,
          ),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dateRange?.start != null
                  ? DateFormatUtils.formatYearMonth(context, dateRange!.start)
                  : startLabelKey.tr(),
              style: AppTextStyles.caption.copyWith(
                color: dateRange?.start != null
                    ? colors.onSurface
                    : colors.onSurface.withOpacity(0.6),
                fontWeight: dateRange?.start != null
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
          ),
        ),

        SizedBox(height: AppSpacing.spaceSM),

        // ===== تاريخ النهاية / حاضر =====
        OutlinedButton.icon(
          style: buttonStyle,
          onPressed: () async {
            final current = ref.read(dateRangeProvider);

            final picked = await DatePickerService.pickDate(
              context: context,
              initialDate: current?.end ?? current?.start ?? DateTime.now(),
              firstDate: current?.start ?? DateTime(1980),
              lastDate: DateTime(DateTime.now().year + 5),
            );

            if (picked != null) {
              DateRangeUtils.setEnd(ref, picked);
            }
          },
          icon: Icon(
            Icons.event,
            size: 18,
            color: colors.primary,
          ),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              () {
                if (dateRange == null) {
                  return endLabelKey.tr();
                }

                if (_isPresentRange(dateRange)) {
                  return presentLabelKey.tr();
                }

                return DateFormatUtils.formatYearMonth(context, dateRange.end);
              }(),
              style: AppTextStyles.caption.copyWith(
                color: dateRange == null
                    ? colors.onSurface.withOpacity(0.6)
                    : colors.onSurface,
                fontWeight:
                    dateRange == null ? FontWeight.w400 : FontWeight.w500,
              ),
            ),
          ),
        ),

        SizedBox(height: AppSpacing.spaceXS),

        // ===== زر "حالياً" =====
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              DateRangeUtils.clearEnd(ref);
            },
            child: Text(
              markPresentLabelKey.tr(),
              style: AppTextStyles.caption.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
