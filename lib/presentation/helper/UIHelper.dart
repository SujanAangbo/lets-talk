import 'package:flutter/material.dart';
import 'package:lets_chat/presentation/widgets/gap_widget.dart';

class UIHelper {
  static void showLoader(BuildContext context, String message) {
    AlertDialog loader = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const GapWidget(),
          Text(message),
        ],
      ),
      contentPadding: const EdgeInsets.all(40),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => loader,
    );
  }

  static void showSnackbar(BuildContext context, String message, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
