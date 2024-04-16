import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  String message;
  ErrorMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }
}
