import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/domain/error_entity/error_entity.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/AppSnackBar.dart';
import 'package:planner_etp/app/presentation/components/AuthTextField.dart';
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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authorized: (userEntity) {
              if (userEntity.userState?.hasData == true) {
                AppSnackBar.showSnackBarWithMessage(
                    context, userEntity.userState?.data);
              }
              if (userEntity.userState?.hasError == true) {
                AppSnackBar.showSnackBarWithError(context,
                    ErrorEntity.fromException(userEntity.userState?.error));
              }
            },
          );
        },
        builder: (context, state) {
          final userEntity = state.whenOrNull(
            authorized: (userEntity) => userEntity,
          );
          if (userEntity?.userState?.connectionState ==
              ConnectionState.waiting) {
            return const AppLoader();
          }
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
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => const _UpdateProfileDialog());
                    },
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

class _UpdateProfileDialog extends StatefulWidget {
  const _UpdateProfileDialog();

  @override
  State<StatefulWidget> createState() => _UpdateProfileDialogState();
}

class _UpdateProfileDialogState extends State<_UpdateProfileDialog> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SimpleDialog(
      children: [
        AuthTextField(
          hintText: 'Username',
          obscureText: false,
          prefixIcon: const Icon(Icons.account_circle, color: Colors.grey),
          controller: usernameController,
          validator: (username) => username != null && username.length < 3
              ? 'Введите правильный логин'
              : null,
        ),
        const SizedBox(height: 10),
        AuthTextField(
          hintText: 'Email',
          obscureText: false,
          prefixIcon: const Icon(Icons.email, color: Colors.grey),
          controller: emailController,
          validator: (email) => email != null && !EmailValidator.validate(email)
              ? 'Введите правильный Email'
              : null,
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            context.read<AuthCubit>().updateUser(
                email: emailController.text, username: usernameController.text);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 55),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Save",
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
