import 'package:flutter/material.dart';
import 'package:gaagls/model/cities.dart';

class signUpButton extends StatelessWidget {
  const signUpButton({
    super.key,
    required this.city,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap
  });

  final Cities? city;
  final double screenWidth;
  final double screenHeight;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: screenHeight * 0.02,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Create Account',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}