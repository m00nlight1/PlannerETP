import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/chat/message_entity.dart';
import 'package:planner_etp/feature/tasks/domain/document/document_entity.dart';
import 'package:planner_etp/feature/tasks/domain/industry/industry_entity.dart';
import 'package:planner_etp/feature/tasks/domain/status/status_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';
import 'package:planner_etp/feature/tasks/domain/tasktype/task_type_entity.dart';

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
        authorized: (value) {
          fetchTasks();
          fetchStatuses();
          fetchTaskTypes();
          fetchIndustries();
          fetchDocuments();
          fetchChats();
        },
        notAuthorized: (value) => logOut(),
      );
    });
  }

  Future<void> fetchTasks() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
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

  Future<void> fetchDocuments() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.fetchDocuments().then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          docList: iterable.map((e) => DocumentEntity.fromJson(e)).toList(),
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> createDocument(Map args) async {
    await taskRepository.createDocument(args).then((value) {
      fetchDocuments();
      emit(state.copyWith(
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, "Документ добавлен")));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> deleteDocument(String docId) async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.deleteDocument(docId).then((value) {
      fetchDocuments();
      emit(state.copyWith(
          asyncSnapshot: const AsyncSnapshot.withData(
              ConnectionState.done, "Документ удалён")));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> fetchStatuses() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.fetchStatuses().then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          statusList: iterable.map((e) => StatusEntity.fromJson(e)).toList(),
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> fetchTaskTypes() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.fetchTaskTypes().then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          taskTypeList:
              iterable.map((e) => TaskTypeEntity.fromJson(e)).toList(),
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> fetchIndustries() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.fetchIndustries().then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          industryList:
              iterable.map((e) => IndustryEntity.fromJson(e)).toList(),
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      addError(error);
    });
  }

  Future<void> fetchChats() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await Future.delayed(const Duration(seconds: 1));
    await taskRepository.fetchChats().then((value) {
      final Iterable iterable = value;
      emit(state.copyWith(
          chatsList: iterable.map((e) => MessageEntity.fromJson(e)).toList(),
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true)));
    }).catchError((error) {
      addError(error);
    });
  }

  void logOut() {
    emit(state.copyWith(
      asyncSnapshot: const AsyncSnapshot.nothing(),
      taskList: [],
      docList: [],
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
