// import 'package:flutter/material.dart';
//
// class CustomCountryPicker extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onTap;
//
//   const CustomCountryPicker({
//     Key? key,
//     required this.controller,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AbsorbPointer(
//         child: TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: 'Select Destination',
//             hintStyle: TextStyle(color: Theme.of(context).iconTheme.color),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: BorderSide(
//                 color: Theme.of(context).primaryColor,
//                 width: 1.5,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide:  BorderSide(
//                 color: Theme.of(context).primaryColor,
//                 width: 2,
//               ),
//             ),
//             suffixIcon: Icon(
//               Icons.arrow_drop_down,
//               color: Theme.of(context).iconTheme.color,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
//



import 'package:flutter/material.dart';

class CustomCountryPicker extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const CustomCountryPicker({
    Key? key,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: 'Select Destination',
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
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
