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
            onPressed: () => context.read<AuthCubit>().refreshToken(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () => context.read<AuthCubit>().logOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("email: ${userEntity.email}"),
          const SizedBox(height: 20),
          Text("accessToken: ${userEntity.accessToken}"),
          const SizedBox(height: 20),
          Text("refreshToken: ${userEntity.refreshToken}"),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
