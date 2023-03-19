import 'package:injectable/injectable.dart';
import 'package:planner_etp/app/data/dio_container.dart';
import 'package:planner_etp/feature/auth/data/dto/user_dto.dart';
import 'package:planner_etp/feature/auth/domain/auth_repository.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';

@Injectable(as: AuthRepository)
class NetworkAuthRepository implements AuthRepository {
  final DioContainer dioContainer;

  NetworkAuthRepository(this.dioContainer);

  @override
  Future getProfile() async {
    try {
      final response = await dioContainer.dio.get("/data/user");
      return UserDTO.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future refreshToken({String? refreshToken}) async {
    try {
      final response = await dioContainer.dio.post("/data/token/$refreshToken");
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
      final response = await dioContainer.dio.post("/data/token", data: {
        "email": email,
        "password": password,
      });
      return UserDTO.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future signUp({
    required String password,
    required String email,
    required String username,
  }) async {
    try {
      final response = await dioContainer.dio.put("/data/token", data: {
        "email": email,
        "password": password,
        "username": username,
      });
      return UserDTO.fromJson(response.data["data"]).toEntity();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future updatePassword(
      {required String oldPassword, required String newPassword}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future updateUser({String? email, String? username}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
