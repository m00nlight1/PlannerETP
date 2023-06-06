import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/search_text_field.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/task_item.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TextEditingController textSearchEditingController = TextEditingController();

  final List<String> filteringCategories = [
    'Мои посты',
    'Журнал объекта',
    'Задача',
    'Предписание авторского надзора',
  ];
  List<String> selectedCategories = [];

  final userId = locator
      .get<AuthCubit>()
      .state
      .whenOrNull(authorized: (userEntity) => userEntity.id);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.taskList.isNotEmpty) {
          final filterTasks = state.taskList.where((task) {
            if (selectedCategories.contains('Мои посты')) {
              return task.user!.id == userId;
            }
            return selectedCategories.isEmpty ||
                selectedCategories.contains(task.category?.name);
          }).toList();
          final filterTasksSearch = filterTasks.where((task) {
            if (selectedCategories.contains('Мои посты')) {
              return task.user!.id == userId;
            }
            return task.title
                .toLowerCase()
                .contains(textSearchEditingController.text.toLowerCase());
          }).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchTextField(
                        controller: textSearchEditingController,
                        onChange: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 3,
                        children: filteringCategories
                            .map(
                              (category) => FilterChip(
                                selected: selectedCategories.contains(category),
                                label: Text(category),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                backgroundColor: const Color(0xFF0d74ba),
                                selectedColor: Colors.lightGreen,
                                checkmarkColor: Colors.white,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedCategories.add(category);
                                    } else {
                                      selectedCategories.remove(category);
                                    }
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                if (textSearchEditingController.text.isNotEmpty)
                  Column(
                    children: [
                      buildExpansionTile(
                        title:
                            "Открыто (${filterTasksSearch.where((task) => task.status?.id == 1).length.toString()})",
                        tasks: filterTasksSearch
                            .where((task) => task.status?.id == 1)
                            .toList(),
                      ),
                      buildExpansionTile(
                        title:
                            "В работе (${filterTasksSearch.where((task) => task.status?.id == 2).length.toString()})",
                        tasks: filterTasksSearch
                            .where((task) => task.status?.id == 2)
                            .toList(),
                      ),
                      buildExpansionTile(
                        title:
                            "Решено (${filterTasksSearch.where((task) => task.status?.id == 3).length.toString()})",
                        tasks: filterTasksSearch
                            .where((task) => task.status?.id == 3)
                            .toList(),
                      ),
                      buildExpansionTile(
                        title:
                            "Закрыто (${filterTasksSearch.where((task) => task.status?.id == 4).length.toString()})",
                        tasks: filterTasksSearch
                            .where((task) => task.status?.id == 4)
                            .toList(),
                      ),
                      buildExpansionTile(
                        title:
                            "Без статуса (${filterTasksSearch.where((task) => task.category?.id == 1).length.toString()})",
                        tasks: filterTasksSearch
                            .where((task) => task.category?.id == 1)
                            .toList(),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      buildExpansionTile(
                        title:
                            "Открыто (${filterTasks.where((task) => task.status?.id == 1).length.toString()})",
                        tasks: filterTasks
                            .where((task) => task.status?.id == 1)
                            .toList(),
                      ),
                      buildExpansionTile(
                        title:
                            "В работе (${filterTasks.where((task) => task.status?.id == 2).length.toString()})",
                        tasks: filterTasks
                            .where((task) => task.status?.id == 2)
                            .toList(),
                      ),
                      buildExpansionTile(
                        title:
                            "Решено (${filterTasks.where((task) => task.status?.id == 3).length.toString()})",
                        tasks: filterTasks
                            .where((task) => task.status?.id == 3)
                            .toList(),
                      ),
                      buildExpansionTile(
                        title:
                            "Закрыто (${filterTasks.where((task) => task.status?.id == 4).length.toString()})",
                        tasks: filterTasks
                            .where((task) => task.status?.id == 4)
                            .toList(),
                      ),
                      buildExpansionTile(
                        title:
                            "Без статуса (${filterTasks.where((task) => task.category?.id == 1).length.toString()})",
                        tasks: filterTasks
                            .where((task) => task.category?.id == 1)
                            .toList(),
                      ),
                    ],
                  ),
              ],
            ),
          );
        }
        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return SizedBox(
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
              child: Text(
                "Задач нет",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ExpansionTile buildExpansionTile(
      {required String title, required List<TaskEntity> tasks}) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text("$title"),
      children: [
        SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItem(taskEntity: tasks[index]);
            },
          ),
        ),
      ],
    );
  }
}
