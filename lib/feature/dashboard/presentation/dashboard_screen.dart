import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key, required this.userEntity}) : super(key: key);

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () => context.read<AuthCubit>().logOut(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text(userEntity.email),
      ),
    );
  }
}
