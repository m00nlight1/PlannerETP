// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentEntity _$$_DocumentEntityFromJson(Map<String, dynamic> json) =>
    _$_DocumentEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      filePath: json['filePath'] as String,
      idTask: json['idTask'] as int?,
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      task: json['task'] == null
          ? null
          : TaskEntity.fromJson(json['task'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DocumentEntityToJson(_$_DocumentEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'filePath': instance.filePath,
      'idTask': instance.idTask,
      'user': instance.user,
      'task': instance.task,
    };
