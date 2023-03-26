import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

part 'task_state.dart';

part 'task_cubit.freezed.dart';

part 'task_cubit.g.dart';

class TaskCubit extends HydratedCubit<TaskState> {
  final TaskRepository taskRepository;
  final AuthCubit authCubit;
  late final StreamSubscription authSub;

  TaskCubit(this.taskRepository, this.authCubit)
      : super(const TaskState(asyncSnapshot: AsyncSnapshot.nothing())) {
    authSub = authCubit.stream.listen((event) {
      event.mapOrNull(
        authorized: (value) => fetchTasks(),
        notAuthorized: (value) => logOut(),
      );
    });
  }

  Future<void> fetchTasks() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
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

  Future<void> createTask(Map args) async {
    await taskRepository.createTask(args).then((value) {
      fetchTasks();
    }).catchError((error) {
      addError(error);
    });
  }

  void logOut() {
    emit(state.copyWith(
      asyncSnapshot: const AsyncSnapshot.nothing(),
      taskList: [],
    ));
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

  @override
  Future<void> close() {
    authSub.cancel();
    return super.close();
  }
}
