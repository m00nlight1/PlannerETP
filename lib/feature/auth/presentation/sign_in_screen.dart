import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planner_etp/app/presentation/components/AuthTextField.dart';
import 'package:planner_etp/app/presentation/components/AuthButton.dart';
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

                // welcome back, you've been missed!
                Text('Welcome, back you\'ve been missed!',
                    style: theme.textTheme.bodyMedium),

                const SizedBox(height: 25),

                // email textfield
                AuthTextField(
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
                AuthTextField(
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  controller: passwordController,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                AuthButton(
                  onTap: () {
                    if (formKey.currentState?.validate() == true) {
                      _onTapToSignInButton(context.read<AuthCubit>());
                    }
                  },
                  text: 'Sign In',
                ),

                const SizedBox(height: 100),

                // uou don't have an account? sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You don\'t have an account?',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      child: Text(
                        'Sign Up',
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
