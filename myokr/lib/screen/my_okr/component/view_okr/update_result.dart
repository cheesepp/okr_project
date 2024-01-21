// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/model/firebase/objective_model.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/provider/firebase/edit_objectives_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/screen/add_okr/component/form_field_widget.dart';
import 'package:myokr/screen/add_okr/component/select_input.dart';
import 'package:myokr/screen/my_okr/component/view_okr/item_result.dart';
import 'package:myokr/screen/my_okr/component/view_okr/items.dart';
import 'package:provider/provider.dart';

class UpdateWidget extends StatefulWidget {
  const UpdateWidget({
    Key? key,
    required this.resultsModel,
    required this.objectivesModel,
    required this.index,
  }) : super(key: key);
  final ResultsModel resultsModel;
  final ObjectivesModel objectivesModel;
  final int index;

  @override
  State<UpdateWidget> createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {
  bool updateBool = true;
  bool? l;
  TextEditingController dateUpdate = TextEditingController();
  TextEditingController actualTxt = TextEditingController();
  TextEditingController statusTxt = TextEditingController();
  DateFormat month = DateFormat.MMMM('en_US');
  List<String> listStatus = [
    'Off-track',
    'Attention',
    'On-Track',
    'Success',
    'Excellent',
  ];
  String? value;
  @override
  void initState() {
    dateUpdate.text =
        '${DateTime.now().day}/${month.format(DateTime.now())}/${DateTime.now().year}';
    actualTxt.text = widget.resultsModel.actual!.toString();
    if (widget.resultsModel.selfGrade != null) {
      value = listStatus[widget.resultsModel.selfGrade! - 1];
    } else {
      value = listStatus[0];
    }
    super.initState();
  }

  @override
  void dispose() {
    dateUpdate.dispose();
    actualTxt.dispose();
    statusTxt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    double width = MediaQuery.of(context).size.width;
    return updateBool
        ? ItemResult(
            resultsModel: widget.resultsModel,
            onTap: () {
              setState(() {
                updateBool = !updateBool;
              });
            },
          )
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 211, 221, 230)),
                  height: width < 1000 ? 210 : 150,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: getTittleTextBlack(
                              widget.resultsModel.result!, 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        orientation == Orientation.portrait || width < 1000
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Column(
                                  children: [
                                    FormFieldWidget(
                                        onChanged: (txt) {},
                                        padding: true,
                                        controller: dateUpdate,
                                        hintText: '',
                                        labelText: 'Data date',
                                        maxLength: false,
                                        maxLines: 1,
                                        fontStyle: false),
                                    FormFieldWidget(
                                        onChanged: (txt) {},
                                        padding: true,
                                        controller: actualTxt,
                                        hintText: 'Actual value',
                                        labelText: 'Actual value',
                                        maxLength: false,
                                        maxLines: 1,
                                        fontStyle: false),
                                  ],
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: FormFieldWidget(
                                            onChanged: (txt) {},
                                            padding: true,
                                            controller: dateUpdate,
                                            hintText: '',
                                            labelText: 'Data date',
                                            maxLength: false,
                                            maxLines: 1,
                                            fontStyle: false)),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: FormFieldWidget(
                                            onChanged: (txt) {},
                                            padding: true,
                                            controller: actualTxt,
                                            hintText: 'Actual value',
                                            labelText: 'Actual value',
                                            maxLength: false,
                                            maxLines: 1,
                                            fontStyle: false)),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: setIcon(
                                              widget.resultsModel.typekr!)!),
                                    ),
                                  )
                                ],
                              )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                getTittleTextBlack('Overall Assessment', 20),
                SizedBox(
                  height: orientation == Orientation.portrait || width < 1000
                      ? 380
                      : 200,
                  width: double.infinity,
                  child: orientation == Orientation.portrait || width < 1000
                      ? Column(
                          children: [
                            SelectInputWidget(
                                listobject: listStatus,
                                value: value!,
                                label: 'Progress Status',
                                onChanged: (val) {
                                  setState(() {
                                    value = val!;
                                  });
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            FormFieldWidget(
                                onChanged: (txt) {},
                                controller: statusTxt,
                                hintText: 'Evaluation',
                                labelText: 'Evaluation',
                                maxLength: false,
                                maxLines: 3,
                                fontStyle: true,
                                padding: false),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: double.infinity,
                                height: 170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 228, 243, 255)),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      getTittleTextBlack(
                                          'Estimated OKR Progress', 18),
                                      getTittleText(
                                          '${tienDo(widget.resultsModel.actual!, widget.resultsModel.start!, widget.resultsModel.target!).ceil()}%',
                                          60,
                                          Colors.blue)
                                    ]),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                children: [
                                  SelectInputWidget(
                                      listobject: listStatus,
                                      value: value!,
                                      label: 'Progress Status',
                                      onChanged: (val) {
                                        setState(() {
                                          value = val!;
                                        });
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FormFieldWidget(
                                      onChanged: (txt) {},
                                      controller: statusTxt,
                                      hintText: 'Evaluation',
                                      labelText: 'Evaluation',
                                      maxLength: false,
                                      maxLines: 3,
                                      fontStyle: true,
                                      padding: false)
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: Container(
                                  width: double.infinity,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          255, 228, 243, 255)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        getTittleTextBlack(
                                            'Estimated OKR Progress', 18),
                                        getTittleText(
                                            '${tienDo(widget.resultsModel.actual!, widget.resultsModel.start!, widget.resultsModel.target!).ceil()}%',
                                            60,
                                            Colors.blue)
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        setState(() {
                          updateBool = !updateBool;
                        });
                      },
                      child: SizedBox(
                          height: 40,
                          child:
                              Center(child: getTittleTextBlack('Close', 16))),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        context.read<EditObjectiveProvider>().updateRs(
                            context,
                            widget.resultsModel.id!,
                            dateUpdate.text,
                            actualTxt.text,
                            listStatus.indexOf(value!) + 1,
                            statusTxt.text);
                        context.read<ResultProvider>().updateResult(
                            widget.index,
                            dateUpdate.text,
                            int.parse(actualTxt.text),
                            listStatus.indexOf(value!) + 1,
                            statusTxt.text);
                        updateBool = !updateBool;
                        context.read<ResultProvider>().notify();
                      },
                      child: SizedBox(
                          height: 40,
                          child: Center(
                              child: getTittleTextBlack('Close & Update', 16))),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
