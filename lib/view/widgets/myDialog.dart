import 'package:flutter/material.dart';
import 'package:gaagls/view/pages/otp_page.dart';

import '../../constants/constants.dart';
void MyDialog(String message,final void Function()? onTap,BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) =>
        WillPopScope(
          onWillPop: () async => false, // يمنع الرجوع بزر الجهاز
          child: AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              message,
              style: const TextStyle(fontSize: 17, color: Colors.white),
            ),
            contentPadding: const EdgeInsets.only(top: 20, left: 40),
            actions: [
              TextButton(

                onPressed: onTap,

                // register dialog
                // onPressed: () {
                //   Navigator.pop(context);
                //   Navigator.of(context).pushReplacement(
                //       MaterialPageRoute(builder: (context) =>  OtpScreen(userId: userId,)));
                // },
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
  );
}