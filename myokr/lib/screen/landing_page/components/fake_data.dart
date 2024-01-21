import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';

import '../../../item/constants.dart';

class FakeData extends StatelessWidget {
  const FakeData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: Responsive.isMobile(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: Responsive.isMobile(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Text(
          "PRODUCT",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "About Us",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "Products Us",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "Inthe Press",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "Our Parthers",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "Terms of Service",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "SLA",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "Data Sercurity",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 18 : defaultFontsize,
            color: kGreyColor,
          ),
        ),
        SizedBox(height: Responsive.isMobile(context) ? 40 : defaultPadding),
      ],
    );
  }
}
