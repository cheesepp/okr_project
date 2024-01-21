import 'package:flutter/material.dart';

class SubMenu extends StatelessWidget {
  const SubMenu({
    Key? key,
    required this.tittle,
    required this.onTap,
    required this.color,
  }) : super(key: key);
  final String tittle;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        // height: double.infinity,
        height: 40,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              tittle,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                  decoration: TextDecoration.none),
            )
          ],
        ),
      ),
    );
  }
}
