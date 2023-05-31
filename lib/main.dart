import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planner_etp/app/presentation/main_app_builder.dart';
import 'package:planner_etp/app/presentation/main_app_runner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  const environment = String.fromEnvironment("env", defaultValue: "prod");
  const runner = MainAppRunner(environment);
  final builder = MainAppBuilder();
  runner.run(builder);
}
