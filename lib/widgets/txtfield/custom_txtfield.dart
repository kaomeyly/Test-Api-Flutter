// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isMultiline;
  const customtextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: isMultiline ? 5 : 1,
      maxLines: isMultiline ? 10 : 1,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(19)),
      ),
    );
  }
}
