// // ignore_for_file: camel_case_types

// import 'package:flutter/material.dart';

// class customtextfield extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final bool isMultiline;
//   final Icon? icon;

//   final FocusNode? focusNode;
//   const customtextfield({
//     super.key,
//     required this.hintText,
//     this.icon,
//     required this.controller,
//     this.isMultiline = false,
//     this.focusNode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       focusNode: focusNode,
//       minLines: isMultiline ? 5 : 1,
//       maxLines: isMultiline ? 10 : 1,

//       decoration: InputDecoration(
//         hintText: hintText,
//         suffixIcon: icon,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(19)),
//       ),
//     );
//   }
// }

// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isMultiline;
  final FocusNode? focusNode;
  final Widget? icon;
  final bool obscureText;

  const customtextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.isMultiline = false,
    this.focusNode,
    this.obscureText = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      focusNode: focusNode,
      minLines: isMultiline ? 3 : 1,
      maxLines: isMultiline ? 10 : 1,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: icon,
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
