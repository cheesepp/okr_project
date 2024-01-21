import 'package:flutter/material.dart';
import 'package:myokr/item/responsive.dart';
import 'package:myokr/provider/menu_provider.dart';

import 'package:myokr/screen/login_page/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../item/constants.dart';
import 'web_menu.dart';

class NavigatorHeader extends StatelessWidget {
  const NavigatorHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context, listen: false);
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: kBlackColor,
            ),
            onPressed: () {
              menu.openOrCloseDrawer();
            },
          ),
        const Text(
          "Logo",
          style: TextStyle(fontSize: defaultFontsize),
        ),
        const Spacer(),
        if (Responsive.isDesktop(context)) const WebMenu(),
        const Spacer(),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(LoginScreen.routename);
            },
            child: Container(
              decoration: BoxDecoration(
                color: kBlackColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Text(
                  "Sign In",
                  style:
                      TextStyle(color: Colors.white, fontSize: defaultFontsize),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
