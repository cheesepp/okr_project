import 'package:flutter/material.dart';
import 'package:myokr/provider/tab_control_manager_provider.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'divider.dart';
import '../model/firebase/company_mode.dart';
import '../model/firebase/department_model.dart';

class TabControl extends StatefulWidget {
  final Department? itemDepartment;
  final Company? itemCompany;
  final int? itemchosen;
  const TabControl(
      {Key? key, this.itemDepartment, this.itemCompany, this.itemchosen})
      : super(key: key);

  @override
  State<TabControl> createState() => _TabControlState();
}

class _TabControlState extends State<TabControl> {
  List<String> listTab = [
    'Thông tin',
    'Danh sách các phòng ban',
    'Danh sách nhân viên'
  ];
  TabControlManager? widgetProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widgetProvider = context.watch<TabControlManager>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(),
            ),
            const DividerWidget(),
            const SizedBox(height: 24),
            Row(
              children: [
                TabItem(title: listTab[0], index: 0),
                TabItem(title: listTab[1], index: 1),
                TabItem(title: listTab[2], index: 2),
              ],
            ),
            widgetProvider!.getTabBar(
                itemDepartment: widget.itemDepartment,
                itemCompany: widget.itemCompany)
          ],
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    Key? key,
    required this.title,
    required this.index,
  }) : super(key: key);

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    TabControlManager? widgetProvider = context.watch<TabControlManager>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (index == 0) {
              widgetProvider.setTabBarKey(0);
            } else if (index == 1) {
              widgetProvider.setTabBarKey(1);
            } else if (index == 2) {
              widgetProvider.setTabBarKey(2);
            }
          },
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 2, color: kGreenLightColor),
                ),
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
