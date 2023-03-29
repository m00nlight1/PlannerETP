import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

part 'detail_task_state.dart';

part 'detail_task_cubit.freezed.dart';

class DetailTaskCubit extends Cubit<DetailTaskState> {
  DetailTaskCubit(this.taskRepository, this.id)
      : super(const DetailTaskState());

  final TaskRepository taskRepository;
  final String id;

  Future<void> fetchTask() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.fetchTask(id).then((value) {
      emit(state.copyWith(
          taskEntity: value,
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, "Успешное открытие задачи")));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> deleteTask() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.deleteTask(id).then((value) {
      emit(state.copyWith(
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, "Задача удалена")));
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
}
