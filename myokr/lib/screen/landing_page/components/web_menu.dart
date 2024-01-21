import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../item/constants.dart';
import '../../../model/menu_model.dart';
import '../../../provider/menu_provider.dart';

class WebMenu extends StatefulWidget {
  const WebMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<WebMenu> createState() => _WebMenuState();
}

class _WebMenuState extends State<WebMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentSelectedIndex =
        Provider.of<MenuProvider>(context, listen: false);
    return Row(
      children: List.generate(
        Menu.menuItems.length,
        (index) => WebMenuItem(
          text: Menu.menuItems[index].title,
          isActive: currentSelectedIndex.getCurrentDrawer == index,
          press: () {
            currentSelectedIndex.setCurrentDrawer(index);
            // ignore: avoid_print
            print(index.toString());
            // ignore: avoid_print
            print(currentSelectedIndex.getCurrentDrawer.toString());
          },
        ),
      ),
    );
  }
}

class WebMenuItem extends StatefulWidget {
  const WebMenuItem({
    Key? key,
    required this.isActive,
    required this.text,
    required this.press,
  }) : super(key: key);

  final bool isActive;
  final String text;
  final VoidCallback press;

  @override
  State<WebMenuItem> createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  bool _isHover = false;

  Color _borderColor() {
    if (widget.isActive) {
      return kGreyColor;
    } else if (!widget.isActive & _isHover) {
      return kGreyColor.withOpacity(0.4);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
        padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _borderColor(),
              width: 3,
            ),
          ),
        ),
        duration: kDefaultDuration,
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: defaultFontsize,
            color: kBlackColor,
            fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
