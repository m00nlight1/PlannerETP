import 'package:flutter/material.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key, required this.userEntity}) : super(key: key);

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Center(
        child: Text(userEntity.email),
      ),
    );
  }
}
