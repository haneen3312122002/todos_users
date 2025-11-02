import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/widgets/custom_text_field.dart';
import 'package:notes_tasks/core/widgets/primary_button.dart';
import 'package:notes_tasks/task/presentation/viewmodels/add_task_viewmodel.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreen();
}

class _AddTaskScreen extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(addTaskViewModelProvider.notifier);
    final state = ref.watch(addTaskViewModelProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppCustomTextField(
          controller: _titleController,
          label: 'Task Title',
          hint: 'Enter your task',
        ),
        const SizedBox(height: 20),
        AppPrimaryButton(
          label: 'Add Task',
          isLoading: state.isLoading,
          icon: Icons.add,
          onPressed: () async {
            await viewModel.addTask(
              todo: _titleController.text.trim(),
              completed: false,
              userId: 1,
            );
            if (context.mounted) Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
