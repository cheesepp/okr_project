import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myokr/item/constants.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    required this.press,
    required this.icon,
    required this.brand,
  }) : super(key: key);

  final Function press;
  final String icon, brand;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: press as void Function(),
        child: Container(
          height: 50,
          width: 160,
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: kBlackColor,
            ),
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFF5F6F9),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  icon,
                  height: size.height * 0.045,
                  width: size.width * 0.08,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  brand,
                  style: TextStyle(fontSize: size.height * 0.0135),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    Key? key,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final Function press;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: press as void Function(),
        child: Container(
          height: 60,
          width: 60,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: kBlackColor,
            ),
            color: const Color(0xFFF5F6F9),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
