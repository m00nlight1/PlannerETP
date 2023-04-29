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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.taskList.isNotEmpty) {
          return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
                  child: TextFormField(
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
                        borderSide: const BorderSide(width: 1, color: Colors.black38),
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
                ),
                if (textSearchEditingController.text.isNotEmpty)
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: result.length,
                            itemBuilder: (context, index) {
                              return TaskItem(taskEntity: result[index]);
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
                            itemCount: state.taskList.length,
                            itemBuilder: (context, index) {
                              return TaskItem(taskEntity: state.taskList[index]);
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
