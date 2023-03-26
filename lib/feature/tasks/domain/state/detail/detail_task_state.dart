part of 'detail_task_cubit.dart';

@freezed
class DetailTaskState with _$DetailTaskState {
  const factory DetailTaskState({
    @Default(AsyncSnapshot.nothing()) AsyncSnapshot asyncSnapshot,
    TaskEntity? taskEntity,
  }) = _DetailTaskState;
}
