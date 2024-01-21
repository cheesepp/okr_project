// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myokr/item/divider_dotted.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/screen/my_okr/component/view_okr/items.dart';

class ItemResult extends StatefulWidget {
  const ItemResult({Key? key, required this.resultsModel, required this.onTap})
      : super(key: key);
  final ResultsModel resultsModel;
  final VoidCallback onTap;
  @override
  State<ItemResult> createState() => _ItemResultState();
}

class _ItemResultState extends State<ItemResult> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    double width = MediaQuery.of(context).size.width;
    return widget.resultsModel.id != null
        ? Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height:
                orientation == Orientation.portrait || width < 1000 ? 270 : 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 211, 221, 230)),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTittleTextBlack(widget.resultsModel.result!, 20),
                    const SizedBox(
                      height: 10,
                    ),
                    orientation == Orientation.portrait || width < 1000
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemMiddle('In charge:', "Name", false),
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
                                child: itemMiddle('In charge:', "Name", false),
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
                      height: 100,
                      child: orientation == Orientation.portrait || width < 1000
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: itemBottom('Tiến độ',
                                          '${tienDo(widget.resultsModel.actual!, widget.resultsModel.start!, widget.resultsModel.target!).ceil()}%'),
                                    ),
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
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue[200],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: widget.onTap,
                                      child: getTittleTextBlack('Update', 18),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: itemBottom('Tiến độ',
                                      '${tienDo(widget.resultsModel.actual!, widget.resultsModel.start!, widget.resultsModel.target!).ceil()}%'),
                                ),
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
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    width: 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue[200],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: widget.onTap,
                                      child: getTittleTextBlack('Update', 18),
                                    ),
                                  ),
                                )
                              ],
                            ),
                    )
                  ],
                )),
          )
        : Container();
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
}
