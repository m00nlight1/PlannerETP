// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_task_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailTaskState _$$_DetailTaskStateFromJson(Map<String, dynamic> json) =>
    _$_DetailTaskState(
      taskEntity: json['taskEntity'] == null
          ? null
          : TaskEntity.fromJson(json['taskEntity'] as Map<String, dynamic>),
      messageList: (json['messageList'] as List<dynamic>?)
              ?.map((e) => MessageEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_DetailTaskStateToJson(_$_DetailTaskState instance) =>
    <String, dynamic>{
      'taskEntity': instance.taskEntity,
      'messageList': instance.messageList,
    };
