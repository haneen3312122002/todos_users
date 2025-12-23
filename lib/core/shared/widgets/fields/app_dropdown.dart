import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final String? label; //upper title for the dropdown
  final String? hint; //
  final List<T> items; //list of the choices
  final dynamic value; // selected value
  final void Function(T?)? onChanged; // when changing the  value
  final String Function(T)? itemLabelBuilder; // T -> text
  final String? Function(T?)? validator; // if it is in form
  final bool enabled;
  final bool isExpanded;
  final EdgeInsetsGeometry margin;

  const AppDropdown({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
    this.itemLabelBuilder,
    this.label,
    this.hint,
    this.validator,
    this.enabled = true,
    this.isExpanded = true,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
  });

  String _defaultLabelBuilder(T item) {
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
          ],
          DropdownButtonFormField<T>(
            isExpanded: isExpanded,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabled: enabled,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      (itemLabelBuilder ?? _defaultLabelBuilder)(item),
                    ),
                  ),
                )
                .toList(),
            onChanged: enabled ? onChanged : null,
            validator: validator != null ? (value) => validator!(value) : null,
          ),
        ],
      ),
    );
  }
}
