import 'package:flutter/material.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/my_widget_provider.dart';
import 'package:provider/provider.dart';

class TabBarMyOkr extends StatefulWidget {
  const TabBarMyOkr({Key? key}) : super(key: key);

  @override
  State<TabBarMyOkr> createState() => _TabBarMyOkrState();
}

class _TabBarMyOkrState extends State<TabBarMyOkr> {
  MyWidgetProvider? widgetProvider;
  List<String> listTab = ['Overview', 'Key Results'];
  @override
  Widget build(BuildContext context) {
    widgetProvider = context.watch<MyWidgetProvider>();
    var rsList = context.watch<ResultProvider>().resultList.length;
    if (rsList > 0) {
      listTab[1] = 'Key Results ($rsList)';
    } else {
      listTab[1] = 'Key Results';
    }
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 20),
            width: double.infinity,
            height: 60,
            child: SingleChildScrollView(
              primary: false,
              scrollDirection: Axis.horizontal,
              child: Row(
                // scrollDirection: Axis.horizontal,
                children: [
                  tabBarItem(listTab[0]),
                  const SizedBox(
                    width: 20,
                  ),
                  tabBarItem(listTab[1]),
                ],
              ),
            )),
        widgetProvider!.getTabBar
      ],
    );
  }

  InkWell tabBarItem(tittle) {
    widgetProvider = context.watch<MyWidgetProvider>();
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (tittle == 'Overview') {
          widgetProvider!.setTabBarKey(0);
        } else {
          widgetProvider!.setTabBarKey(1);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color:
                        listTab.indexOf(tittle) == widgetProvider!.getTabBarKey
                            ? Colors.blue
                            : Colors.transparent,
                    width: 3))),
        child: getTittleText(
            tittle,
            20,
            listTab.indexOf(tittle) == widgetProvider!.getTabBarKey
                ? Colors.black
                : Colors.grey),
      ),
    );
  }
}
