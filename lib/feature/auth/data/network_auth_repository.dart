import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:planner_etp/app/domain/app_api.dart';
import 'package:planner_etp/feature/auth/data/dto/user_dto.dart';
import 'package:planner_etp/feature/auth/domain/auth_repository.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';

@Injectable(as: AuthRepository)
class NetworkAuthRepository implements AuthRepository {
  final AppApi appApi;

  NetworkAuthRepository(this.appApi);

  @override
  Future<UserEntity> getProfile() async {
    try {
      final response = await appApi.getProfile();
      return UserDTO.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> refreshToken({String? refreshToken}) async {
    try {
      final response = await appApi.refreshToken(refreshToken: refreshToken);
      return UserDTO.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signIn({
    required String password,
    required String email,
  }) async {
    try {
      final response = await appApi.signIn(password: password, email: email);
      return UserDTO.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUp({
    required String password,
    required String email,
    required String username,
  }) async {
    try {
      final response = await appApi.signUp(
          password: password, email: email, username: username);
      return UserDTO.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final Response response = await appApi.updatePassword(
          newPassword: newPassword, oldPassword: oldPassword);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateUser({String? email, String? username}) async {
    try {
      final response =
          await appApi.updateUser(email: email, username: username);
      return UserDTO.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }
}
