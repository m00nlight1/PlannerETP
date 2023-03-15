import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:planner_etp/app/presentation/components/AuthButton.dart';
import 'package:planner_etp/app/presentation/components/AuthTextField.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();

  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                      'Create Account',
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 55),

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

              //confirm password textfield
              AuthTextField(
                hintText: 'Confirm password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                controller: passwordRepeatController,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
              ),

              const SizedBox(height: 45),

              // sign up button
              AuthButton(
                onTap: (signUserUp),
                text: 'Sign Up',
              ),

              const SizedBox(height: 100),

              // already have an account? sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    child: Text(
                      'Sign In',
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
    );
  }
}
