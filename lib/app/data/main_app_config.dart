import 'package:injectable/injectable.dart';
import 'package:planner_etp/app/domain/app_config.dart';

@Singleton(as: AppConfig)
@prod
class ProdAppConfig implements AppConfig {
  @override
  String get baseUrl => "localhost";

  @override
  String get host => Environment.prod;
}

@Singleton(as: AppConfig)
@dev
class DevAppConfig implements AppConfig {
  @override
  String get baseUrl => "localhost";

  @override
  String get host => Environment.dev;
}

@Singleton(as: AppConfig)
@test
class TestAppConfig implements AppConfig {
  @override
  String get baseUrl => "_";

  @override
  String get host => Environment.test;
}
