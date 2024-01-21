import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_hive_model.dart';

class EditObjeciveRawProvider extends ChangeNotifier {
  bool loadRaw = true;
  ResultsEditHiveModel? model;
  Future<void> saveObject(String object, String id) async {
    var box = Hive.box('objectiveEdit');
    await box.put(id, object);
  }

  Future<void> editResults(
      ResultsEditHiveModel resultsHiveModel, int index) async {
    bool haveData = false;
    int indexs = 0;
    var box = Hive.box<ResultsEditHiveModel>('resultsEdit');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.idObj == resultsHiveModel.idObj &&
          box.getAt(i)!.index == index) {
        haveData = true;
        indexs = i;
        break;
      }
    }
    // ignore: avoid_print
    print(haveData);
    if (haveData) {
      await box.putAt(indexs, resultsHiveModel);
    } else {
      await box.add(resultsHiveModel);
    }
  }

  Future<void> removeRsAt(
      String idObj, ResultsEditHiveModel model, int index) async {
    var resultBox = Hive.box<ResultsEditHiveModel>('resultsEdit');

    for (int i = 0; i < resultBox.length; i++) {
      if (resultBox.getAt(i)!.idObj == idObj &&
          resultBox.getAt(i)!.result == model.result &&
          resultBox.getAt(i)!.start == model.start &&
          resultBox.getAt(i)!.target == model.target &&
          resultBox.getAt(i)!.unit == model.unit &&
          resultBox.getAt(i)!.type == 1) {
        resultBox.deleteAt(i);
      } else if (resultBox.getAt(i)!.idObj == idObj &&
          resultBox.getAt(i)!.result == model.result &&
          resultBox.getAt(i)!.start == model.start &&
          resultBox.getAt(i)!.target == model.target &&
          resultBox.getAt(i)!.unit == model.unit &&
          resultBox.getAt(i)!.type == 0) {
        resultBox.deleteAt(i);
      } else if (resultBox.getAt(i)!.idObj == idObj &&
          resultBox.getAt(i)!.index == index) {
        resultBox.deleteAt(i);
      }
    }
  }

  Future<void> removeRs(String idObj) async {
    var resultBox = await Hive.openBox<ResultsEditHiveModel>('resultsEdit');
    for (int i = resultBox.length - 1; i >= 0; i--) {
      if (resultBox.getAt(i)!.idObj == idObj) {
        resultBox.deleteAt(i);
      }
    }
  }

  Future<void> removeObj(String id) async {
    var objBox = await Hive.openBox('objectiveEdit');
    objBox.delete(id);
  }

  void setLoadRaw(bool load) {
    loadRaw = load;
  }

  // void addList(ResultsEditHiveModel model) {
  //   listRs.add(model);
  //   notifyListeners();
  // }
  void setModel(ResultsEditHiveModel models) {
    model = models;
    notifyListeners();
  }
  // void deleteItem(int index) {
  //   listRs.removeAt(index);
  //   notifyListeners();
  // }

  bool get getLoadRaw => loadRaw;
  ResultsEditHiveModel? get getModel => model;
}
