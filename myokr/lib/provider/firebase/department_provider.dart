import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/firebase/department_model.dart';

class DepartmentProvider extends ChangeNotifier {
  var firestore = FirebaseFirestore.instance.collection("Department");
  var x = FirebaseFirestore.instance.collection("Department").snapshots();
  Future<void> addDepartment(Department item) async {
    await firestore
        .add(item.toMap())
        // ignore: avoid_print
        .then((value) => print(value))
        // ignore: avoid_print
        .catchError((onError) => print("Error"));
  }

  Stream<List<Department>> getDepartment(String idPrevious) {
    return firestore
        .where('idPrevious', isEqualTo: idPrevious)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Department.fromMap(d); // convert into a map
            }).toList());
  }
}
