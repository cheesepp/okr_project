// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myokr/model/local_storage/result_hive_model/results_hive_model.dart';
import 'package:myokr/provider/firebase/add_objectives_provider.dart';
import 'package:myokr/provider/local_storage/raw_objectives.dart';
import 'package:myokr/screen/add_okr/component/form_field_widget.dart';
import 'package:myokr/screen/add_okr/component/select_input.dart';
import 'package:provider/provider.dart';

class ResultItem extends StatefulWidget {
  const ResultItem({
    Key? key,
    required this.index,
    required this.onTap,
    required this.id,
    required this.resultsHiveModel,
    required this.objectives,
    required this.periodId,
    required this.clearRs,
  }) : super(key: key);
  final String periodId;
  final int index;
  final String objectives;
  final VoidCallback onTap;
  final ResultsHiveModel resultsHiveModel;
  final String id;
  final bool clearRs;
  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  TextEditingController keyrsController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late AddOjectivesProvider addProvider;
  late AddRawObjectiveProvider addRawObjective;
  ResultsHiveModel resultsHiveModel = ResultsHiveModel();
  List<String> typeofKR = ['Numberic', 'Milestones', 'Percent', 'Money'];
  List<String> criterias = ['High is the best', 'Low is the best'];
  String type = '';
  String criter = '';
  String userid = '';

  bool loadRaw = false;
  List<ResultsHiveModel> listRs = [];
  @override
  void initState() {
    type = typeofKR[0];
    criter = criterias[0];
    resultsHiveModel = ResultsHiveModel(
      result: '',
      typekr: typeofKR.indexOf(type),
      criteria: criterias.indexOf(criter),
      start: startController.text.isNotEmpty
          ? int.parse(startController.text)
          : null,
      target: targetController.text.isNotEmpty
          ? int.parse(targetController.text)
          : null,
      unit: '',
      duedate: '',
    );
    setRawRs();
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
    addProvider = context.watch<AddOjectivesProvider>();
    if (addProvider.getRequestBool) {
      validate(context);
    }
    addRawObjective = context.watch<AddRawObjectiveProvider>();
    if (addRawObjective.getRawBool) {
      saveResults();
    }
    if (widget.clearRs) {
      keyrsController.clear();
      startController.clear();
      targetController.clear();
      unitController.clear();
      dateController.clear();
    }
    final firebaseUser = context.watch<User?>();
    userid = context.watch<User?>()!.uid;
    double width = MediaQuery.of(context).size.width;
    return loadRaw
        ? Consumer<AddOjectivesProvider>(builder: (context, provider, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Key result ${widget.index + 1}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      widget.index > 0
                          ? ElevatedButton(
                              onPressed: widget.onTap,
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 247, 121, 112),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container()
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
                            onChanged: (txt) async {
                              resultsHiveModel.result = txt;
                              addRawObjective.saveResults(
                                  resultsHiveModel, widget.index);
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
                                        resultsHiveModel.typekr =
                                            typeofKR.indexOf(newValue!);
                                        addRawObjective.saveResults(
                                            resultsHiveModel, widget.index);
                                      }),
                                  SelectInputWidget(
                                      label: 'Criterias',
                                      listobject: criterias,
                                      value: criter,
                                      onChanged: (newValue) {
                                        setState(() {
                                          criter = newValue!;
                                        });
                                        resultsHiveModel.criteria =
                                            criterias.indexOf(newValue!);
                                        addRawObjective.saveResults(
                                            resultsHiveModel, widget.index);
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
                                          resultsHiveModel.typekr =
                                              typeofKR.indexOf(newValue!);
                                          addRawObjective.saveResults(
                                              resultsHiveModel, widget.index);
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
                                            resultsHiveModel.criteria =
                                                criterias.indexOf(newValue!);
                                            addRawObjective.saveResults(
                                                resultsHiveModel, widget.index);
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
                                  itemFormField(
                                      'Due Date', dateController, 'DD/MM/YY')
                                ],
                              )
                            : SizedBox(
                                height: 120,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 10,
                                        child: itemFormField(
                                            'Start', startController, 'None')),
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
            );
          })
        : Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Padding itemFormField(
      String label, TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FormFieldWidget(
          onChanged: (txt) {
            if (controller == startController) {
              resultsHiveModel.start = int.parse(txt);
            } else if (controller == targetController) {
              resultsHiveModel.target = int.parse(txt);
            } else if (controller == unitController) {
              resultsHiveModel.unit = txt;
            } else if (controller == dateController) {
              resultsHiveModel.duedate = txt;
            }
            addRawObjective.saveResults(resultsHiveModel, widget.index);
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

  void saveResults() {
    resultsHiveModel = ResultsHiveModel(
        result: keyrsController.text,
        typekr: typeofKR.indexOf(type),
        criteria: criterias.indexOf(criter),
        start: startController.text.isNotEmpty
            ? int.parse(startController.text)
            : null,
        target: targetController.text.isNotEmpty
            ? int.parse(targetController.text)
            : null,
        unit: unitController.text,
        duedate: dateController.text,
        idObj: widget.id);
    addRawObjective.saveObject(widget.objectives);
    // addRawObjective.saveResults(resultsHiveModel);
  }

  void validate(BuildContext context) {
    if (globalKey.currentState!.validate()) {
      addProvider.addObjectives(
          widget.periodId,
          widget.id,
          keyrsController.text,
          typeofKR.indexOf(type),
          criterias.indexOf(criter),
          startController.text,
          targetController.text,
          unitController.text,
          dateController.text,
          widget.objectives,
          userid);
      addRawObjective.removeOb();
      keyrsController.clear();
      startController.clear();
      targetController.clear();
      unitController.clear();
      dateController.clear();
    }
  }

  void setRawRs() {
    if (widget.resultsHiveModel.typekr != null) {
      keyrsController.text = widget.resultsHiveModel.result!;
      startController.text = widget.resultsHiveModel.start != null
          ? widget.resultsHiveModel.start!.toString()
          : '';
      targetController.text = widget.resultsHiveModel.target != null
          ? widget.resultsHiveModel.target!.toString()
          : '';
      unitController.text = widget.resultsHiveModel.unit!;
      type = typeofKR[widget.resultsHiveModel.typekr!];
      criter = criterias[widget.resultsHiveModel.criteria!];
      dateController.text = widget.resultsHiveModel.duedate!;

      ///Lưu bản nháp
      resultsHiveModel = ResultsHiveModel(
        result: widget.resultsHiveModel.result!,
        typekr: typeofKR.indexOf(type),
        criteria: criterias.indexOf(criter),
        start: widget.resultsHiveModel.start != null
            ? widget.resultsHiveModel.start!
            : null,
        target: widget.resultsHiveModel.target != null
            ? widget.resultsHiveModel.target!
            : null,
        unit: widget.resultsHiveModel.unit!,
        duedate: widget.resultsHiveModel.duedate!,
      );
    }

    setState(() {
      loadRaw = true;
    });
  }
}
