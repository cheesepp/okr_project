import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myokr/item/random_string.dart';
import 'package:myokr/model/local_storage/result_hive_model/results_hive_model.dart';

class AddOjectivesProvider extends ChangeNotifier {
  bool requestBool = false;
  List<ResultsHiveModel> listRs = [];
  Future<void> addObjectives(idperiod, id, result, typekr, criteria, start,
      target, unit, date, object, userid) async {
    CollectionReference ob =
        FirebaseFirestore.instance.collection('objectives');
    CollectionReference rs = FirebaseFirestore.instance.collection('results');
    String idrs = getRandomString(20);
    await ob.doc(id).set({
      'id': id,
      'period_id': idperiod,
      'user_id': userid,
      'name': object,
      'status': 0,
      'reviewed_date': '',
      'create_At': DateTime.now(),
    });
    await rs.doc(idrs).set({
      'id': idrs,
      'obj_id': id,
      'name': result,
      'type': typekr,
      'criterias': criteria,
      'start': int.parse(start),
      'target': int.parse(target),
      'self_grade': null,
      'self_grade_txt': null,
      'actual': int.parse(start),
      'unit': unit,
      'grade': null,
      'duedate': date,
      'create_At': DateTime.now(),
      'data_date': DateTime.now(),
      'user_id': userid
    });
  }

  //Thêm/Sửa item Result
  int count = 1;
  void increaseCount() {
    count++;
    notifyListeners();
  }

  void decreaseCount() {
    count--;
    notifyListeners();
  }

  void setCount(int c) {
    count = c;
    notifyListeners();
  }

  void setRequestBool(bool check) {
    requestBool = check;
    if (check) {
      listRs.clear();
    }
    notifyListeners();
  }

  void addListRs(ResultsHiveModel resultsHiveModel) {
    listRs.add(resultsHiveModel);
  }

  void clearListRs() {
    listRs.clear();
  }

  int get getCount => count;
  bool get getRequestBool => requestBool;
}
