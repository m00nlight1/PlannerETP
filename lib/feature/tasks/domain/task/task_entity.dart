import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planner_etp/feature/tasks/domain/author/author_entity.dart';

part 'task_entity.freezed.dart';

part 'task_entity.g.dart';

@freezed
class TaskEntity with _$TaskEntity {
  const TaskEntity._();

  const factory TaskEntity({
    required String id,
    required String title,
    String? content,
    required String createdAt,
    String? startOfWork,
    String? endOfWork,
    String? contractorCompany,
    String? responsibleMaster,
    String? representative,
    String? equipmentLevel,
    String? staffLevel,
    String? resultsOfTheWork,
    AuthorEntity? author,
  }) = _TaskEntity;

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);
}
