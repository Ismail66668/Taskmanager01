import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      backgroundColor: isError ? Colors.red : null,
    ),
  );
}
