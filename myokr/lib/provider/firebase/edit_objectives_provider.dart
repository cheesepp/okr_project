import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:myokr/item/random_string.dart';
import 'package:myokr/item/show_snack_bar.dart';
import 'package:myokr/model/firebase/result_model.dart';

enum ObjectiveRawStatus { loading, success, failed }

class EditObjectiveProvider extends ChangeNotifier {
  CollectionReference ob = FirebaseFirestore.instance.collection('objectives');
  CollectionReference rs = FirebaseFirestore.instance.collection('results');
  String objTxt = '';
  bool editRs = false;
  bool editObj = false;
  bool addRs = false;
  bool openWidget = true;
  List<String> listRsDelete = [];
  ObjectiveRawStatus objectiveRawStatus = ObjectiveRawStatus.loading;
  Future<void> editObjectives(String id, List<ResultsModel> listRss) async {
    await ob.doc(id).update({
      'name': objTxt,
    });
    for (String str in listRsDelete) {
      await rs.doc(str).delete();
    }
    for (ResultsModel r in listRss) {
      String idrs = getRandomString(20);
      if (r.id != null) {
        await rs.doc(r.id).update({
          'name': r.result,
          'type': r.typekr,
          'criterias': r.criteria,
          'start': r.start,
          'target': r.target,
          'actual': r.actual,
          'duedate': r.duedate,
          'unit': r.unit,
          'data_date': DateTime.now(),
        });
      } else {
        await rs.doc(idrs).set({
          'id': idrs,
          'obj_id': id,
          'name': r.result,
          'type': r.typekr,
          'criterias': r.criteria,
          'start': r.start,
          'target': r.target,
          'self_grade': null,
          'self_grade_txt': null,
          'actual': r.actual,
          'unit': r.unit,
          'grade': null,
          'duedate': r.duedate,
          'create_At': DateTime.now(),
          'data_date': DateTime.now(),
          'user_id': 'userid'
        });
      }
    }
  }

  Future<void> comfirmObjectives(String id, context) async {
    await ob
        .doc(id)
        .update({'status': 1})
        .then((value) => showSnackBar(context, 'Successfully comfirmed'))
        .catchError((error) => showSnackBar(context, error.toString()));
  }

  Future<void> deleteObj(String id, List<ResultsModel> listRss) async {
    await ob.doc(id).delete();
    for (ResultsModel r in listRss) {
      await rs.doc(r.id).delete();
    }
    for (String str in listRsDelete) {
      await rs.doc(str).delete();
    }
  }

  Future<void> updateRs(context, String id, String dataDate, String actual,
      int pStatus, String evaluation) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('results').doc(id);
    documentReference
        .update({
          'self_grade': pStatus,
          'self_grade_txt': evaluation,
          'actual': int.parse(actual),
          'data_date': dataDate
        })
        .then((value) =>
            showSnackBar(context, 'Successfully updated Okr progress'))
        .catchError((error) => showSnackBar(context, error));
  }

  void setOpenWidget(bool open) {
    openWidget = open;
    notifyListeners();
  }

  void setObjTxt(String obj) {
    objTxt = obj;
    notifyListeners();
  }

  void addListDel(id) {
    listRsDelete.add(id);
  }

  void setEditRs(bool rs) {
    editRs = rs;
  }

  void setAddRs(bool rs) {
    addRs = rs;
    notifyListeners();
  }

  void setEditObj(bool ob) {
    editObj = ob;
    notifyListeners();
  }

  void setObjRawStatus() {
    objectiveRawStatus = ObjectiveRawStatus.loading;
  }

  Future<void> getObject(String id) async {
    if (objectiveRawStatus == ObjectiveRawStatus.loading) {
      var box = Hive.box('objectiveEdit');
      String obj = await box.get(id) ?? '';

      if (obj.isNotEmpty) {
        objTxt = obj;
        editObj = true;
        objectiveRawStatus = ObjectiveRawStatus.success;
      } else {
        editObj = false;
        objectiveRawStatus = ObjectiveRawStatus.failed;
      }
    }
  }

  String get getObjTxt => objTxt;
  bool get getEditBool => editRs;
  bool get getEditObjBool => editObj;
  bool get getAddBool => addRs;
  bool get openWid => openWidget;
}
