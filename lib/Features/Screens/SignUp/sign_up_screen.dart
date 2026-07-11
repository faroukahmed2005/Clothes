import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:clothes/Core/Healpers/app_button.dart';
import 'package:clothes/Core/Healpers/app_colors.dart';
import 'package:clothes/Core/Healpers/app_field.dart';
import 'package:clothes/Core/Healpers/app_password_field.dart';
import 'package:clothes/Core/Healpers/app_styles.dart';
import 'package:clothes/Core/Healpers/app_toster.dart';
import 'package:clothes/Features/Screens/Login/Login_screen.dart';
import 'package:clothes/Features/Screens/SignUp/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            showSnackBar(
              msg: "Account created successfully",
              type: AnimatedSnackBarType.success,
              context: context,
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
          }

          if (state is SignUpFailure) {
            showSnackBar(
              msg: state.msg,
              type: AnimatedSnackBarType.error,
              context: context,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();

          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: AppBar(
              title: Text(
                "Create an account",
                style: AppStyles.kText28blackBold,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Let's create your account."),
                  const SizedBox(height: 20),

                  Text("Full Name", style: AppStyles.kText16blackBold),
                  const SizedBox(height: 12),
                  AppField(
                    controller: cubit.fullNameControl,
                    hint: "Enter your full name",
                  ),
                  const SizedBox(height: 20),

                  Text("Email", style: AppStyles.kText16blackBold),
                  const SizedBox(height: 12),
                  AppField(
                    controller: cubit.userEmailControl,
                    hint: "Enter your email address",
                  ),
                  const SizedBox(height: 20),

                  Text("Password", style: AppStyles.kText16blackBold),
                  const SizedBox(height: 12),
                  AppPasswordField(
                    controller: cubit.userPasswordControl,
                    hint: "Enter your password",
                  ),
                  const SizedBox(height: 20),

                  Text("Confirm Password", style: AppStyles.kText16blackBold),
                  const SizedBox(height: 12),
                  AppPasswordField(
                    controller: cubit.confirmPasswordControl,
                    hint: "Enter your password",
                  ),
                  const SizedBox(height: 24),

                  state is SignUpLoading
                      ? const Center(child: CircularProgressIndicator())
                      : AppButton(
                          title: "Create Account",
                          onPressed: () {
                            cubit.signUp();
                          },
                        ),
                  const SizedBox(height: 16),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Log In",
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
