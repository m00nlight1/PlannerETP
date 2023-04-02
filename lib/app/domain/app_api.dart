import 'package:dio/dio.dart';

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

  Future<dynamic> fetch(RequestOptions requestOptions);

  Future<dynamic> fetchTasks();

  Future<dynamic> fetchTask(String id);

  Future<dynamic> createTask(Map args);

  Future<dynamic> updateTask(String id, Map args);

  Future<dynamic> deleteTask(String id);

  Future<dynamic> sentMessage(Map args);

  Future<dynamic> getTaskChat(String id);
}
