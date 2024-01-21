// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_hive_model.dart';

import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/local_storage/edit_objectives.dart';
import 'package:myokr/screen/add_okr/component/form_field_widget.dart';
import 'package:myokr/screen/add_okr/component/select_input.dart';
import 'package:provider/provider.dart';

class AddResultItem extends StatefulWidget {
  const AddResultItem({
    Key? key,
    required this.onTapClose,
    required this.idObj,
    required this.saveRs,
    required this.onTapSave,
    required this.index,
    required this.resultsEditHiveModel,
  }) : super(key: key);
  final String idObj;
  final VoidCallback onTapClose;
  final VoidCallback onTapSave;
  final bool saveRs;
  final int index;
  final ResultsEditHiveModel resultsEditHiveModel;
  @override
  State<AddResultItem> createState() => _AddResultItemState();
}

class _AddResultItemState extends State<AddResultItem> {
  TextEditingController keyrsController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late ResultProvider addRsProvider;
  late ResultsEditHiveModel rsModel;

  List<String> typeofKR = ['Numberic', 'Milestones', 'Percent', 'Money'];
  List<String> criterias = ['High is the best', 'Low is the best'];
  String type = '';
  String criter = '';
  String idperiod = '';
  bool loadRaw = false;
  EditObjeciveRawProvider? editRaw;
  bool showAdd = true;
  @override
  void initState() {
    type = typeofKR[0];
    criter = criterias[0];
    addRsProvider = context.read<ResultProvider>();
    if (widget.index < addRsProvider.resultList.length) {
      setRawRsEdit(addRsProvider.resultList[widget.index]);
    } else {
      setRawRsAdd();
    }
    super.initState();
  }

  @override
  void dispose() {
    keyrsController.dispose();
    startController.dispose();
    targetController.dispose();
    unitController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    editRaw = context.read<EditObjeciveRawProvider>();
    addRsProvider = context.watch<ResultProvider>();
    if (widget.saveRs) {
      validate();
    }

    double width = MediaQuery.of(context).size.width;
    return showAdd
        ? loadRaw
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kGreyColorWidget,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Add Key result',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: widget.onTapSave,
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: widget.onTapClose,
                                style: ElevatedButton.styleFrom(
                                    primary: const Color.fromARGB(
                                        255, 247, 121, 112),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            FormFieldWidget(
                                onChanged: (txt) {
                                  rsModel.result = txt;
                                  editRaw!.editResults(rsModel, widget.index);
                                },
                                padding: false,
                                fontStyle: true,
                                maxLength: false,
                                maxLines: 4,
                                controller: keyrsController,
                                hintText:
                                    'Viết các hành động chính yếu để đạt được Objectives ở trên',
                                labelText: 'Content'),
                            const SizedBox(
                              height: 30,
                            ),
                            width < 1000
                                ? Column(
                                    children: [
                                      SelectInputWidget(
                                          label: 'Type of KR',
                                          listobject: typeofKR,
                                          value: type,
                                          onChanged: (newValue) {
                                            setState(() {
                                              type = newValue!;
                                            });
                                            rsModel.typekr =
                                                typeofKR.indexOf(newValue!);
                                            editRaw!.editResults(
                                                rsModel, widget.index);
                                          }),
                                      SelectInputWidget(
                                          label: 'Criterias',
                                          listobject: criterias,
                                          value: criter,
                                          onChanged: (newValue) {
                                            setState(() {
                                              criter = newValue!;
                                            });
                                            rsModel.criteria =
                                                criterias.indexOf(newValue!);
                                            editRaw!.editResults(
                                                rsModel, widget.index);
                                          })
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        flex: 17,
                                        child: SelectInputWidget(
                                            label: 'Type of KR',
                                            listobject: typeofKR,
                                            value: type,
                                            onChanged: (newValue) {
                                              setState(() {
                                                type = newValue!;
                                              });
                                              rsModel.typekr =
                                                  typeofKR.indexOf(newValue!);
                                              editRaw!.editResults(
                                                  rsModel, widget.index);
                                            }),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                          flex: 17,
                                          child: SelectInputWidget(
                                              label: 'Criterias',
                                              listobject: criterias,
                                              value: criter,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  criter = newValue!;
                                                });
                                                rsModel.criteria = criterias
                                                    .indexOf(newValue!);
                                                editRaw!.editResults(
                                                    rsModel, widget.index);
                                              }))
                                    ],
                                  ),
                            const SizedBox(
                              height: 30,
                            ),
                            width < 1000
                                ? Column(
                                    children: [
                                      itemFormField(
                                          'Start', startController, 'None'),
                                      itemFormField(
                                          'Target', targetController, 'None'),
                                      itemFormField(
                                          'Unit', unitController, 'Enter Unit'),
                                      itemFormField('Due Date', dateController,
                                          'DD/MM/YY')
                                    ],
                                  )
                                : SizedBox(
                                    height: 120,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 10,
                                            child: itemFormField('Start',
                                                startController, 'None')),
                                        const Spacer(),
                                        Expanded(
                                            flex: 10,
                                            child: itemFormField('Target',
                                                targetController, 'None')),
                                        const Spacer(),
                                        Expanded(
                                            flex: 10,
                                            child: itemFormField('Unit',
                                                unitController, 'Enter Unit')),
                                        const Spacer(),
                                        Expanded(
                                            flex: 10,
                                            child: itemFormField('Due Date',
                                                dateController, 'dd/mm/yy'))
                                      ],
                                    ),
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
        : Container();
  }

  Padding itemFormField(
      String label, TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FormFieldWidget(
          onChanged: (txt) {
            if (controller == startController) {
              rsModel.start = int.parse(txt);
            } else if (controller == targetController) {
              rsModel.target = int.parse(txt);
            } else if (controller == unitController) {
              rsModel.unit = txt;
            } else if (controller == dateController) {
              rsModel.duedate = txt;
            }
            editRaw!.editResults(rsModel, widget.index);
          },
          padding: true,
          controller: controller,
          hintText: hintText,
          labelText: label,
          maxLength: false,
          maxLines: 1,
          fontStyle: false),
    );
  }

  void validate() {
    if (globalKey.currentState!.validate()) {
      ResultsModel resultsModel = ResultsModel(
          result: keyrsController.text,
          typekr: typeofKR.indexOf(type),
          criteria: criterias.indexOf(criter),
          start: int.parse(startController.text),
          target: int.parse(targetController.text),
          actual: int.parse(startController.text),
          unit: unitController.text,
          duedate: dateController.text,
          objId: widget.idObj,
          type: 1);
      rsModel.type = 1;
      rsModel.duedate = dateController.text;
      if (widget.index < addRsProvider.resultList.length) {
        editRaw!.editResults(rsModel, widget.index);
        addRsProvider.editList(widget.index, resultsModel);
      } else {
        editRaw!.editResults(rsModel, widget.index);
        addRsProvider.addList(resultsModel);
      }
      setState(() {
        showAdd = false;
      });
    }
  }

  void setRawRsEdit(ResultsModel resultsModel) {
    if (widget.resultsEditHiveModel.typekr != null) {
      keyrsController.text = widget.resultsEditHiveModel.result!;
      startController.text = widget.resultsEditHiveModel.start != null
          ? widget.resultsEditHiveModel.start!.toString()
          : '';
      targetController.text = widget.resultsEditHiveModel.target != null
          ? widget.resultsEditHiveModel.target!.toString()
          : '';
      unitController.text = widget.resultsEditHiveModel.unit!;
      type = typeofKR[widget.resultsEditHiveModel.typekr!];
      criter = criterias[widget.resultsEditHiveModel.criteria!];
      dateController.text = widget.resultsEditHiveModel.duedate!;
      rsModel = ResultsEditHiveModel(
          result: widget.resultsEditHiveModel.result!,
          start: widget.resultsEditHiveModel.start != null
              ? widget.resultsEditHiveModel.start!
              : null,
          target: widget.resultsEditHiveModel.target != null
              ? widget.resultsEditHiveModel.target!
              : null,
          unit: widget.resultsEditHiveModel.unit!,
          duedate: widget.resultsEditHiveModel.duedate!,
          typekr: widget.resultsEditHiveModel.typekr!,
          criteria: widget.resultsEditHiveModel.criteria!,
          index: widget.index,
          idObj: resultsModel.objId,
          type: 0,
          idrs: resultsModel.id != null ? resultsModel.id! : 'idrs');
    } else {
      keyrsController.text = resultsModel.result!;
      startController.text = resultsModel.start!.toString();
      targetController.text = resultsModel.target!.toString();
      unitController.text = resultsModel.unit!;
      type = typeofKR[resultsModel.typekr!];
      criter = criterias[resultsModel.criteria!];
      dateController.text = resultsModel.duedate!;
      rsModel = ResultsEditHiveModel(
          result: resultsModel.result!,
          start: resultsModel.start!,
          target: resultsModel.target!,
          unit: resultsModel.unit!,
          duedate: resultsModel.duedate!,
          typekr: resultsModel.typekr!,
          criteria: resultsModel.criteria!,
          index: widget.index,
          idObj: resultsModel.objId,
          type: 0,
          idrs: resultsModel.id != null ? resultsModel.id! : 'idrs');
    }
    setState(() {
      loadRaw = true;
    });
  }

  void setRawRsAdd() {
    if (widget.resultsEditHiveModel.typekr != null) {
      keyrsController.text = widget.resultsEditHiveModel.result!;
      startController.text = widget.resultsEditHiveModel.start != null
          ? widget.resultsEditHiveModel.start!.toString()
          : '';
      targetController.text = widget.resultsEditHiveModel.target != null
          ? widget.resultsEditHiveModel.target!.toString()
          : '';
      unitController.text = widget.resultsEditHiveModel.unit!;
      type = typeofKR[widget.resultsEditHiveModel.typekr!];
      criter = criterias[widget.resultsEditHiveModel.criteria!];
      dateController.text = widget.resultsEditHiveModel.duedate!;
      rsModel = ResultsEditHiveModel(
          result: widget.resultsEditHiveModel.result!,
          start: widget.resultsEditHiveModel.start != null
              ? widget.resultsEditHiveModel.start!
              : null,
          target: widget.resultsEditHiveModel.target != null
              ? widget.resultsEditHiveModel.target!
              : null,
          unit: widget.resultsEditHiveModel.unit!,
          duedate: '',
          typekr: widget.resultsEditHiveModel.typekr!,
          criteria: widget.resultsEditHiveModel.criteria!,
          index: widget.index,
          idObj: widget.idObj,
          type: 0,
          idrs: 'idrs');
    } else {
      rsModel = ResultsEditHiveModel(
          result: '',
          start: null,
          target: null,
          unit: '',
          duedate: '',
          typekr: typeofKR.indexOf(type),
          criteria: criterias.indexOf(criter),
          index: widget.index,
          idObj: widget.idObj,
          type: 0,
          idrs: 'idrs');
    }

    setState(() {
      loadRaw = true;
    });
  }
}
