import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.icon,
    required this.isObscure,
  });
  final String labelText;
  final Icon icon;
  final TextEditingController controller;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: labelText,
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
