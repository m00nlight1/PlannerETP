import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/domain/app_builder.dart';
import 'package:planner_etp/app/presentation/config/router/app_router.dart';
import 'package:planner_etp/app/presentation/config/theme/app_theme.dart';
import 'package:planner_etp/app/presentation/root_screen.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    final FlutterLocalization localization = FlutterLocalization.instance;
    return _GlobalProviders(
      child: MaterialApp(
        localizationsDelegates: localization.localizationsDelegates,
        supportedLocales: const [
          Locale('ru', 'RU'),
        ],
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const RootScreen(),
        routes: routes,
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => locator.get<AuthCubit>(),
      ),
      BlocProvider(
        create: (context) =>
            TaskCubit(locator.get<TaskRepository>(), locator.get<AuthCubit>())
              ..fetchTasks()
              ..fetchChats()
              ..fetchUsers()
              ..fetchDocuments(),
      )
    ], child: child);
  }
}
