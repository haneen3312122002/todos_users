import 'package:flutter/material.dart';
import 'package:notes_tasks/modules/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/modules/task/presentation/widgets/custom_task_item.dart';

class CustomTaskList extends StatelessWidget {
  final List<TaskEntity> tasks;
  final Future<void> Function()? onRefresh;
  final void Function(TaskEntity)? onTapItem;

  const CustomTaskList({
    super.key,
    required this.tasks,
    this.onRefresh,
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text('No tasks available.', style: TextStyle(fontSize: 16)),
      );
    }

    final list = ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: CustomTaskItem(task: task, onTap: () => onTapItem?.call(task)),
        );
      },
    );

    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh!, child: list);
    }

    return list;
  }
}
