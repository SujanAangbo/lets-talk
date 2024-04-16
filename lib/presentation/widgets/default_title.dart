import 'package:flutter/material.dart';

class DefaultTitle extends StatelessWidget {
  final String text;

  const DefaultTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 24,
          color: Colors.blue,
          fontWeight: FontWeight.w700,
          letterSpacing: 2),
    );
  }
}
