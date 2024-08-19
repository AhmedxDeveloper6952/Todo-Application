import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  String hintText;
  Widget prefixIcon;
  void Function()? onTap;
  bool obscureText;

  final TextEditingController controller;
  Textfield({
    super.key,
    required this.onTap,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextField(
        obscureText: obscureText,
        onTap: onTap,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
