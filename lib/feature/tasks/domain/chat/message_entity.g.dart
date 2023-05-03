// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageEntity _$$_MessageEntityFromJson(Map<String, dynamic> json) =>
    _$_MessageEntity(
      id: json['id'] as int,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sentTo: DateTime.parse(json['sentTo'] as String),
      idTask: json['idTask'] as int?,
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      task: json['task'] == null
          ? null
          : TaskEntity.fromJson(json['task'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MessageEntityToJson(_$_MessageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'sentTo': instance.sentTo.toIso8601String(),
      'idTask': instance.idTask,
      'user': instance.user,
      'task': instance.task,
    };
