import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/data/firebase_constants.dart';
import 'package:planner_etp/app/domain/error_entity/error_entity.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/app_snack_bar.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/auth/presentation/email_verification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аккаунт'),
        actions: [
          IconButton(
              onPressed: () {
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
                        userEntity?.username?.split("").first ?? "Нет данных",
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
                          "Редактировать",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                const _UpdatePasswordDialog());
                      },
                      child: Text(
                        "Изменить пароль",
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
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  static Future<User?> updateProfile({
    required String email,
    required String username,
    required BuildContext context,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateEmail(email);
        await user.updateDisplayName(username);
        user.emailVerified == false;
      }
      return user;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Учетная запись уже существует')));
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SimpleDialog(
      children: [
        Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                AppTextField(
                  hintText: 'Логин',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon:
                      const Icon(Icons.account_circle, color: Colors.grey),
                  controller: usernameController,
                  validator: (username) =>
                      username != null && username.length < 3
                          ? 'Введите правильный логин'
                          : null,
                  minLines: 1,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  hintText: 'Email',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  controller: emailController,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Введите правильный Email'
                          : null,
                  minLines: 1,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    if (!formKey.currentState!.validate()) return;
                    final email = emailController.text;
                    final username = usernameController.text;
                    final authCubit = context.read<AuthCubit>();
                    updateProfile(
                            email: email, username: username, context: context)
                        .then((_) async {
                      if (auth.currentUser != null) {
                        if (auth.currentUser!.emailVerified == false) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const EmailVerificationScreen(
                                  isEmailUpdated: true),
                            ),
                          );
                        }
                        authCubit
                            .updateUser(email: email, username: username)
                            .then((_) {
                          Navigator.pop(context);
                        });
                      }
                    });
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
                        "Сохранить",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UpdatePasswordDialog extends StatefulWidget {
  const _UpdatePasswordDialog();

  @override
  State<StatefulWidget> createState() => _UpdatePasswordDialogState();
}

class _UpdatePasswordDialogState extends State<_UpdatePasswordDialog> {
  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordRepeatController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    newPasswordController.dispose();
    oldPasswordController.dispose();
    newPasswordRepeatController.dispose();
    super.dispose();
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw Exception('Пользователь не авторизован');
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SimpleDialog(
      children: [
        Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                AppTextField(
                  hintText: 'Текущий пароль',
                  obscureText: true,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  controller: oldPasswordController,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  minLines: 1,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  hintText: 'Новый пароль',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  controller: newPasswordController,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  minLines: 1,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  hintText: 'Повторите пароль',
                  obscureText: true,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  controller: newPasswordRepeatController,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  minLines: 1,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    if (!formKey.currentState!.validate()) return;
                    final newPassword = newPasswordController.text;
                    if (newPasswordRepeatController.text != newPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Пароли должны совпадать")));
                    } else {
                      updatePassword(newPassword);
                      Navigator.pop(context);
                      context.read<AuthCubit>().updatePassword(
                          newPassword: newPassword,
                          oldPassword: oldPasswordController.text);
                    }
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
                        "Сохранить",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
