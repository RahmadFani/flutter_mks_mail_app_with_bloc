import 'package:flutter/material.dart';

const String baseUrl = 'http://atsuagzul4q.mksolusi.id/api';

extension ShowSnackbar on BuildContext {
  void showSnackBar(
      {required String message, Color backgroundColor = Colors.white}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({
    required String message,
  }) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}
