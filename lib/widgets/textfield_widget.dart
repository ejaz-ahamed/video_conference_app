import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? errorText;
  const TextFieldWidget(
      {super.key, required this.controller, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: 'Enter User id...',
          fillColor: Colors.grey.withOpacity(.30),
          filled: true,
          errorText: errorText,
          border: InputBorder.none),
    );
  }
}