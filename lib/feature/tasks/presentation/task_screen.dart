import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/domain/error_entity/error_entity.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/AppSnackBar.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailTaskCubit(locator.get<TaskRepository>(), id)..fetchTask(),
      child: _DetailTaskView(),
    );
  }
}

class _DetailTaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Задача"),
      ),
      body: BlocConsumer<DetailTaskCubit, DetailTaskState>(
        listener: (context, state) {
          if (state.asyncSnapshot.hasError) {
            AppSnackBar.showSnackBarWithError(
                context, ErrorEntity.fromException(state.asyncSnapshot.error));
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state.taskEntity != null) {
            return _DetailTaskItem(
              taskEntity: state.taskEntity!,
            );
          }
          if (state.asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }
          return const Center(
            child: Text("Ошибка загрузки"),
          );
        },
      ),
    );
  }
}

class _DetailTaskItem extends StatelessWidget {
  const _DetailTaskItem({required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Название: ${taskEntity.title}"),
        Text("Начало работ: ${taskEntity.startOfWork}"),
        Text("Окончание работ: ${taskEntity.endOfWork}"),
        Text("Компания исполнитель: ${taskEntity.contractorCompany}"),
        Text("Ответственный мастер: ${taskEntity.responsibleMaster}"),
        Text("Представитель: ${taskEntity.representative}"),
        Text("Уровень оснащения: ${taskEntity.equipmentLevel}"),
        Text("Уровень песонала: ${taskEntity.staffLevel}"),
        Text("Результаты работы: ${taskEntity.resultsOfTheWork}"),
        Text("Комментарии: ${taskEntity.content}"),
      ],
    );
  }
}
