import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_hive_model.dart';

enum ResultStatus { loading, success, failed }

enum AllResultStatus { loading, success, failed }

class ResultProvider extends ChangeNotifier {
  late ResultsModel resultsModel;
  // Get result của mỗi objective
  List<ResultsModel> list = [];
  ResultStatus status = ResultStatus.loading;
  Future<void> getResult(String id) async {
    List<ResultsModel> newList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('results')
        .where('obj_id', isEqualTo: id)
        .get();
    for (var element in querySnapshot.docs) {
      resultsModel = ResultsModel(
          id: (element.data() as dynamic)['id'],
          objId: id,
          result: (element.data() as dynamic)['name'],
          criteria: (element.data() as dynamic)['criterias'],
          start: (element.data() as dynamic)['start'],
          actual: (element.data() as dynamic)['actual'],
          target: (element.data() as dynamic)['target'],
          duedate: (element.data() as dynamic)['duedate'],
          typekr: (element.data() as dynamic)['type'],
          unit: (element.data() as dynamic)['unit'],
          selfGrade: (element.data() as dynamic)['self_grade'],
          selfGradeTxt: (element.data() as dynamic)['self_grade_txt'],
          createAt: (element.data() as dynamic)['create_At'],
          type: 0);
      newList.add(resultsModel);
    }
    list = newList;
    if (list.isNotEmpty) {
      status = ResultStatus.success;
    } else {
      status = ResultStatus.failed;
    }
    notifyListeners();
  }

  void loadResult(String id) async {
    if (status == ResultStatus.loading) {
      list.clear();
      await getResult(id);
      await getResultRaw(id);
    }
  }

  void setStatus(ResultStatus resultStatus) {
    status = resultStatus;
  }

  Future<void> getResultRaw(idObj) async {
    var box = await Hive.openBox<ResultsEditHiveModel>('resultsEdit');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.idObj == idObj && box.getAt(i)!.type == 1) {
        if (box.getAt(i)!.idrs != 'idrs') {
          for (int o = 0; o < list.length; o++) {
            if (list[o].id == box.getAt(i)!.idrs) {
              list[o].type = 1;
              list[o].result = box.getAt(i)!.result;
              list[o].typekr = box.getAt(i)!.typekr;
              list[o].criteria = box.getAt(i)!.criteria;
              list[o].start = box.getAt(i)!.start;
              list[o].target = box.getAt(i)!.target;
              list[o].unit = box.getAt(i)!.unit;
              list[o].duedate = box.getAt(i)!.duedate;
            }
          }
        } else {
          list.add(ResultsModel(
              result: box.getAt(i)!.result,
              type: box.getAt(i)!.type,
              typekr: box.getAt(i)!.typekr,
              criteria: box.getAt(i)!.criteria,
              start: box.getAt(i)!.start,
              target: box.getAt(i)!.target,
              actual: box.getAt(i)!.start,
              unit: box.getAt(i)!.unit,
              duedate: box.getAt(i)!.duedate,
              objId: idObj));
        }
      }
    }
  }

  List<ResultsModel> get resultList => list;

  //Get all result
  List<ResultsModel> allList = [];
  AllResultStatus allStatus = AllResultStatus.loading;
  Future<void> getAllResult(String id) async {
    List<ResultsModel> newList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('results')
        .where('user_id', isEqualTo: id)
        .get();
    for (var element in querySnapshot.docs) {
      resultsModel = ResultsModel(
          objId: (element.data() as dynamic)['obj_id'],
          id: (element.data() as dynamic)['id'],
          result: (element.data() as dynamic)['name'],
          criteria: (element.data() as dynamic)['criterias'],
          start: (element.data() as dynamic)['start'],
          actual: (element.data() as dynamic)['actual'],
          target: (element.data() as dynamic)['target'],
          duedate: (element.data() as dynamic)['duedate'],
          typekr: (element.data() as dynamic)['type'],
          unit: (element.data() as dynamic)['unit'],
          selfGrade: (element.data() as dynamic)['self_grade'],
          selfGradeTxt: (element.data() as dynamic)['self_grade_txt'],
          createAt: (element.data() as dynamic)['create_At']);
      newList.add(resultsModel);
    }
    allList = newList;
    if (allList.isNotEmpty) {
      allStatus = AllResultStatus.success;
    } else {
      allStatus = AllResultStatus.failed;
    }
    // print('load all result');
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  void loadAllResult(String id) {
    if (allStatus == AllResultStatus.loading) {
      getAllResult(id);
    }
  }

  void setAllStatus(AllResultStatus allResultStatus) {
    allStatus = allResultStatus;
  }

  List<ResultsModel> get resultAllList => allList;
  // Chỉnh sửa list Result của 1 object
  void removeAtList(int index) {
    list.removeAt(index);
    notifyListeners();
  }

  void addList(ResultsModel resultsModel) {
    list.add(resultsModel);
  }

  void editList(int index, ResultsModel resultsModel) async {
    list[index].result = resultsModel.result;
    list[index].start = resultsModel.start;
    list[index].target = resultsModel.target;
    list[index].typekr = resultsModel.typekr;
    list[index].criteria = resultsModel.criteria;
    list[index].unit = resultsModel.unit;
    list[index].duedate = resultsModel.duedate;
    list[index].type = resultsModel.type;
  }

  void updateResult(int index, String duedate, int actual, int selfGrade,
      String selfTxt) async {
    list[index].selfGradeTxt = selfTxt;
    list[index].selfGrade = selfGrade;
    list[index].actual = actual;
    list[index].duedate = duedate;
  }
}
