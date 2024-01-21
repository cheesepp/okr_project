import 'package:hive/hive.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_hive_model.dart';

class ResultsEditAdapter extends TypeAdapter<ResultsEditHiveModel> {
  @override
  final typeId = 0;
  @override
  ResultsEditHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultsEditHiveModel(
        result: fields[0] as String,
        typekr: fields[1] as int,
        criteria: fields[2] as int,
        start: fields[3] as int,
        target: fields[4] as int,
        unit: fields[5] as String,
        duedate: fields[6] as String,
        idObj: fields[7] as String,
        index: fields[8] as int,
        type: fields[9] as int,idrs: fields[10] as String);
  }

  @override
  void write(BinaryWriter writer, ResultsEditHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.result)
      ..writeByte(1)
      ..write(obj.typekr)
      ..writeByte(2)
      ..write(obj.criteria)
      ..writeByte(3)
      ..write(obj.start)
      ..writeByte(4)
      ..write(obj.target)
      ..writeByte(5)
      ..write(obj.unit)
      ..writeByte(6)
      ..write(obj.duedate)
      ..writeByte(7)
      ..write(obj.idObj)
      ..writeByte(8)
      ..write(obj.index)
      ..writeByte(9)
      ..write(obj.type)..writeByte(10)
      ..write(obj.idrs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultsEditAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
