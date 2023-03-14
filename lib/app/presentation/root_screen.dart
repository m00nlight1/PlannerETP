import 'package:flutter/material.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/feature/auth/presentation/sign_in_screen.dart';
import 'package:planner_etp/feature/auth/presentation/components/auth_builder.dart';
import 'package:planner_etp/feature/dashboard/presentation/dashboard_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
        isNotAuthorized: (context) => const SignInScreen(),
        isWaiting: (context) => const AppLoader(),
        isAuthorized: (context, value, child) =>
            DashboardScreen(userEntity: value));
  }
}
