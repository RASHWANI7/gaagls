// // import 'package:flutter/material.dart';
// //
// // class DateTextField extends StatelessWidget {
// //   final TextEditingController controller;
// //   final VoidCallback onTap;
// //
// //   const DateTextField({
// //     Key? key,
// //     required this.controller,
// //     required this.onTap,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return TextField(
// //       controller: controller,
// //       readOnly: true, // لمنع ظهور لوحة المفاتيح عند النقر
// //       decoration: InputDecoration(
// //         labelText: 'date',
// //         labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
// //         filled: true,
// //         prefixIcon: const Icon(Icons.calendar_today),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10.0),
// //           borderSide: BorderSide(
// //             color: Theme.of(context).colorScheme.onSurface,
// //             width: 2.0,
// //           ),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(20.0),
// //           borderSide: BorderSide(
// //             color: Theme.of(context).colorScheme.onSurface,
// //             width: 2.0,
// //           ),
// //         ),
// //       ),
// //       onTap: onTap,
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// class DateTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onTap;
//   final String? Function(String?)? validator;
//
//   const DateTextField({
//     Key? key,
//     required this.controller,
//     required this.onTap,
//     this.validator,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       readOnly: true,
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: 'date',
//         labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         filled: true,
//         prefixIcon: const Icon(Icons.calendar_today),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.onSurface,
//             width: 2.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20.0),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.onSurface,
//             width: 2.0,
//           ),
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }



import 'package:flutter/material.dart';

class DateTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? Function(String?)? validator;

  const DateTextField({
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
      style:  TextStyle(
        color: Theme.of(context).iconTheme.color,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: 'Select date',
        hintStyle: TextStyle(color: Theme.of(context).iconTheme.color),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Theme.of(context).iconTheme.color,
        ),
        prefixIcon:  Icon(Icons.calendar_month, color: Theme.of(context).iconTheme.color, size: 24),
        filled: true,
        fillColor: Theme.of(context).secondaryHeaderColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide:  BorderSide(color: Theme.of(context).primaryColor, width: 2),
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
