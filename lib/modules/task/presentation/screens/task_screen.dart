import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/providers/navbar_provider.dart';
import 'package:notes_tasks/core/widgets/animation/fade_in.dart';
import 'package:notes_tasks/core/widgets/animation/shake_animation.dart';
import 'package:notes_tasks/core/widgets/animation/slide_in.dart';
import 'package:notes_tasks/core/widgets/app_dialog.dart';
import 'package:notes_tasks/core/widgets/app_fab.dart';
import 'package:notes_tasks/core/widgets/app_scaffold.dart';
import 'package:notes_tasks/core/widgets/empty_view.dart';
import 'package:notes_tasks/core/widgets/error_view.dart';
import 'package:notes_tasks/core/widgets/loading_indicator.dart';
import 'package:notes_tasks/core/widgets/app_card.dart';
import 'package:notes_tasks/core/widgets/app_list_tile.dart';
import 'package:notes_tasks/modules/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/modules/task/presentation/screens/add_task_screen.dart';
import 'package:notes_tasks/modules/task/presentation/viewmodels/firebase/tasks_viewmodel.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  bool shake = false;

  int _animationRound = 0; // كل مرة نزيده، يرجع يعمل الأنميشن
  static const int tabIndex =
      0; // ✋ غيّرها حسب Index تاب الـ Tasks في الـ navbar

  @override
  Widget build(BuildContext context) {
    // 1) نسمع لتغيّر قيمة الـ navbar هنا (المكان الصحيح)
    ref.listen<int>(
      navIndexProvider,
      (prev, next) {
        if (next == tabIndex) {
          // رجعنا لتاب التاسكات
          if (mounted) {
            setState(() {
              _animationRound++; // هيك الـ FadeIn ياخذ Key جديدة → يعيد الأنيميشن
            });
          }
        }
      },
    );

    // 2) باقي منطق الشاشة
    final tasksState = ref.watch(tasksViewModelProvider);
    final vm = ref.read(tasksViewModelProvider.notifier);

    return AppScaffold(
      showLogout: true,
      scrollable: false,
      title: 'app_title'.tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: vm.refresh,
        ),
      ],
      body: FadeIn(
        key: ValueKey('tasks-root-$_animationRound'),
        duration: const Duration(milliseconds: 250),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: tasksState.when(
            data: (List<TaskEntity> tasks) {
              if (tasks.isEmpty) {
                return EmptyView(
                  key: const ValueKey('empty'),
                  message: 'no_tasks'.tr(),
                );
              }

              return RefreshIndicator(
                key: const ValueKey('list'),
                onRefresh: vm.refresh,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return FadeIn(
                      delay: Duration(milliseconds: 40 * index),
                      child: SlideIn(
                        from: const Offset(0, 10),
                        child: AppCard(
                          child: AppListTile(
                            title: task.todo,
                            trailing: Icon(
                              task.completed
                                  ? Icons.check_circle
                                  : Icons.pending,
                              color:
                                  task.completed ? Colors.green : Colors.orange,
                            ),
                            onTap: () {
                              // toggle later via VM
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(
              key: ValueKey('loading'),
              child: LoadingIndicator(withBackground: false),
            ),
            error: (error, _) => ErrorView(
              key: const ValueKey('error'),
              message: 'failed_load_tasks'.tr(),
              onRetry: vm.refresh,
            ),
          ),
        ),
      ),
      floatingActionButton: ShakeAnimation(
        trigger: shake,
        offset: 8,
        duration: const Duration(milliseconds: 300),
        child: AppFAB(
          tooltip: 'Add Task',
          onPressed: () {
            setState(() => shake = true);
            Future.delayed(const Duration(milliseconds: 350), () {
              if (mounted) {
                setState(() => shake = false);
              }
            });

            AppDialog.show(
              context: context,
              content: const AddTaskScreen(),
            );
          },
        ),
      ),
    );
  }
}
