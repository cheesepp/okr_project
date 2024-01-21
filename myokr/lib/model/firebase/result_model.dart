import 'package:cloud_firestore/cloud_firestore.dart';

class ResultsModel {
  String? objId;
  String? id;
  String? result;
  int? typekr;
  int? criteria;
  int? start;
  int? target;
  int? actual;
  String? unit;
  int? selfGrade;
  String? selfGradeTxt;
  String? duedate;
  Timestamp? createAt;
  int? type;
  ResultsModel(
      {this.result,
      this.objId,
      this.id,
      this.typekr,
      this.actual,
      this.criteria,
      this.start,
      this.createAt,
      this.target,
      this.selfGrade,
      this.selfGradeTxt,
      this.unit,
      this.duedate,
      this.type});
  // factory ResultsModel.fromJson(Map<String, dynamic> json) {
  //   return ResultsModel(
  //       result: json['result'],
  //       typekr: json['typekr'],
  //       criteria: json['criteria'],
  //       start: json['start'],
  //       target: json['target'],
  //       unit: json['unit'],
  //       duedate: json['date']);
  // }
  // Map<String, dynamic> toJson() => {
  //       'result': result,
  //       'typekr': typekr,
  //       'criteria': criteria,
  //       'start': start,
  //       'target': target,
  //       'unit': unit,
  //       'date': duedate
  //     };
}
