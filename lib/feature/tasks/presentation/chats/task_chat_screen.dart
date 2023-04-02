import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';
import 'package:planner_etp/feature/tasks/presentation/chats/messages_list.dart';

class TaskChatScreen extends StatelessWidget {
  const TaskChatScreen({super.key, required this.id, required this.taskEntity});

  final String id;
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            DetailTaskCubit(locator.get<TaskRepository>(), id)..getTaskChat(),
      child: _TaskChatScreenView(taskEntity, id),
    );
  }

}
class _TaskChatScreenView extends StatelessWidget {
  const _TaskChatScreenView(this.taskEntity, this.id);

  final String id;
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Комментарии"),
      ),
      body: const MessagesList(),
    );
  }
}