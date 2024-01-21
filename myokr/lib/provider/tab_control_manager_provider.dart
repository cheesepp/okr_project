import 'package:flutter/material.dart';

import '../item/item_information_manager.dart';
import '../model/firebase/company_mode.dart';
import '../model/firebase/department_model.dart';
import '../screen/manager_department/manager_department_screen.dart';

class TabControlManager extends ChangeNotifier {
  //Chọn widget tabbar(Overview và keyresults)
  int tabBarKey = 0;
  void setTabBarKey(int key) {
    tabBarKey = key;
    notifyListeners();
  }

  int get getTabBarKey => tabBarKey;
  Widget getTabBar({Department? itemDepartment, Company? itemCompany}) {
    switch (tabBarKey) {
      case 0:
        return Information(
            itemCompany: itemCompany, itemDepartmnet: itemDepartment);
      case 1:
        if (itemCompany != null) {
          return ManagerDepartmentScreen(
            idPrevious: itemCompany.id,
            nameCompanyPrevious: itemCompany.name,
            countryPrevious: itemCompany.country,
            dateTimePrevious: itemCompany.date,
          );
        } else if (itemDepartment != null) {
          return ManagerDepartmentScreen(
            idPrevious: itemDepartment.id,
            nameDepartmentPrevious: itemDepartment.name,
            emailLeaderPrevious: itemDepartment.emailLeader,
            phoneLeaderPrevious: itemDepartment.phoneLeader,
            nameLeaderPrevious: itemDepartment.nameLeader,
          );
        }
        return Container();
      case 2:
        return Container();

      default:
        return Container();
    }
  }
}
