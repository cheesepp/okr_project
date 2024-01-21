import 'package:flutter/material.dart';

import 'constants.dart';

class LinkOfText extends StatelessWidget {
  const LinkOfText({
    Key? key,
    required this.text,
    required this.textlink,
    required this.press,
  }) : super(key: key);
  final String text, textlink;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: press,
            child: Text(
              textlink,
              style: const TextStyle(
                fontSize: 16,
                color: kBlackColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
