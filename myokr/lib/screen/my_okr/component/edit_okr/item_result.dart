// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/item/divider_dotted.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/item/warning_dialog.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_hive_model.dart';
import 'package:myokr/provider/firebase/edit_objectives_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/local_storage/edit_objectives.dart';
import 'package:myokr/screen/my_okr/component/edit_okr/add_edit_result_item.dart';

import 'package:provider/provider.dart';

class ItemResultEdit extends StatefulWidget {
  const ItemResultEdit({
    Key? key,
    required this.resultsModel,
    required this.index,
    required this.idObj,
  }) : super(key: key);
  final ResultsModel resultsModel;
  final int index;
  final String idObj;
  @override
  State<ItemResultEdit> createState() => _ItemResultEditState();
}

class _ItemResultEditState extends State<ItemResultEdit> {
  DateFormat month = DateFormat.MMMM('en_US');
  bool editRs = false;
  bool saveRs = false;
  late EditObjectiveProvider editProvider;
  ResultsEditHiveModel? resultsEditHiveModel;
  @override
  void initState() {
    saveRs = false;
    getResult(widget.idObj, widget.index);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    double width = MediaQuery.of(context).size.width;
    editProvider = context.read<EditObjectiveProvider>();

    return editRs
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: AddResultItem(
                resultsEditHiveModel: resultsEditHiveModel != null
                    ? resultsEditHiveModel!
                    : ResultsEditHiveModel(),
                onTapClose: () {
                  warningDialog(
                      context, 'Are you sure to undo the changes? ', 'Ok', () {
                    editProvider.setEditRs(false);
                    context.read<EditObjeciveRawProvider>().removeRsAt(
                        widget.resultsModel.objId!,
                        resultsEditHiveModel != null
                            ? resultsEditHiveModel!
                            : ResultsEditHiveModel(),
                        widget.index);

                    setState(() {
                      editRs = false;
                      resultsEditHiveModel = ResultsEditHiveModel();
                    });
                    Navigator.pop(context);
                  });
                },
                index: widget.index,
                idObj: widget.resultsModel.objId!,
                saveRs: saveRs,
                onTapSave: () async {
                  setState(() {
                    saveRs = true;
                  });
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {
                    editRs = false;
                    saveRs = false;
                  });
                  editProvider.setEditRs(false);
                }),
          )
        : Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height:
                orientation == Orientation.portrait || width < 1000 ? 300 : 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.resultsModel.type == 1
                    ? kRedColor
                    : kGreyColorWidget),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTittleTextBlack(widget.resultsModel.result!, 20),
                    const SizedBox(
                      height: 10,
                    ),
                    width < 1000
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemMiddle('In charge:', 'Name', false),
                              const SizedBox(
                                height: 10,
                              ),
                              itemMiddle('Deadline:',
                                  widget.resultsModel.duedate!, false),
                              const SizedBox(
                                height: 10,
                              ),
                              itemMiddle('Type:',
                                  setType(widget.resultsModel.typekr!)!, true),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: itemMiddle('In charge:', 'Name', false),
                              ),
                              Expanded(
                                child: itemMiddle('Deadline:',
                                    widget.resultsModel.duedate!, false),
                              ),
                              Expanded(
                                child: itemMiddle(
                                    'Type:',
                                    setType(widget.resultsModel.typekr!)!,
                                    true),
                              ),
                            ],
                          ),
                    const DividerDotted(),
                    SizedBox(
                      height: width < 1000 ? 130 : 100,
                      child: width < 1000
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: itemBottom('Start',
                                          widget.resultsModel.start.toString()),
                                    ),
                                    Expanded(
                                      child: itemBottom(
                                          'Actual',
                                          widget.resultsModel.actual
                                              .toString()),
                                    ),
                                    Expanded(
                                      child: itemBottom(
                                          'Target',
                                          widget.resultsModel.target
                                              .toString()),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    editButton(),
                                    deleteButton(widget.index)
                                  ],
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: itemBottom('Start',
                                      widget.resultsModel.start.toString()),
                                ),
                                Expanded(
                                  child: itemBottom('Actual',
                                      widget.resultsModel.actual.toString()),
                                ),
                                Expanded(
                                  child: itemBottom('Target',
                                      widget.resultsModel.target.toString()),
                                ),
                                editButton(),
                                deleteButton(widget.index)
                              ],
                            ),
                    )
                  ],
                )),
          );
  }

  Expanded editButton() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blue[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            setState(() {
              editRs = true;
            });
            editProvider.setEditRs(true);
          },
          child: getTittleTextBlack('Edit', 18),
        ),
      ),
    );
  }

  Expanded deleteButton(index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.red[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            if (widget.resultsModel.type == 1) {
              resultsEditHiveModel = ResultsEditHiveModel(
                  result: widget.resultsModel.result,
                  start: widget.resultsModel.start,
                  target: widget.resultsModel.target,
                  unit: widget.resultsModel.unit);
              context.read<EditObjeciveRawProvider>().removeRsAt(
                  widget.idObj, resultsEditHiveModel!, widget.index);

              if (widget.resultsModel.id == null) {
                context.read<ResultProvider>().removeAtList(index);
              } else {
                context.read<ResultProvider>().setStatus(ResultStatus.loading);
                context.read<ResultProvider>().notify();
              }
            } else {
              context
                  .read<EditObjectiveProvider>()
                  .addListDel(widget.resultsModel.id);
              context.read<ResultProvider>().removeAtList(index);
            }
          },
          child: widget.resultsModel.type == 1
              ? widget.resultsModel.id != null
                  ? getTittleTextBlack('Cancle Change', 18)
                  : getTittleTextBlack('Delete', 18)
              : getTittleTextBlack('Delete', 18),
        ),
      ),
    );
  }

  SingleChildScrollView itemMiddle(String tittle, String value, bool icon) {
    return SingleChildScrollView(
      primary: false,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(
            tittle,
          ),
          const SizedBox(
            width: 10,
          ),
          getTittleTextBlack(value, 16),
          const SizedBox(
            width: 10,
          ),
          icon
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: setIcon(widget.resultsModel.typekr!)!,
                )
              : Container()
        ],
      ),
    );
  }

  Column itemBottom(String tittle, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(tittle), getTittleTextBlack(value, 40)],
    );
  }

  String? setType(int types) {
    switch (types) {
      case 0:
        return 'Money';
      case 1:
        return 'Number';
      case 2:
        return 'Percent';
      case 3:
        return 'Milestone';
    }
    return null;
  }

  Icon? setIcon(int types) {
    switch (types) {
      case 0:
        return const Icon(Icons.money);
      case 1:
        return const Icon(Icons.numbers);
      case 2:
        return const Icon(Icons.percent);
      case 3:
        return const Icon(Icons.call_made_outlined);
    }
    return null;
  }

  Future<void> getResult(idObj, index) async {
    var box = await Hive.openBox<ResultsEditHiveModel>('resultsEdit');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.idObj == idObj &&
          box.getAt(i)!.index == index &&
          box.getAt(i)!.type == 0) {
        setState(() {
          resultsEditHiveModel = box.getAt(i);
          editRs = true;
        });
      }
    }
  }
}
