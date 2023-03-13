import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planner_etp/app/presentation/widgets/AuthTextField.dart';
import 'package:planner_etp/app/presentation/widgets/SignInButton.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/etp-logo.svg', height: 120, width: 120,),

                  const SizedBox(width: 20),

                  Text(
                    'ETP\nPlanner',
                    style: theme.textTheme.labelLarge,
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'Welcome, back you\'ve been missed!',
                style: theme.textTheme.bodyMedium
              ),

              const SizedBox(height: 25),

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
              SignInButton(
                onTap: (signUserIn),
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
                    onPressed: () => Navigator.of(context).pushNamed('/sign-up'),
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
