import 'package:flutter/material.dart';

import '../colors.dart';

void show(BuildContext context, String message) {
final snackBar = SnackBar(
  content: Text(message),
  duration: Duration(seconds: 3),
  backgroundColor: primaryColor, // Customize the background color
  action: SnackBarAction(
    label: 'CLOSE',
    textColor: Colors.white, // Customize the text color
    onPressed: () {
      // Perform some action when the user clicks on the action button
    },
  ),
);

ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

