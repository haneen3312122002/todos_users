import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/app_icon_button.dart';

@immutable
class JobCategory {
  final String id;
  final String label;
  final IconData icon;

  const JobCategory({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class JobCategories {
  JobCategories._();

  static const all = <JobCategory>[
    JobCategory(id: 'mobile', label: 'Mobile', icon: Icons.phone_iphone),
    JobCategory(id: 'web', label: 'Web', icon: Icons.language),
    JobCategory(id: 'uiux', label: 'UI/UX Design', icon: Icons.design_services),
    JobCategory(id: 'backend', label: 'Backend / API', icon: Icons.dns),
    JobCategory(id: 'cyber', label: 'Cybersecurity', icon: Icons.security),
    JobCategory(id: 'data', label: 'Data / AI', icon: Icons.auto_graph),
    JobCategory(id: 'devops', label: 'DevOps / Cloud', icon: Icons.cloud),
    JobCategory(id: 'qa', label: 'QA / Testing', icon: Icons.bug_report),
    JobCategory(id: 'content', label: 'Content Writing', icon: Icons.edit_note),
    JobCategory(id: 'other', label: 'Other', icon: Icons.more_horiz),
  ];

  static List<String> ids() => all.map((c) => c.id).toList();

  static String labelById(String id) => all.firstWhere((c) => c.id == id).label;

  static JobCategory? byId(String? id) {
    if (id == null) return null;
    for (final c in all) {
      if (c.id == id) return c;
    }
    return null;
  }

  static List<DropdownMenuItem<String>> dropdownItems(BuildContext context) {
    final theme = Theme.of(context);

    return all
        .map(
          (c) => DropdownMenuItem<String>(
            value: c.id,
            child: Row(
              children: [
                AppIconButton(
                  icon: c.icon,
                  onTap: null, // ✅ للعرض فقط داخل dropdown
                  size: 34,
                  iconSize: 18,
                  isCircular: true,
                  // اختياري: خلّيها ناعمة ومطابقة للثيم
                  backgroundColor: theme.colorScheme.surface.withOpacity(0.9),
                  iconColor: theme.colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    c.label,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
