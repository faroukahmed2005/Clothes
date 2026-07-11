import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:clothes/Core/Healpers/app_button.dart';
import 'package:clothes/Core/Healpers/app_colors.dart';
import 'package:clothes/Core/Healpers/app_field.dart';
import 'package:clothes/Core/Healpers/app_password_field.dart';
import 'package:clothes/Core/Healpers/app_styles.dart';
import 'package:clothes/Core/Healpers/app_toster.dart';
import 'package:clothes/Features/Screens/Login/login_cubit.dart';
import 'package:clothes/Features/Screens/main_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothes/Features/Screens/SignUp/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showSnackBar(
              msg: "Login Success",
              type: AnimatedSnackBarType.success,
              context: context,
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const MainNavScreen(),
              ),
            );
          }

          if (state is LoginFailure) {
            showSnackBar(
              msg: state.msg,
              type: AnimatedSnackBarType.error,
              context: context,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Login to your account",
                style: AppStyles.kText28blackBold,
              ),
            ),
            backgroundColor: AppColors.whiteColor,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("It’s great to see you again."),
                  const SizedBox(height: 12),

                  Text(
                    "Email",
                    style: AppStyles.kText16blackBold,
                  ),
                  const SizedBox(height: 12),

                  AppField(
                    controller: cubit.userEmailControl,
                    hint: "Enter Email",
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Password",
                    style: AppStyles.kText16blackBold,
                  ),
                  const SizedBox(height: 12),

                  AppPasswordField(
                    controller: cubit.userPasswordControl,
                    hint: "Enter Your Password",
                  ),

                  const SizedBox(height: 20),

                  state is LoginLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AppButton(
                          title: "Login",
                          onPressed: () {
                            cubit.login();
                          },
                        ),

                  const SizedBox(height: 16),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Don’t have an account? "),
                            TextSpan(
                              text: "Join",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}