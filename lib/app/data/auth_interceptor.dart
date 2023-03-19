import 'package:dio/dio.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';

class AuthInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = locator
        .get<AuthCubit>()
        .state
        .whenOrNull(authorized: (userEntity) => userEntity.accessToken);
    if (accessToken == null) {
      super.onRequest(options, handler);
    } else {
      final headers = options.headers;
      headers["Authorization"] = "Bearer $accessToken";
      super.onRequest(options.copyWith(headers: headers), handler);
    }
  }
}
