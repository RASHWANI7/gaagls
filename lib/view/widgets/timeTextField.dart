
import 'package:flutter/material.dart';

class TimeTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? Function(String?)? validator;

  const TimeTextField({
    Key? key,
    required this.controller,
    required this.onTap,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      validator: validator,
      onTap: onTap,
      style: TextStyle(
        color: Theme.of(context).iconTheme.color,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: 'Select time',
        hintStyle: TextStyle(color: Theme.of(context).iconTheme.color),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Theme.of(context).iconTheme.color,
        ),
        prefixIcon: Icon(Icons.access_time_filled, color: Theme.of(context).iconTheme.color),
        filled: true,
        fillColor: Theme.of(context).secondaryHeaderColor, // خلفية زرقاء فاتحة
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
