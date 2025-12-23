import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/app_icon_button.dart';

class CategoryTileCard extends StatelessWidget {
  const CategoryTileCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIconButton(
            icon: icon,
            onTap: onTap,
            size: 64,
            iconSize: 28,
            isCircular: false,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
