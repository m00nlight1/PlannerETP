import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
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
    final storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory());
    HydratedBlocOverrides.runZoned(
      () => runApp(appBuilder.buildApp()),
      storage: storage,
    );
  }
}
