import 'package:flutter/material.dart';

class Menu {
  String title;
  Icon? icon;
  Menu({required this.title, this.icon});

  static List<Menu> menuItems = [
    Menu(title: "Products"),
    Menu(title: "About Us"),
    Menu(title: "Blog"),
    Menu(title: "Contact Us"),
  ];
}
