// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/item/warning_dialog.dart';
import 'package:myokr/model/firebase/objective_model.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_hive_model.dart';
import 'package:myokr/provider/firebase/edit_objectives_provider.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/local_storage/edit_objectives.dart';
import 'package:myokr/provider/my_widget_provider.dart';
import 'package:provider/provider.dart';

class ItemMyOKR extends StatefulWidget {
  const ItemMyOKR({
    Key? key,
    required this.objectivesModel,
    required this.index,
  }) : super(key: key);
  final ObjectivesModel objectivesModel;
  final int index;

  @override
  State<ItemMyOKR> createState() => _ItemMyOKRState();
}

class _ItemMyOKRState extends State<ItemMyOKR> {
  List<int> listGrade = [];
  String statusText = '';
  double? avg;
  @override
  void initState() {
    context.read<ResultProvider>().setStatus(ResultStatus.loading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResultProvider resultProvider = context.read<ResultProvider>();
    EditObjectiveProvider editProvider = context.read<EditObjectiveProvider>();
    ObjectivesProvider objectivesProvider = context.read<ObjectivesProvider>();
    setStatusText();
    return InkWell(
      onTap: () async {
        context.read<ResultProvider>().setStatus(ResultStatus.loading);
        resultProvider.loadResult(widget.objectivesModel.id);
        context
            .read<MyWidgetProvider>()
            .setPageMyOkr(widget.objectivesModel.status);
        context.read<ObjectivesProvider>().setClickObj(widget.objectivesModel);
        editProvider.setObjTxt(widget.objectivesModel.name);
        editProvider.setAddRs(false);
        editProvider.setOpenWidget(true);
        context.read<MyWidgetProvider>().setTabBarKey(1);
        context.read<EditObjeciveRawProvider>().setLoadRaw(true);
        context
            .read<EditObjeciveRawProvider>()
            .setModel(ResultsEditHiveModel());
        editProvider.setObjRawStatus();
      },
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(top: 10),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: objectivesProvider.clickObj!.id == widget.objectivesModel.id
              ? const Color.fromARGB(255, 179, 200, 219)
              : kGreyColorWidget,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 2,
              child: getTittleTextBlack(widget.objectivesModel.name, 18)),
          Expanded(
              flex: 1,
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTittleTextBlack(statusText, 16),
                  widget.objectivesModel.status == 0
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              warningDialog(
                                context,
                                'Are you sure to comfirm?',
                                'Comfirm',
                                () async {
                                  await editProvider.comfirmObjectives(
                                      widget.objectivesModel.id, context);
                                  objectivesProvider
                                      .editObjective(widget.index);

                                  Navigator.pop(context);
                                },
                              );
                              resultProvider.notify();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text(
                              'Comfirm',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Container()
                ],
              ))
        ]),
      ),
    );
  }

  void setStatusText() {
    if (widget.objectivesModel.status == 0) {
      setState(() {
        statusText = 'Un-Comfirmed';
      });
    } else {
      statusText = 'Comfirmed';
    }
  }
}
