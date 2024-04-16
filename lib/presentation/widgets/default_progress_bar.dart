import 'package:flutter/material.dart';

class DefaultProgressBar extends StatelessWidget {
  const DefaultProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
