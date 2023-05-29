import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planner_etp/app/data/firebase_constants.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/app/presentation/components/app_button.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  void _onTapToSignInButton(AuthCubit authCubit) => authCubit.signIn(
        email: emailController.text,
        password: passwordController.text,
      );

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (_) {
      rethrow;
    }
  }

  // Future<void> sendPasswordResetEmail(String email) async {
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

                // forgot password?
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       TextButton(
                //         onPressed: () async {
                //           final email = emailController.text;
                //           bool isPasswordChanged = false;
                //           if (email.isNotEmpty &&
                //               EmailValidator.validate(email) == true) {
                //             await sendPasswordResetEmail(email);
                //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                 content: Text(
                //                     "Письмо было отправлено на $email")));
                //           } else {
                //             ScaffoldMessenger.of(context).showSnackBar(
                //                 const SnackBar(
                //                     content: Text(
                //                         "Чтобы сбросить пароль, укажите корректный адрес электронной почты")));
                //           }
                //
                //           // Проверка изменения пароля после перехода по ссылке из письма
                //           FirebaseAuth.instance.authStateChanges().listen((User? user) {
                //             if (user != null && user.email == email && user.emailVerified) {
                //               isPasswordChanged = true;
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 const SnackBar(
                //                   content: Text("Пароль успешно изменен"),
                //                 ),
                //               );
                //             }
                //           });
                //         },
                //         child: Text(
                //           'Забыли пароль?',
                //           style: theme.textTheme.bodyMedium,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 25),

                // sign in button
                AppButton(
                  onTap: () async {
                    if (formKey.currentState?.validate() == true) {
                      final email = emailController.text;
                      final password = passwordController.text;
                      final authCubit = context.read<AuthCubit>();
                      await signIn(email, password);
                      if (auth.currentUser != null) {
                        _onTapToSignInButton(authCubit);
                      }
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
