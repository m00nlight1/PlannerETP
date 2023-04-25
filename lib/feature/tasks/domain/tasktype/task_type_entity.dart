import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_type_entity.freezed.dart';

part 'task_type_entity.g.dart';

@freezed
class TaskTypeEntity with _$TaskTypeEntity {

  const factory TaskTypeEntity({
    int? id,
    String? name,
  }) = _TaskTypeEntity;

  factory TaskTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeEntityFromJson(json);
}