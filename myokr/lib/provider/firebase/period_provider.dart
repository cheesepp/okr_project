import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myokr/model/firebase/period_model.dart';

class PeriodProvider extends ChangeNotifier {
  List<PeriodModel> list = [];
  PeriodModel? periodModel;
  PeriodModel? nowPeriodModel;
  int _x = 0;

  Future<void> getPeriod() async {
    List<PeriodModel> newList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('periods')
        .orderBy('period', descending: false)
        .orderBy('month', descending: false)
        .get();
    for (var element in querySnapshot.docs) {
      periodModel = PeriodModel(
          quarter: (element.data() as dynamic)['quarter'],
          year: (element.data() as dynamic)['year'],
          month: (element.data() as dynamic)['month'],
          id: (element.data() as dynamic)['id'],
          period: (element.data() as dynamic)['period']);
      newList.add(periodModel!);
    }
    list = newList;

    getNowPeriod(list);
    // print('Load period');
    notifyListeners();
  }

  void getNowPeriod(List<PeriodModel> lists) async {
    int y = 0;
    int z = 0;
    for (var i in lists) {
      if (DateTime.now().month >= int.parse(i.month[0]) &&
          DateTime.now().month <= int.parse(i.month[i.month.length - 1]) &&
          i.year == DateTime.now().year) {
        nowPeriodModel = PeriodModel(
            year: i.year,
            month: i.month,
            id: i.id,
            period: i.period,
            quarter: i.quarter);
        y = z;
        continue;
      }
      z++;
    }
    _x = y;
    notifyListeners();
  }

  void getIndexP(int index) {
    _x = index;
    notifyListeners();
  }

  int get getIndex => _x;
  List<PeriodModel> get periodList => list;
  get nowPeriod {
    if (list.isNotEmpty) {
      return list[_x];
    } else {
      return null;
    }
  }
}
