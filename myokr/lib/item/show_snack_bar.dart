import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SizedBox(
          height: 30,
          child: Align(alignment: Alignment.center, child: Text(text))),
    ),
  );
}
