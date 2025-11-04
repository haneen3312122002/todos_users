import 'package:flutter/material.dart';
import 'package:notes_tasks/modules/task/domain/entities/task_entity.dart';

class CustomTaskItem extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback? onTap;
  final VoidCallback? onToggleCompleted;

  const CustomTaskItem({
    super.key,
    required this.task,
    this.onTap,
    this.onToggleCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = task.completed
        ? Colors.green.shade50
        : Colors.orange.shade50;

    final Color iconColor = task.completed
        ? Colors.green.shade600
        : Colors.orange.shade600;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          title: Text(
            task.todo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
              decoration: task.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            task.completed ? 'Completed ' : 'Pending ',
            style: TextStyle(
              fontSize: 13,
              color: task.completed
                  ? Colors.green.shade700
                  : Colors.orange.shade700,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              task.completed ? Icons.check_circle : Icons.pending_actions,
              color: iconColor,
            ),
            onPressed: onToggleCompleted,
          ),
        ),
      ),
    );
  }
}
