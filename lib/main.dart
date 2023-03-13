import 'package:planner_etp/app/presentation/main_app_builder.dart';
import 'package:planner_etp/app/presentation/main_app_runner.dart';

void main() {
  final runner = MainAppRunner();
  final builder = MainAppBuilder();
  runner.run(builder);
}


