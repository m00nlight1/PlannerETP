import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:planner_etp/feature/tasks/domain/category/category_entity.dart';

part 'task_entity.freezed.dart';

part 'task_entity.g.dart';

@freezed
class TaskEntity with _$TaskEntity {
  const TaskEntity._();

  const factory TaskEntity({
    required int id,
    required String title,
    String? content,
    required DateTime createdAt,
    DateTime? startOfWork,
    DateTime? endOfWork,
    String? contractorCompany,
    String? responsibleMaster,
    String? representative,
    String? equipmentLevel,
    String? staffLevel,
    String? resultsOfTheWork,
    int? idCategory,
    CategoryEntity? category,
    UserEntity? user,
  }) = _TaskEntity;

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);
}
