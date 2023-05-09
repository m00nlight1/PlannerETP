import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';

part 'document_entity.freezed.dart';

part 'document_entity.g.dart';

@freezed
class DocumentEntity with _$DocumentEntity {
  const factory DocumentEntity({
    required int id,
    required String name,
    required String filePath,
    required DateTime createdAt,
    int? idTask,
    UserEntity? user,
    TaskEntity? task,
  }) = _DocumentEntity;

  factory DocumentEntity.fromJson(Map<String, dynamic> json) =>
      _$DocumentEntityFromJson(json);
}
