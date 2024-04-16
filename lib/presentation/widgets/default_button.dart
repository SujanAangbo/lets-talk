import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  Color? color;
  DefaultButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text(text),
      onPressed: onPressed,
      color: color ?? Theme.of(context).colorScheme.secondary,
    );
  }
}
