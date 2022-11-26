import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String message,
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}
