import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';

import '../../../item/constants.dart';
import '../../../item/divider.dart';
import 'intro.dart';
import 'navigator_header.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: kGreenLightColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              Responsive.isDesktop(context) ? defaultHorizontalPage : 18,
          vertical: defaultPadding,
        ),
        child: Column(
          children: [
            SizedBox(
                height: Responsive.isDesktop(context)
                    ? defaultPadding * 2
                    : defaultPadding),
            const NavigatorHeader(),
            SizedBox(
                height: Responsive.isDesktop(context)
                    ? defaultPadding * 2
                    : defaultPadding),
            const DividerWidget(),
            SizedBox(
                height: Responsive.isDesktop(context)
                    ? defaultPadding * 2
                    : defaultPadding),
            const Intro(),
          ],
        ),
      ),
    );
  }
}
