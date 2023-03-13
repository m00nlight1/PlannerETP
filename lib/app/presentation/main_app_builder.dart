import 'package:flutter/material.dart';
import 'package:planner_etp/app/domain/app_builder.dart';
import 'package:planner_etp/app/presentation/config/router/app_router.dart';
import 'package:planner_etp/app/presentation/config/theme/app_theme.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routes: routes,
    );
  }
}