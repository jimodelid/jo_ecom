import 'package:flutter/material.dart';

toast(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 2,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      content: Text(message),
    ),
  );
}
