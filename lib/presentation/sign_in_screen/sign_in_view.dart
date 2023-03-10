import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/SignInButton.dart';
import 'widgets/SignInTextField.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                'Welcome back you\'ve been missed!',
                style: theme.textTheme.bodyMedium
              ),

              const SizedBox(height: 25),

              // username textfield
              const SignInTextField(
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              const SignInTextField(
                hintText: 'Password',
                obscureText: true,
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

              const SizedBox(height: 50),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Register now',
                    style: theme.textTheme.labelMedium,
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
