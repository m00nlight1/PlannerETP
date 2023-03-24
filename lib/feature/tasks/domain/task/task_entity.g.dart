// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskEntity _$$_TaskEntityFromJson(Map<String, dynamic> json) =>
    _$_TaskEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String,
      startOfWork: json['startOfWork'] as String?,
      endOfWork: json['endOfWork'] as String?,
      contractorCompany: json['contractorCompany'] as String?,
      responsibleMaster: json['responsibleMaster'] as String?,
      representative: json['representative'] as String?,
      equipmentLevel: json['equipmentLevel'] as String?,
      staffLevel: json['staffLevel'] as String?,
      resultsOfTheWork: json['resultsOfTheWork'] as String?,
      author: json['author'] == null
          ? null
          : AuthorEntity.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TaskEntityToJson(_$_TaskEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'startOfWork': instance.startOfWork,
      'endOfWork': instance.endOfWork,
      'contractorCompany': instance.contractorCompany,
      'responsibleMaster': instance.responsibleMaster,
      'representative': instance.representative,
      'equipmentLevel': instance.equipmentLevel,
      'staffLevel': instance.staffLevel,
      'resultsOfTheWork': instance.resultsOfTheWork,
      'author': instance.author,
    };
