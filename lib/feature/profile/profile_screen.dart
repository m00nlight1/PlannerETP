import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthCubit>().logOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final userEntity = state.whenOrNull(
            authorized: (userEntity) => userEntity,
          );
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text(
                        userEntity?.username.split("").first ?? "Нет данных",
                        style: theme.textTheme.bodyLarge),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        userEntity?.username ?? "",
                        style: theme.textTheme.labelSmall,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userEntity?.email ?? "",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 55),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Change password",
                        style: theme.textTheme.bodyMedium,
                      )),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
            ]),
          );
        },
      ),
    );
  }
}
