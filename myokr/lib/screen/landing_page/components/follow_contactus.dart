import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';

import '../../../item/constants.dart';

class FollowAndContactUs extends StatelessWidget {
  const FollowAndContactUs({
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
        Row(
          children: [
            const Text(
              "Follow",
              style: TextStyle(
                  fontSize: defaultFontsize,
                  fontWeight: FontWeight.bold,
                  color: kGreyColor),
            ),
            const SizedBox(width: defaultPadding),
            Image.asset(
              "assets/icons/facebook.png",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: defaultPadding),
            Image.asset(
              "assets/icons/instagram.png",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: defaultPadding),
            Image.asset(
              "assets/icons/linkedin.png",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: defaultPadding),
            Image.asset(
              "assets/icons/twitter.png",
              width: 24,
              height: 24,
            ),
          ],
        ),
        const Text(
          "Contact us",
          style: TextStyle(
              fontSize: defaultFontsize,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: kGreyColor),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Follow",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: kGreyColor),
            ),
            const SizedBox(width: 12),
            Image.asset(
              "assets/icons/facebook.png",
              width: 20,
              height: 20,
            ),
            const SizedBox(width: defaultPadding),
            Image.asset(
              "assets/icons/instagram.png",
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 12),
            Image.asset(
              "assets/icons/linkedin.png",
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 12),
            Image.asset(
              "assets/icons/twitter.png",
              width: 20,
              height: 20,
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          "Contact us",
          style: TextStyle(
              fontSize: defaultFontsize,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: kGreyColor),
        )
      ],
    );
  }
}
