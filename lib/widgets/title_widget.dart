import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 73, 73, 73),
          ),
        ),
      ],
    );
  }
}