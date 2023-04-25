import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/app/presentation/components/app_button.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  void _onTapToSignInButton(AuthCubit authCubit) => authCubit.signIn(
      email: emailController.text, password: passwordController.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/etp-logo.svg',
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'ETP\nPlanner',
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // email textfield
                AppTextField(
                  hintText: 'Email',
                  obscureText: false,
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  controller: emailController,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Введите правильный Email'
                          : null,
                ),

                const SizedBox(height: 10),

                // password textfield
                AppTextField(
                  hintText: 'Пароль',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  controller: passwordController,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                ),

                const SizedBox(height: 10),

                // forgot password?
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Забыли пароль?',
                //         style: theme.textTheme.bodyMedium,
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 25),

                // sign in button
                AppButton(
                  onTap: () {
                    if (formKey.currentState?.validate() == true) {
                      _onTapToSignInButton(context.read<AuthCubit>());
                    }
                  },
                  text: 'Войти',
                ),

                const SizedBox(height: 100),

                // uou don't have an account? sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Нет аккаунта?',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      child: Text(
                        'Зарегистрироваться',
                        style: theme.textTheme.labelMedium,
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/sign-up'),
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
