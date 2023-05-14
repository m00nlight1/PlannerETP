part of 'task_cubit.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState({
    @JsonKey(ignore: true) AsyncSnapshot? asyncSnapshot,
    @Default([]) List<TaskEntity> taskList,
    @Default([]) List<StatusEntity> statusList,
    @Default([]) List<TaskTypeEntity> taskTypeList,
    @Default([]) List<IndustryEntity> industryList,
    @Default([]) List<DocumentEntity> docList,
    @Default([]) List<MessageEntity> chatsList,
    @Default([]) List<UserEntity> usersList,
  }) = _TaskState;

  factory TaskState.fromJson(Map<String, dynamic> json) =>
      _$TaskStateFromJson(json);
}
