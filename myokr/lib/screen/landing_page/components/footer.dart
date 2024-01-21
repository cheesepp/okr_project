import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';

import '../../../item/constants.dart';
import 'copy_right.dart';
import '../../../item/divider.dart';
import 'follow_contactus.dart';
import 'info_footer.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: kBlackColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              Responsive.isDesktop(context) ? defaultHorizontalPage : 18,
          vertical: defaultPadding,
        ),
        child: Column(
          children: const [
            FollowAndContactUs(),
            SizedBox(height: defaultPadding * 2),
            DividerWidget(),
            SizedBox(height: defaultPadding * 2),
            InfoFooter(),
            SizedBox(height: defaultPadding * 2),
            DividerWidget(),
            SizedBox(height: defaultPadding * 2),
            CopyRight()
          ],
        ),
      ),
    );
  }
}
