import 'package:flutter/material.dart';
import 'package:planner_etp/presentation/widgets/AuthTextField.dart';
import 'package:planner_etp/presentation/widgets/SignUpButton.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
              const AuthTextField(
                hintText: 'Email',
                obscureText: false,
                prefixIcon: Icon(Icons.email, color: Colors.grey),
              ),

              const SizedBox(height: 10),

              // password textfield
              const AuthTextField(
                hintText: 'Password',
                obscureText: true,
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
              ),

              const SizedBox(height: 10),

              //confirm password textfield
              const AuthTextField(
                hintText: 'Confirm password',
                obscureText: true,
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
              ),

              const SizedBox(height: 45),

              // sign up button
              SignUpButton(
                onTap: (signUserUp),

              ),

              const SizedBox(height: 100),

              // already have an account? login
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
                      'Login',
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