import 'package:flutter/material.dart';

// void MySnackBar(String error, BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       backgroundColor: const Color(0xFF377E9F),
//       duration: const Duration(seconds: 3),
//       behavior: SnackBarBehavior.floating, // يجعل الـ SnackBar عائمًا
//       margin: const EdgeInsets.fromLTRB(15,5,15,30), // تحديد الهوامش
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12), // تقريب الحواف
//       ),
//       elevation: 45, // تأثير الظل
//       content: SizedBox(
//         height: 60,
//         child: Center(
//           child: Text(error,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//         ),
//       )));
// }


import 'package:another_flushbar/flushbar.dart';

// void MySnackBar( String message,BuildContext context, {bool isError = false}) {
//   Flushbar(
//     message: message,
//     duration: const Duration(seconds: 3),
//     margin: const EdgeInsets.all(8),
//     borderRadius: BorderRadius.circular(12),
//     backgroundColor: isError ? Colors.red.shade400 : Colors.blue.shade400,
//     flushbarPosition: FlushbarPosition.BOTTOM,
//     icon: Icon(
//       isError ? Icons.error_outline : Icons.check_circle_outline,
//       color: Colors.white,
//     ),
//   ).show(context);
// }


void MySnackBar(String message, BuildContext context, {bool isError = false}) {
  Flushbar(
    messageText: Text(
      message,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: const Duration(seconds: 5),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
    borderRadius: BorderRadius.circular(16),
    backgroundColor: isError ? Colors.red.shade400 : Theme.of(context).primaryColor,
    flushbarPosition: FlushbarPosition.BOTTOM,
    icon: Icon(
      isError ? Icons.error_outline : Icons.check_circle_outline,
      size: 28,
      color: Theme.of(context).colorScheme.onPrimary,
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
