import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final VoidCallback? toggleObscure;
  final controller;

  const BuildTextField({
    Key? key,
    required this.hint,
    this.obscure = false,
    this.toggleObscure,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Theme.of(context).iconTheme.color),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        suffixIcon: toggleObscure != null
            ? IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: toggleObscure,
        )
            : null,
      ),
    );
  }
}
