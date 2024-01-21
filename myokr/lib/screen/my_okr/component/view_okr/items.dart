import 'package:flutter/material.dart';

Icon? setIcon(int types) {
  switch (types) {
    case 0:
      return const Icon(Icons.money);
    case 1:
      return const Icon(Icons.numbers);
    case 2:
      return const Icon(Icons.percent);
    case 3:
      return const Icon(Icons.call_made_outlined);
  }
  return null;
}

double tienDo(int actual, int start, int target) {
  return ((actual - start).abs() / (target - start).abs()) * 100;
}

String? setType(int types) {
  switch (types) {
    case 0:
      return 'Money';
    case 1:
      return 'Number';
    case 2:
      return 'Percent';
    case 3:
      return 'Milestone';
  }
  return null;
}
