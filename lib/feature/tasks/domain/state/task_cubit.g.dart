// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskState _$$_TaskStateFromJson(Map<String, dynamic> json) => _$_TaskState(
      taskList: (json['taskList'] as List<dynamic>?)
              ?.map((e) => TaskEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TaskStateToJson(_$_TaskState instance) =>
    <String, dynamic>{
      'taskList': instance.taskList,
    };
