part of 'task_cubit.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState({
    @JsonKey(ignore: true) AsyncSnapshot? asyncSnapshot,
    @Default([]) List<TaskEntity> taskList,
    @Default([]) List<StatusEntity> statusList,
  }) = _TaskState;

  factory TaskState.fromJson(Map<String, dynamic> json) =>
      _$TaskStateFromJson(json);
}
