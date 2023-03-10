import 'package:flutter/material.dart';

import 'config/app_theme.dart';
import 'presentation/sign_in_screen/sign_in_view.dart';

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
      home: const SignIn(),
    );
  }
}

