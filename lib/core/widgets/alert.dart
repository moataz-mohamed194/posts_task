import 'package:flutter/material.dart';

globalAlertWidget({
  required BuildContext context,
  required String message,
  Color? bgColor
}) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: bgColor??Colors.red,
  ));
}
