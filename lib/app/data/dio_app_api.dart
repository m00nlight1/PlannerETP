import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:planner_etp/app/data/auth_interceptor.dart';
import 'package:planner_etp/app/domain/app_api.dart';
import 'package:planner_etp/app/domain/app_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  late final Dio dio;

  DioAppApi(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: 30000,
      // connectTimeout: const Duration(milliseconds: 30000),
    );
    dio = Dio(options);
    if (kDebugMode) dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<Response> getProfile() {
    try {
      return dio.get("/data/user");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> refreshToken({String? refreshToken}) {
    try {
      return dio.post("/data/token/$refreshToken");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signIn({required String password, required String email}) {
    try {
      return dio.post("/data/token", data: {
        "email": email,
        "password": password,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signUp(
      {required String password,
      required String email,
      required String username}) {
    try {
      return dio.put("/data/token", data: {
        "email": email,
        "password": password,
        "username": username,
      });
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> updatePassword(
      {required String oldPassword, required String newPassword}) {
    return dio.put("/data/user", queryParameters: {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    });
  }

  @override
  Future<Response> updateUser({String? email, String? username}) {
    return dio.post("/data/user", data: {
      "email": email,
      "username": username,
    });
  }

  @override
  Future request(String path) {
    try {
      return dio.request(path);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future fetch(RequestOptions requestOptions) {
    return dio.fetch(requestOptions);
  }

  @override
  Future fetchTasks() {
    return dio.get("/data/tasks");
  }

  @override
  Future createTask(Map args) {
    return dio.post("/data/tasks", data: {
      "title": args["title"],
      "content": args["content"],
      "startOfWork": args["startOfWork"],
      "endOfWork": args["endOfWork"],
      "imageUrl": args["imageUrl"],
      "fileUrl": args["fileUrl"],
      "contractorCompany": args["contractorCompany"],
      "responsibleMaster": args["responsibleMaster"],
      "representative": args["representative"],
      "equipmentLevel": args["equipmentLevel"],
      "staffLevel": args["staffLevel"],
      "resultsOfTheWork": args["resultsOfTheWork"],
      "expenses": args["expenses"],
      "idCategory": args["idCategory"],
      "idStatus": args["idStatus"],
      "idIndustry": args["idIndustry"],
      "idTaskType": args["idTaskType"],
    });
  }

  @override
  Future fetchTask(String id) {
    return dio.get("/data/tasks/$id");
  }

  @override
  Future deleteTask(String id) {
    return dio.delete("/data/tasks/$id");
  }

  @override
  Future updateTask(String id, Map args) {
    return dio.put("/data/tasks/$id", data: {
      "title": args["title"],
      "content": args["content"],
      "startOfWork": args["startOfWork"],
      "endOfWork": args["endOfWork"],
      "imageUrl": args["imageUrl"],
      "fileUrl": args["fileUrl"],
      "contractorCompany": args["contractorCompany"],
      "responsibleMaster": args["responsibleMaster"],
      "representative": args["representative"],
      "equipmentLevel": args["equipmentLevel"],
      "staffLevel": args["staffLevel"],
      "resultsOfTheWork": args["resultsOfTheWork"],
      "expenses": args["expenses"],
      "idCategory": args["idCategory"],
      "idStatus": args["idStatus"],
      "idIndustry": args["idIndustry"],
      "idTaskType": args["idTaskType"],
    });
  }

  @override
  Future sentMessage(Map args) {
    return dio.post("/data/messages", data:  {
      "content": args["content"],
      "imageUrl": args["imageUrl"],
      "idTask": args["idTask"],
    });
  }

  @override
  Future getTaskChat(String id) {
    return dio.get("/data/messages/$id");
  }

  @override
  Future fetchStatuses() {
    return dio.get("/data/status");
  }

  @override
  Future fetchIndustries() {
    return dio.get("/data/industry");
  }

  @override
  Future fetchTaskTypes() {
    return dio.get("/data/tasktype");
  }
}
