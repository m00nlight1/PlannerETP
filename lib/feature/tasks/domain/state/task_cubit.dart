import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

part 'task_state.dart';

part 'task_cubit.freezed.dart';

part 'task_cubit.g.dart';

class TaskCubit extends HydratedCubit<TaskState> {
  final TaskRepository taskRepository;

  TaskCubit(this.taskRepository)
      : super(const TaskState(asyncSnapshot: AsyncSnapshot.nothing()));

  Future<void> fetchTasks() async {
    await taskRepository.fetchTasks().then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          taskList: iterable.map((e) => TaskEntity.fromJson(e)).toList(),
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      addError(error);
    });
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(state.copyWith(
        asyncSnapshot: AsyncSnapshot.withError(ConnectionState.done, error)));
    super.addError(error, stackTrace);
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toJson();
  }
}
