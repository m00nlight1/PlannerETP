import 'package:flutter/material.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';

void main() {
  runApp(const PlannerETP());
}

class PlannerETP extends StatelessWidget {
  const PlannerETP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routes: routes,
    );
  }
}

