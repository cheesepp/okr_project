import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/firebase/company_mode.dart';

class CompanyProvider extends ChangeNotifier {
  var firestore = FirebaseFirestore.instance.collection("Company");
  var x = FirebaseFirestore.instance.collection("Company").snapshots();
  Future<void> addCompany(Company item) async {
    await firestore
        .add(item.toMap())
        // ignore: avoid_print
        .then((value) => print(value))
        // ignore: avoid_print
        .catchError((onError) => print("Error"));
  }

  Stream<List<Company>> getCompany(String uid) {
    return firestore
        .where('userID', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Company.fromMap(d); // convert into a map
            }).toList());
  }
}
