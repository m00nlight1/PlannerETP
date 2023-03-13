import 'package:flutter/material.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/domain/app_builder.dart';
import 'package:planner_etp/app/domain/app_runner.dart';

class MainAppRunner implements AppRunner {
  final String environment;

  const MainAppRunner(this.environment);

  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();

    initDi(environment);
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    await preloadData();
    runApp(appBuilder.buildApp());
  }

}