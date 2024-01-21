import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myokr/model/firebase/objective_model.dart';

enum ObjectivesStatus { loading, success, failed }

class ObjectivesProvider extends ChangeNotifier {
  List<ObjectivesModel> list = [];
  ObjectivesModel? objectivesModel;
  ObjectivesModel clickObjectivesModel = ObjectivesModel(
      id: '',
      idUser: '',
      reviewedDate: '',
      status: 0,
      name: '',
      createAt: Timestamp.fromDate(DateTime.now()));
  ObjectivesStatus status = ObjectivesStatus.loading;
  Future<void> getObjectives(String idPeriod, String userId) async {
    List<ObjectivesModel> newList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('objectives')
        .orderBy('create_At', descending: true)
        .where('period_id', isEqualTo: idPeriod)
        .where('user_id', isEqualTo: userId)
        .get();
    for (var element in querySnapshot.docs) {
      objectivesModel = ObjectivesModel(
          createAt: (element.data() as dynamic)['create_At'],
          id: (element.data() as dynamic)['id'],
          idUser: (element.data() as dynamic)['user_id'],
          reviewedDate: (element.data() as dynamic)['reviewed_date'],
          status: (element.data() as dynamic)['status'],
          name: (element.data() as dynamic)['name']);
      newList.add(objectivesModel!);
    }
    list = newList;

    if (list.isNotEmpty) {
      status = ObjectivesStatus.success;
    } else {
      status = ObjectivesStatus.failed;
    }
    notifyListeners();
  }

  void loadObj(String id, String userId) {
    if (status == ObjectivesStatus.loading) {
      list.clear();
      getObjectives(id, userId);
    }
  }

  void setStatus(ObjectivesStatus st) {
    status = st;
  }

  void setClickObj(ObjectivesModel objectivesModel) {
    clickObjectivesModel = objectivesModel;
    notifyListeners();
  }

  void editObjective(int index) {
    list[index].status = 1;
    notifyListeners();
  }

  void removeClickObj() {
    clickObjectivesModel = ObjectivesModel(
        id: '',
        idUser: '',
        reviewedDate: '',
        status: 0,
        name: '',
        createAt: Timestamp.fromDate(DateTime.now()));
    notifyListeners();
  }

  ObjectivesModel? get clickObj => clickObjectivesModel;
  List<ObjectivesModel> get objectivesList => list;
  ObjectivesStatus get getStatus => status;
}
