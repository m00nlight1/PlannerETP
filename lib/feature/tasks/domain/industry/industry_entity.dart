import 'package:freezed_annotation/freezed_annotation.dart';

part 'industry_entity.freezed.dart';

part 'industry_entity.g.dart';

@freezed
class IndustryEntity with _$IndustryEntity {

  const factory IndustryEntity({
    int? id,
    String? name,
  }) = _IndustryEntity;

  factory IndustryEntity.fromJson(Map<String, dynamic> json) =>
      _$IndustryEntityFromJson(json);
}