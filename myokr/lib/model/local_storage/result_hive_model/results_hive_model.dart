import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ResultsHiveModel extends HiveObject {
  @HiveField(0)
  String? result;
  @HiveField(1)
  int? typekr;
  @HiveField(2)
  int? criteria;
  @HiveField(3)
  int? start;
  @HiveField(4)
  int? target;
  @HiveField(5)
  String? unit;
  @HiveField(6)
  String? duedate;
  @HiveField(7)
  String? idObj;
  ResultsHiveModel(
      {this.result,
      this.target,
      this.criteria,
      this.duedate,
      this.start,
      this.typekr,
      this.unit,this.idObj});
}
