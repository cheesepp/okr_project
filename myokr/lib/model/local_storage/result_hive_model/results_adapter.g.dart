import 'package:hive/hive.dart';
import 'package:myokr/model/local_storage/result_hive_model/results_hive_model.dart';

class ResultsAdapter extends TypeAdapter<ResultsHiveModel> {
  @override
  final typeId = 1;
  @override
  ResultsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultsHiveModel(
      result: fields[0] as String,
      typekr: fields[1] as int,
      criteria: fields[2] as int,
      start: fields[3] as int,
      target: fields[4] as int,
      unit: fields[5] as String,
      duedate: fields[6] as String,
      idObj: fields[7] as String
    );
  }

  @override
  void write(BinaryWriter writer, ResultsHiveModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.duedate)..writeByte(7)..write(obj.idObj);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
