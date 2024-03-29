import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final int maxLines;
  final int minLines;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
    required this.maxLines,
    required this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
        controller: controller,
        validator: validator,
        maxLines: maxLines,
      ),
    );
  }
}
