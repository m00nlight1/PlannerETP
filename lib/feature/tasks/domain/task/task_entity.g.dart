// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskEntity _$$_TaskEntityFromJson(Map<String, dynamic> json) =>
    _$_TaskEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      startOfWork: json['startOfWork'] == null
          ? null
          : DateTime.parse(json['startOfWork'] as String),
      endOfWork: json['endOfWork'] == null
          ? null
          : DateTime.parse(json['endOfWork'] as String),
      imageUrl: json['imageUrl'] as String?,
      contractorCompany: json['contractorCompany'] as String?,
      responsibleMaster: json['responsibleMaster'] as String?,
      representative: json['representative'] as String?,
      equipmentLevel: json['equipmentLevel'] as String?,
      staffLevel: json['staffLevel'] as String?,
      resultsOfTheWork: json['resultsOfTheWork'] as String?,
      idCategory: json['idCategory'] as int?,
      category: json['category'] == null
          ? null
          : CategoryEntity.fromJson(json['category'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TaskEntityToJson(_$_TaskEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'startOfWork': instance.startOfWork?.toIso8601String(),
      'endOfWork': instance.endOfWork?.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'contractorCompany': instance.contractorCompany,
      'responsibleMaster': instance.responsibleMaster,
      'representative': instance.representative,
      'equipmentLevel': instance.equipmentLevel,
      'staffLevel': instance.staffLevel,
      'resultsOfTheWork': instance.resultsOfTheWork,
      'idCategory': instance.idCategory,
      'category': instance.category,
      'user': instance.user,
    };
