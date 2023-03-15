import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final dynamic id;
  final dynamic username;
  final dynamic email;
  final dynamic accessToken;
  final dynamic refreshToken;

  UserDTO({
    this.id,
    this.username,
    this.email,
    this.accessToken,
    this.refreshToken,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      email: email.toString(),
      username: username.toString(),
      id: id.toString(),
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
