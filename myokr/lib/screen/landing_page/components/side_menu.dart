import 'package:flutter/material.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/model/menu_model.dart';
import 'package:myokr/provider/menu_provider.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSelectedIndex =
        Provider.of<MenuProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding * 3.5),
              child: Text("123"),
            ),
          ),
          ...List.generate(
            Menu.menuItems.length,
            (index) => DrawerItem(
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
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.isActive,
    required this.text,
    required this.press,
  }) : super(key: key);

  final bool isActive;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        // hoverColor: kBlackColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        selected: isActive,
        selectedTileColor: kBlackColor,
        onTap: press,
        title: Text(
          text,
          style: const TextStyle(color: kBlackColor),
        ),
      ),
    );
  }
}
