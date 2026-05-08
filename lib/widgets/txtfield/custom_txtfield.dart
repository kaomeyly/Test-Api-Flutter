// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const customtextfield({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
