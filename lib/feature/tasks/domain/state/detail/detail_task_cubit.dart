import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/chat/message_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

part 'detail_task_state.dart';

part 'detail_task_cubit.freezed.dart';

part 'detail_task_cubit.g.dart';

class DetailTaskCubit extends Cubit<DetailTaskState> {
  final TaskRepository taskRepository;
  final String id;

  DetailTaskCubit(this.taskRepository, this.id)
      : super(const DetailTaskState());

  Future<void> fetchTask() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.fetchTask(id).then((value) {
      emit(state.copyWith(
          taskEntity: value,
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, "Успешное открытие задачи")));
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

  Future<void> deleteDocument(String docId) async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.deleteDocument(docId).then((value) {
      emit(state.copyWith(
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, "Документ удалён")));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> updateTask(Map args) async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.updateTask(id, args).then((value) {
      emit(state.copyWith(
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, "Изменения сохранены")));
      fetchTask();
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> sentMessage(Map args) async {
    await taskRepository.sentMessage(args).then((value) {
      emit(state.copyWith(
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, "Сообщение отправлено")));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> getTaskChat() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.getTaskChat(id).then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          messageList: iterable.map((e) => MessageEntity.fromJson(e)).toList(),
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
}
