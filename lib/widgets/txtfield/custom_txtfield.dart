// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isMultiline;

  final FocusNode? focusNode;
  const customtextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.isMultiline = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      minLines: isMultiline ? 5 : 1,
      maxLines: isMultiline ? 10 : 1,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(19)),
      ),
    );
  }
}
