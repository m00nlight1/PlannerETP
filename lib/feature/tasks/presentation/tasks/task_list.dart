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
  List<TaskEntity> openTasksResult = [];
  List<TaskEntity> openTasksSearchResult = [];
  List<TaskEntity> inWorkTasksResult = [];
  List<TaskEntity> inWorkTasksSearchResult = [];
  List<TaskEntity> solvedTasksResult = [];
  List<TaskEntity> solvedTasksSearchResult = [];
  List<TaskEntity> closedTasksResult = [];
  List<TaskEntity> closedTasksSearchResult = [];

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
          objOpen(open) => open.status?.id == 1;
          openTasksResult = filterTasks.where(objOpen).toList();
          openTasksSearchResult = filterTasksSearch.where(objOpen).toList();
          objInWork(worked) => worked.status?.id == 2;
          inWorkTasksResult = filterTasks.where(objInWork).toList();
          inWorkTasksSearchResult = filterTasksSearch.where(objInWork).toList();
          objSolved(solved) => solved.status?.id == 3;
          solvedTasksResult = filterTasks.where(objSolved).toList();
          solvedTasksSearchResult = filterTasksSearch.where(objSolved).toList();
          objClosed(closed) => closed.status?.id == 4;
          closedTasksResult = filterTasks.where(objClosed).toList();
          closedTasksSearchResult = filterTasksSearch.where(objClosed).toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            borderSide: const BorderSide(
                                width: 1, color: Colors.black38),
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
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 3,
                        children: filteringCategories
                            .map(
                              (category) => FilterChip(
                                  selected:
                                      selectedCategories.contains(category),
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
                  Column(
                    children: [
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "Открыто (${openTasksSearchResult.length.toString()})"),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: openTasksSearchResult.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      taskEntity: openTasksSearchResult[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "В работе (${inWorkTasksSearchResult.length.toString()})"),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: inWorkTasksSearchResult.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      taskEntity:
                                          inWorkTasksSearchResult[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "Решено (${solvedTasksSearchResult.length.toString()})"),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: solvedTasksSearchResult.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      taskEntity:
                                          solvedTasksSearchResult[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "Закрыто (${closedTasksSearchResult.length.toString()})"),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: closedTasksSearchResult.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      taskEntity:
                                          closedTasksSearchResult[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "Открыто (${openTasksResult.length.toString()})"),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: openTasksResult.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      taskEntity: openTasksResult[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "В работе (${inWorkTasksResult.length.toString()})"),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: inWorkTasksResult.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      taskEntity: inWorkTasksResult[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "Решено (${solvedTasksResult.length.toString()})"),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: solvedTasksResult.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      taskEntity: solvedTasksResult[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                            "Закрыто (${closedTasksResult.length.toString()})"),
                        children: [
                          SingleChildScrollView(
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: closedTasksResult.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      taskEntity: closedTasksResult[index]);
                                },
                              ),
                            ),
                          ),
                        ],
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
        return const SizedBox.shrink();
      },
    );
  }
}
