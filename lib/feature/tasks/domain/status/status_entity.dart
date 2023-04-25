import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_entity.freezed.dart';

part 'status_entity.g.dart';

@freezed
class StatusEntity with _$StatusEntity {

  const factory StatusEntity({
    int? id,
    String? name,
  }) = _StatusEntity;

  factory StatusEntity.fromJson(Map<String, dynamic> json) =>
      _$StatusEntityFromJson(json);
}