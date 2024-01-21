import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myokr/model/firebase/user_model.dart';

enum UserStatus { loading, success, failed }

class UserProvider extends ChangeNotifier {
  UserData userModel = UserData(email: null, uid: null, name: null);
  UserStatus userStatus = UserStatus.loading;
  Future<void> getUser(String id) async {
    final firestore =
        await FirebaseFirestore.instance.collection("users").doc(id).get();

    if (firestore.exists) {
      userModel = UserData(
          email: (firestore.data() as dynamic)['email'],
          uid: (firestore.data() as dynamic)['uid'],
          name: (firestore.data() as dynamic)['name']);
    } else {
      userModel = UserData(email: '', uid: '', name: '');
    }
    if (userModel.email != null) {
      userStatus = UserStatus.success;
    } else {
      userStatus = UserStatus.failed;
    }

    notifyListeners();
  }

  void loadUser(String id) {
    if (userStatus == UserStatus.loading) {
      getUser(id);
    }
  }

  void setStatus(UserStatus status) {
    userStatus = status;
  }

  UserData get userInfo => userModel;
}
