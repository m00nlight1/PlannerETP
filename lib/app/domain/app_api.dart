abstract class AppApi {
  Future<dynamic> signUp(
      {required String password,
      required String email,
      required String username});

  Future<dynamic> signIn({required String password, required String email});

  Future<dynamic> getProfile();

  Future<dynamic> updateUser({String? email, String? username});

  Future<dynamic> updatePassword(
      {required String oldPassword, required String newPassword});

  Future<dynamic> refreshToken({String? refreshToken});

  Future<dynamic> request(String path);
}
