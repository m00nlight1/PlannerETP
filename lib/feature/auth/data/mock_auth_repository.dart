// import 'package:injectable/injectable.dart';
// import 'package:planner_etp/feature/auth/domain/auth_repository.dart';
// import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';
//
// @Injectable(as: AuthRepository)
// @test
// class MockAuthRepository implements AuthRepository {
//   @override
//   Future getProfile() {
//     throw UnimplementedError();
//   }
//
//   @override
//   Future refreshToken({String? refreshToken}) {
//     throw UnimplementedError();
//   }
//
//   @override
//   Future signIn({required String password, required String email}) {
//     return Future.delayed(const Duration(seconds: 2), () {
//       return const UserEntity(
//           email: "testEmail", username: "testUsername", id: "-1");
//     });
//   }
//
//   @override
//   Future signUp(
//       {required String password,
//       required String email,
//       required String username}) {
//     return Future.delayed(const Duration(seconds: 2), () {
//       return UserEntity(email: email, username: username, id: "-1");
//     });
//   }
//
//   @override
//   Future updatePassword(
//       {required String oldPassword, required String newPassword}) {
//     throw UnimplementedError();
//   }
//
//   @override
//   Future updateUser({String? email, String? username}) {
//     throw UnimplementedError();
//   }
// }
