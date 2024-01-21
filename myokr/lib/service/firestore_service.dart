import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/firebase/user_model.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// ---------------- USER ------------------ ///
  Future<void> addUser(UserData user) async {
    await firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }

  /// ---------------- COMPANY ------------------ ///
  // Future<void> addCompany(Company item) async {
  //   await firestore
  //       .collection('Company')
  //       .add(item.toMap())
  //       .then((value) => print(value))
  //       .catchError((onError) => print("Error"));
  // }
}
