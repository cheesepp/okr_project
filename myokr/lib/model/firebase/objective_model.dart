import 'package:cloud_firestore/cloud_firestore.dart';

class ObjectivesModel {
  String id;
  String name;
  String reviewedDate;
  int status;
  String idUser;
  Timestamp createAt;
  ObjectivesModel(
      {required this.id,
      required this.idUser,
      required this.reviewedDate,
      required this.status,
      required this.name,
      required this.createAt});
  // factory ObjectivesModel.fromJson(Map<String, dynamic> json) {
  //   return ObjectivesModel(
  //       object: json['object'], listResult: json['listResult']);
  // }
}
