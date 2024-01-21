import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ResultsEditHiveModel extends HiveObject {
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
  @HiveField(8)
  int? index;
  @HiveField(9)
  int? type;
  @HiveField(10)
  String? idrs;
  ResultsEditHiveModel(
      {this.result,
      this.target,
      this.criteria,
      this.duedate,
      this.start,
      this.typekr,
      this.unit,
      this.idObj,
      this.index,
      this.type,this.idrs});
}
