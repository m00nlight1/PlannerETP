part of 'detail_task_cubit.dart';

@freezed
class DetailTaskState with _$DetailTaskState {
  const factory DetailTaskState({
    @Default(AsyncSnapshot.nothing()) @JsonKey(ignore: true) AsyncSnapshot asyncSnapshot,
    TaskEntity? taskEntity,
    @Default([]) List<MessageEntity> messageList,
  }) = _DetailTaskState;

  factory DetailTaskState.fromJson(Map<String, dynamic> json) =>
      _$DetailTaskStateFromJson(json);
}
