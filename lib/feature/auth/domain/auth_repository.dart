abstract class AuthRepository {
  Future<dynamic> signUp(
      {required String password,
      required String email,
      required String username});

  Future<dynamic> signIn({required String password, required String email});

  Future<dynamic> getProfile();

  Future<dynamic> updateUser({String? email, String? username});

  Future<dynamic> updatePassword(
      {required String oldPassword, required String newPassword});

  Future<dynamic> refreshToken({required String refreshToken});
}
