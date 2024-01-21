// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myokr/item/text_item.dart';

warningDialog(BuildContext context, String content, String button,
    VoidCallback onTap) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SizedBox(
              height: 100,
              child: Center(
                child: getTittleTextBlack(content, 18),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 247, 121, 112),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  button,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ));
}
