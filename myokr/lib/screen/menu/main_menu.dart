import 'package:flutter/material.dart';
import 'package:myokr/item/icon_item.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/provider/my_widget_provider.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
    required this.tittle,
    required this.submenu,
    required this.child,
  }) : super(key: key);
  final String tittle;
  final List<String> submenu;
  final Widget child;
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool menu = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () => {
              if (widget.tittle == 'Company')
                {context.read<MyWidgetProvider>().changePage('1-0')},
              setState(() {
                menu = !menu;
              })
            },
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      getIconBlack(Icons.list_alt_rounded, 25),
                      const SizedBox(
                        width: 10,
                      ),
                      getTittleTextBlack(widget.tittle, 22),
                    ],
                  ),
                  widget.submenu.isNotEmpty
                      ? menu
                          ? getIconBlack(Icons.arrow_drop_up, 25)
                          : getIconBlack(Icons.arrow_drop_down_sharp, 25)
                      : Container()
                ],
              ),
            ),
          ),
          menu
              ? Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: widget.child,
                )
              : Container(),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.black,
            height: 2,
          )
        ],
      ),
    );
  }
}
