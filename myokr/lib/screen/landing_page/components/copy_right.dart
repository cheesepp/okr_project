import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';

import '../../../item/constants.dart';

class CopyRight extends StatelessWidget {
  const CopyRight({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(mobile: ViewMobile(), desktop: ViewWebAndTablet());
  }
}

class ViewWebAndTablet extends StatelessWidget {
  const ViewWebAndTablet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "@ Copyright 2022. All Rights Reserved",
          style: TextStyle(
              fontSize: defaultFontsize,
              fontWeight: FontWeight.bold,
              color: kGreyColor),
        ),
        Row(
          children: const [
            Text(
              "A product of ",
              style: TextStyle(
                  fontSize: defaultFontsize,
                  fontWeight: FontWeight.bold,
                  color: kGreyColor),
            ),
            Text(
              "ATHACH",
              style: TextStyle(
                  fontSize: defaultFontsize,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: kGreyColor),
            ),
          ],
        )
      ],
    );
  }
}

class ViewMobile extends StatelessWidget {
  const ViewMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "@ Copyright 2022. All Rights Reserved",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: kGreyColor),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "A product of ",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: kGreyColor),
            ),
            Text(
              "ATHACH",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: kGreyColor),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
