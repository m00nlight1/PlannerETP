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
      statusList: (json['statusList'] as List<dynamic>?)
              ?.map((e) => StatusEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      taskTypeList: (json['taskTypeList'] as List<dynamic>?)
              ?.map((e) => TaskTypeEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      industryList: (json['industryList'] as List<dynamic>?)
              ?.map((e) => IndustryEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      docList: (json['docList'] as List<dynamic>?)
              ?.map((e) => DocumentEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      chatsList: (json['chatsList'] as List<dynamic>?)
              ?.map((e) => MessageEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      usersList: (json['usersList'] as List<dynamic>?)
              ?.map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TaskStateToJson(_$_TaskState instance) =>
    <String, dynamic>{
      'taskList': instance.taskList,
      'statusList': instance.statusList,
      'taskTypeList': instance.taskTypeList,
      'industryList': instance.industryList,
      'docList': instance.docList,
      'chatsList': instance.chatsList,
      'usersList': instance.usersList,
    };
