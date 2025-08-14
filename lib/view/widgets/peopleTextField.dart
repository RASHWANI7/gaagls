
import 'package:flutter/material.dart';

class PeopleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PeopleTextField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      style: TextStyle(
        color: Theme.of(context).iconTheme.color,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: 'Number of people',
        hintStyle: TextStyle(color: Theme.of(context).iconTheme.color),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Color(0xFF145371),
        ),
        prefixIcon: Icon(Icons.group, color: Theme.of(context).iconTheme.color),
        filled: true,
        fillColor: Theme.of(context).secondaryHeaderColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
