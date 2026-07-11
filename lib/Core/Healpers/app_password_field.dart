import 'package:clothes/Core/Healpers/app_colors.dart';
import 'package:clothes/Core/Healpers/app_field.dart';
import 'package:flutter/material.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    required this.controller,
    this.hint = 'Enter Password',
  });

  final TextEditingController controller;
  final String hint;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppField(
      controller: widget.controller,
      hint: widget.hint,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.primaryColor,
        ),
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
    );







  }
}