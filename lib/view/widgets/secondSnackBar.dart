import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void SecondSnackBar(String message, BuildContext context, {bool isError = false}) {
  Flushbar(
    messageText: Text(
      message,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: const Duration(seconds: 5),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    borderRadius: BorderRadius.circular(16),
    backgroundColor: isError ? Colors.red.shade400 : Theme.of(context).colorScheme.primary,
    flushbarPosition: FlushbarPosition.TOP,
    icon: Icon(
      isError ? Icons.error_outline : Icons.check_circle_outline,
      size: 28,
      color: Colors.white,
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
    animationDuration: const Duration(milliseconds: 500),
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeIn,
  ).show(context);
}