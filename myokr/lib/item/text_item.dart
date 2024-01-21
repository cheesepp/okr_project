
import 'package:flutter/material.dart';

Text getTittleTextBlack(
  String tittle,
  double size,
) =>
    Text(
      tittle,
      style: TextStyle(
          fontSize: size, fontWeight: FontWeight.bold, color: Colors.black),
    );
    Text getTittleText(
  String tittle,
  double size,
  Color color
) =>
    Text(
      tittle,
      style: TextStyle(
          fontSize: size, fontWeight: FontWeight.bold, color: color),
    );