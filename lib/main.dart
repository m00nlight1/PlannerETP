import 'package:planner_etp/app/presentation/main_app_builder.dart';
import 'package:planner_etp/app/presentation/main_app_runner.dart';

void main() {
  const environment = String.fromEnvironment("env", defaultValue: "dev");
  const runner = MainAppRunner(environment);
  final builder = MainAppBuilder();
  runner.run(builder);
}
