import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myokr/item/show_snack_bar.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/item/warning_dialog.dart';
import 'package:myokr/model/firebase/objective_model.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_hive_model.dart';
import 'package:myokr/provider/firebase/edit_objectives_provider.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/provider/firebase/period_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/local_storage/edit_objectives.dart';
import 'package:myokr/screen/add_okr/component/button_widget.dart';
import 'package:myokr/screen/add_okr/component/form_field_widget.dart';
import 'package:myokr/screen/my_okr/component/edit_okr/add_edit_result_item.dart';
import 'package:myokr/screen/my_okr/component/edit_okr/item_result.dart';
import 'package:provider/provider.dart';

class EditObjtives extends StatefulWidget {
  const EditObjtives({
    Key? key,
  }) : super(key: key);

  @override
  State<EditObjtives> createState() => _EditObjtivesState();
}

class _EditObjtivesState extends State<EditObjtives> {
  TextEditingController objectController = TextEditingController();
  List<ResultsModel> listRs = [];
  ObjectivesModel? objectivesModel;
  late EditObjectiveProvider editProvider;
  bool saveRs = false;
  String? objTxt;
  bool openWidget = true;
  String userid = '';
  EditObjeciveRawProvider? editOb;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    objectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    objectivesModel = context.watch<ObjectivesProvider>().clickObj;
    var periodProvider = context.watch<PeriodProvider>().nowPeriodModel!.id;
    userid = context.watch<User?>()!.uid;
    context.watch<ObjectivesProvider>().loadObj(periodProvider, userid);
    context.watch<ResultProvider>().loadResult(objectivesModel!.id);
    listRs = context.watch<ResultProvider>().resultList;
    editProvider = context.watch<EditObjectiveProvider>();
    editProvider.getObject(objectivesModel!.id);
    objTxt = editProvider.getObjTxt;
    objectController.text = objTxt!;
    EditObjeciveRawProvider editObjectiveProvider =
        context.watch<EditObjeciveRawProvider>();
    editOb = context.watch<EditObjeciveRawProvider>();
    if (editOb!.getLoadRaw) {
      getResult(objectivesModel!.id, listRs.length);
    }

    return objectivesModel!.id.isNotEmpty && listRs.isNotEmpty
        ? editProvider.openWid
            ? Container(
                margin: width < 1000 ? null : const EdgeInsets.only(left: 10),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: editProvider.getEditObjBool ? null : 50,
                          margin: const EdgeInsets.only(top: 10),
                          padding: editProvider.getEditObjBool
                              ? null
                              : const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                          decoration: editProvider.getEditObjBool
                              ? null
                              : BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 9,
                                  child: editProvider.getEditObjBool
                                      ? FormFieldWidget(
                                          onChanged: (txt) {
                                            editObjectiveProvider.saveObject(
                                                txt, objectivesModel!.id);
                                          },
                                          fontStyle: true,
                                          padding: false,
                                          maxLength: true,
                                          maxLines: 4,
                                          controller: objectController,
                                          hintText:
                                              'Viết các định hướng và mục tiêu quan trọng sẽ đạt được',
                                          labelText: 'Objectives',
                                        )
                                      : getTittleTextBlack(objTxt!, 20)),
                              Expanded(
                                  child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (editProvider.getEditObjBool) {
                                        context
                                            .read<EditObjectiveProvider>()
                                            .setObjTxt(objectController.text);
                                        editProvider.setEditObj(false);
                                      } else {
                                        editProvider.setEditObj(true);
                                      }
                                    },
                                    icon: editProvider.getEditObjBool
                                        ? const Icon(
                                            Icons.assignment_turned_in_outlined,
                                            color: Colors.blue,
                                          )
                                        : const Icon(
                                            Icons.edit,
                                          ),
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                  editProvider.getEditObjBool
                                      ? IconButton(
                                          onPressed: () {
                                            context
                                                .read<EditObjeciveRawProvider>()
                                                .removeObj(objectivesModel!.id);
                                            context
                                                .read<EditObjectiveProvider>()
                                                .setObjTxt(
                                                    objectivesModel!.name);
                                            editProvider.setEditObj(false);
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                          splashColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                        )
                                      : Container(),
                                ],
                              ))
                            ],
                          ),
                        ),
                        editProvider.getEditObjBool
                            ? Container()
                            : Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red[200],
                                ),
                                child: Center(
                                  child: getTittleTextBlack('Objectives', 16),
                                ),
                              ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ItemResultEdit(
                            idObj: objectivesModel!.id,
                            resultsModel: listRs[index],
                            index: index);
                      },
                      itemCount: listRs.length,
                    ),
                    editProvider.getAddBool
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: AddResultItem(
                                resultsEditHiveModel: editOb!.getModel!,
                                saveRs: saveRs,
                                onTapSave: () async {
                                  setState(() {
                                    saveRs = true;
                                  });

                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  setState(() {
                                    saveRs = false;
                                  });

                                  editProvider.setAddRs(false);
                                },
                                onTapClose: () {
                                  warningDialog(
                                      context,
                                      'Are you sure to undo the changes? ',
                                      'Ok', () {
                                    context
                                        .read<EditObjeciveRawProvider>()
                                        .removeRsAt(objectivesModel!.id,
                                            editOb!.getModel!, listRs.length);

                                    editProvider.setAddRs(false);

                                    Navigator.pop(context);
                                  });
                                },
                                index: listRs.length,
                                idObj: objectivesModel!.id),
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ButtonWidget(
                            onTap: () {
                              editProvider.setAddRs(true);
                              setState(() {
                                saveRs = false;
                              });
                              context
                                  .read<EditObjeciveRawProvider>()
                                  .setModel(ResultsEditHiveModel());
                            },
                            color: const Color.fromARGB(255, 165, 198, 228),
                            tittle: 'Add new key result')),
                    const SizedBox(
                      height: 20,
                    ),
                    width < 1000
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buttonItem('DELETE OBJECTIVE', context),
                              const SizedBox(
                                height: 20,
                              ),
                              buttonItem('SAVE AS OBJECTIVE', context),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 17,
                                child: buttonItem('DELETE OBJECTIVE', context),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 17,
                                child: buttonItem('SAVE AS OBJECTIVE', context),
                              )
                            ],
                          ),
                  ],
                ),
              )
            : SizedBox(
                height: 400,
                child: Center(
                  child:
                      getTittleTextBlack('Objective has not been selected', 20),
                ),
              )
        : SizedBox(
            height: 400,
            child: Center(
              child: getTittleTextBlack('Objective has not been selected', 20),
            ),
          );
  }

  ButtonWidget buttonItem(tittle, contex) {
    var objProvider = context.read<ObjectivesProvider>();
    var resultProvider = context.read<ResultProvider>();

    return ButtonWidget(
      color: tittle == 'SAVE AS OBJECTIVE' ? Colors.blue : Colors.red,
      onTap: () async {
        if (tittle == 'SAVE AS OBJECTIVE') {
          if (!editProvider.getAddBool &&
              !editProvider.getEditObjBool &&
              !editProvider.getEditBool) {
            await editProvider.editObjectives(objectivesModel!.id, listRs);
            showSnackBar(contex, "Successfully updated");

            await editOb!.removeRs(objectivesModel!.id);
            await editOb!.removeObj(objectivesModel!.id);
            objProvider.setStatus(ObjectivesStatus.loading);
            resultProvider.setStatus(ResultStatus.loading);
            resultProvider.notify();
          } else {
            showSnackBar(context, "Save the changed data please");
          }
        } else {
          await editProvider.deleteObj(objectivesModel!.id, listRs);
          showSnackBar(contex, "Successfully deleted");
          objProvider.setStatus(ObjectivesStatus.loading);
          editProvider.setOpenWidget(false);
          resultProvider.notify();
          editOb!.removeRs(objectivesModel!.id);
          editOb!.removeObj(objectivesModel!.id);
        }
      },
      tittle: tittle,
    );
  }

  Future<void> getResult(idObj, index) async {
    var box = await Hive.openBox<ResultsEditHiveModel>('resultsEdit');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.idObj == idObj &&
          box.getAt(i)!.index! >= listRs.length &&
          box.getAt(i)!.type == 0 &&
          box.getAt(i)!.idrs == 'idrs') {
        editOb!.setModel(box.getAt(i)!);
        editOb!.setLoadRaw(false);
        editProvider.setAddRs(true);
      }
    }
  }
}
