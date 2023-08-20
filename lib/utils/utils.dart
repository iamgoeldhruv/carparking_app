import 'package:flutter/material.dart';

// for displaying snackbars
showSnackBar(String Content,BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(Content),
    ),
  );
}
