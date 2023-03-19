import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:planner_etp/app/data/auth_interceptor.dart';
import 'package:planner_etp/app/domain/app_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton()
class DioContainer {
  late final Dio dio;

  DioContainer(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: 30000,
      // connectTimeout: const Duration(milliseconds: 30000),
    );
    dio = Dio(options);
    if (kDebugMode) addInterceptor(PrettyDioLogger());
    addInterceptor(AuthInterceptor());
  }

  void addInterceptor(Interceptor interceptor) {
    if (dio.interceptors.contains(interceptor)) {
      dio.interceptors.remove(interceptor);
    }
    deleteInterceptor(interceptor.runtimeType);

    dio.interceptors.add(interceptor);
  }

  void deleteInterceptor(Type type) {
    dio.interceptors.removeWhere((element) => element.runtimeType == type);
  }
}
