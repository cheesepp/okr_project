import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';

import '../../../item/constants.dart';

class Intro extends StatelessWidget {
  const Intro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: Responsive.isMobile(context) ? 0 : 92.0),
        child: Responsive(
            tablet: ViewWebAndTablet(size: size),
            mobile: ViewMobile(size: size),
            desktop: ViewWebAndTablet(size: size)));
  }
}

class ViewWebAndTablet extends StatelessWidget {
  const ViewWebAndTablet({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "OKR Software that helps you execute your strategy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width >= 1139
                        ? 76
                        : size.width < 1139 && size.width > 705
                            ? 54
                            : 40,
                    color: kBlackColor),
              ),
              Text(
                "Focus on Goals. Measure your Progress. Achieve Results.",
                style: TextStyle(
                    fontSize: size.width >= 1139
                        ? 20
                        : size.width < 1139 && size.width > 705
                            ? 18
                            : 16,
                    color: kBlackColor),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Image.asset(
            "assets/images/headerOKR.png",
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}

class ViewMobile extends StatelessWidget {
  const ViewMobile({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.04),
        const Text(
          textAlign: TextAlign.center,
          "OKR Software that helps you execute your strategy",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: kBlackColor),
        ),
        SizedBox(height: size.height * 0.04),
        const Text(
          textAlign: TextAlign.center,
          "Focus on Goals. Measure your Progress. Achieve Results.",
          style: TextStyle(fontSize: 16, color: kBlackColor),
        ),
        SizedBox(height: size.height * 0.04),
        Image.asset(
          "assets/images/headerOKR.png",
          width: size.width * 0.5,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
