import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/task_item.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<StatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TextEditingController textSearchEditingController = TextEditingController();

  List<TaskEntity> result = [];

  final List<String> filteringCategories = [
    // 'Мои задачи',
    // 'Все',
    'Журнал объекта',
    'Задача',
    'Предписание авторского надзора',
  ];
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.taskList.isNotEmpty) {
          final filterTasks = state.taskList.where((task) {
              return selectedCategories.isEmpty ||
                  selectedCategories.contains(task.category?.name);
          }).toList();
          final filterTasksSearch = result.where((task) {
            return selectedCategories.isEmpty ||
            selectedCategories.contains(task.category?.name);
          }).toList();
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
                child: Column(
                  children: [
                    TextFormField(
                      controller: textSearchEditingController,
                      decoration: InputDecoration(
                        hintText: 'Поиск...',
                        labelText: 'Поиск',
                        labelStyle: const TextStyle(color: Colors.black38),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black38,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black38),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onChanged: (value) {
                        if (textSearchEditingController.text.isEmpty) {
                          result = state.taskList;
                          context.read<TaskCubit>().fetchTasks();
                        } else {
                          result = state.taskList
                              .where((element) => element.title
                                  .toLowerCase()
                                  .contains(textSearchEditingController.text
                                      .toLowerCase()))
                              .toList();
                          context.read<TaskCubit>().fetchTasks();
                        }
                      },
                    ),
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
                                      fontWeight: FontWeight.w600),
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
                                  }),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
              if (textSearchEditingController.text.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filterTasksSearch.length,
                      itemBuilder: (context, index) {
                        return TaskItem(taskEntity: filterTasksSearch[index]);
                      },
                    ),
                  ),
                )
              else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filterTasks.length,
                      itemBuilder: (context, index) {
                        return TaskItem(taskEntity: filterTasks[index]);
                      },
                    ),
                  ),
                ),
            ],
          );
        }
        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
