import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/presentation/components/app_button.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/auth/presentation/email_verification_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  void _onTapToSignUpButton(AuthCubit authCubit) => authCubit.signUp(
      email: emailController.text,
      username: usernameController.text,
      password: passwordController.text);

  static Future<User?> signUp({
    required String password,
    required String email,
    required String username,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Пароль слишком слабый')));
      } else if (error.code == 'email-already-in-use') {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                // label create account
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Создание аккаунта',
                        style: theme.textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 55),

                //username textfield
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
                    minLines: 1),

                const SizedBox(height: 10),

                // email textfield
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

                const SizedBox(height: 10),

                // password textfield
                AppTextField(
                  hintText: 'Пароль',
                  obscureText: true,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  controller: passwordController,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  minLines: 1,
                ),

                const SizedBox(height: 10),

                //confirm password textfield
                AppTextField(
                  hintText: 'Повторите пароль',
                  obscureText: true,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  controller: passwordRepeatController,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  minLines: 1,
                ),

                const SizedBox(height: 45),

                // sign up button
                AppButton(
                  onTap: () async {
                    if (!formKey.currentState!.validate()) return;
                    final email = emailController.text;
                    final username = usernameController.text;
                    final password = passwordController.text;
                    if (passwordRepeatController.text != password) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Пароли должны совпадать")));
                    } else {
                      signUp(
                              password: password,
                              email: email,
                              username: username,
                              context: context)
                          .then((_) async {
                        _onTapToSignUpButton(context.read<AuthCubit>());
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const EmailVerificationScreen(
                                isEmailUpdated: false),
                          ),
                        );
                      });
                    }
                  },
                  text: 'Зарегистрироваться',
                ),

                const SizedBox(height: 100),

                // already have an account? sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'У вас уже есть аккаунт?',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      child: Text(
                        'Войти',
                        style: theme.textTheme.labelMedium,
                      ),
                      onPressed: () => Navigator.of(context).pushNamed('/'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
