import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:myokr/model/local_storage/result_hive_model/results_hive_model.dart';

class AddRawObjectiveProvider extends ChangeNotifier {
  bool rawBool = false;

  Future<void> saveObject(String object) async {
    var box = Hive.box('objective');
    await box.put('obj', object);
  }

  Future<void> saveResults(ResultsHiveModel resultsHiveModel, int index) async {
    var box = Hive.box<ResultsHiveModel>('results');
    if (index < box.length) {
      await box.putAt(index, resultsHiveModel);
    } else {
      await box.add(resultsHiveModel);
    }

    // print('save rs');
  }

  Future<void> removeOb() async {
    var resultBox = await Hive.openBox<ResultsHiveModel>('results');
    var objBox = await Hive.openBox('objective');
    resultBox.clear();
    objBox.delete('obj');
  }

  void setAddRawBool(bool raw) {
    rawBool = raw;
    notifyListeners();
  }

  bool get getRawBool => rawBool;
}
