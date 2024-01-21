import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myokr/item/tab_control.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/model/firebase/company_mode.dart';
import 'package:myokr/model/firebase/department_model.dart';
import 'package:myokr/screen/add_okr/add_okr_screen.dart';
import 'package:myokr/screen/manager_company/manager_company_screen.dart';
import 'package:myokr/screen/manager_department/manager_department_screen.dart';
import 'package:myokr/screen/my_okr/component/chart_okr/chart_okr_widget.dart';
import 'package:myokr/screen/my_okr/component/edit_okr/edit_obj_widget.dart';
import 'package:myokr/screen/my_okr/component/view_okr/view_okr_widget.dart';
import 'package:myokr/screen/my_okr/my_okr_screen.dart';

class MyWidgetProvider extends ChangeNotifier {
  //Chọn widget hiển thị objective ở 2 trạng thái khác nhau(comfirm và uncomfirm)
  int? pageMyOkr;
  String userID = '';
  Company? itemCompany;
  void setPageMyOkr(int i) {
    pageMyOkr = i;
    notifyListeners();
  }

  Widget get getPageMyOkr {
    switch (pageMyOkr) {
      case 0:
        return const EditObjtives();
      case 1:
        return const ViewOKRWidget();
      default:
        return SizedBox(
          height: 400,
          child: Center(
            child: getTittleTextBlack('Objective has not been selected', 20),
          ),
        );
    }
  }

  //Chọn widget tabbar(Overview và keyresults)
  int tabBarKey = 0;
  void setTabBarKey(int key) {
    tabBarKey = key;
    notifyListeners();
  }

  int get getTabBarKey => tabBarKey;
  Widget get getTabBar {
    switch (tabBarKey) {
      case 0:
        return const ChartOkr();
      case 1:
        return getPageMyOkr;
      default:
        return Container();
    }
  }

  // Menu bên trái
  String pageRoute = '0-0';
  void changePage(String page) {
    pageRoute = page;
    notifyListeners();
  }

  String get getRoutePage => pageRoute;
  Widget get getPage {
    switch (pageRoute) {
      case '0-0':
        return const MyOkrScreen();
      case '0-1':
        return const AddOrkScreen();
      case '1-0':
        return ManagerCompanyScreen(userID: userID);
      case '1-1':
        return TabControl(
          itemCompany: itemCompany,
        );
      default:
        return Container();
    }
  }

  bool changeWidget = false;
  void setChangeWidget(bool b) {
    changeWidget = b;
    notifyListeners();
  }

  void setUserID(String userid) {
    userID = userid;
  }

  void setCompany(Company? company) {
    itemCompany = company;
  }

  bool get changWidget => changeWidget;
}
