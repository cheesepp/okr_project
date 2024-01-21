import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/model/firebase/objective_model.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/model/status_chart_model.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/screen/my_okr/component/chart_okr/donut_chart_grade_widget.dart';
import 'package:myokr/screen/my_okr/component/chart_okr/donut_chart_status_widget.dart';
import 'package:provider/provider.dart';

class ChartOkr extends StatefulWidget {
  const ChartOkr({Key? key}) : super(key: key);

  @override
  State<ChartOkr> createState() => _ChartOkrState();
}

class _ChartOkrState extends State<ChartOkr> {
  ObjectivesProvider? objectivesProvider;
  ResultProvider? resultProvider;
  ObjectivesStatus? objectivesStatus;
  AllResultStatus? resultStatus;
  List<StatusChartModel>? listStatusObj;
  List<StatusChartModel>? listStatusRs;
  List<StatusChartModel>? listStatusGrade;
  List<ObjectivesModel> listObjectives = [];
  List<ResultsModel> listAllResult = [];
  List<ResultsModel> listRs = [];
  double? avgTotal;
  List<double>? listAvg;
  String userid = '';
  @override
  void initState() {
    context.read<ResultProvider>().setAllStatus(AllResultStatus.loading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userid = context.watch<User?>()!.uid;
    List<ResultsModel> listRsForObj = [];
    double width = MediaQuery.of(context).size.width;
    objectivesProvider = context.watch<ObjectivesProvider>();
    resultProvider = context.watch<ResultProvider>();
    listObjectives = objectivesProvider!.objectivesList;
    objectivesStatus = objectivesProvider!.getStatus;
    resultProvider!.loadAllResult(userid);
    listAllResult = resultProvider!.resultAllList;
    for (ObjectivesModel o in listObjectives) {
      if (o.status == 1) {
        for (ResultsModel r in listAllResult) {
          if (o.id == r.objId) {
            listRsForObj.add(r);
          }
        }
      }
    }
    if (listObjectives.isNotEmpty && listRsForObj.isNotEmpty) {
      statusChart(listObjectives, listRsForObj);
    }

    return objectivesStatus != ObjectivesStatus.loading
        ? objectivesStatus == ObjectivesStatus.success &&
                listAllResult.isNotEmpty &&
                listRsForObj.isNotEmpty
            ? Container(
                padding: width < 1000 ? null : const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                                color:
                                    const Color.fromARGB(255, 236, 236, 236)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 236, 236, 236)),
                              child: getTittleTextBlack(
                                  'Aggregation by Status', 25),
                            ),
                            width <= 1000
                                ? Column(
                                    children: [
                                      DonutChart(
                                          tittle:
                                              width <= 1200 ? 'Objectives' : '',
                                          count: listObjectives.length,
                                          listStatus: listStatusObj!),
                                      DonutChart(
                                          tittle: width <= 1200
                                              ? 'Results Key'
                                              : '',
                                          count: listAllResult.length,
                                          listStatus: listStatusRs!),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: DonutChart(
                                            tittle: 'Objectives',
                                            count: listObjectives.length,
                                            listStatus: listStatusObj!),
                                      ),
                                      Expanded(
                                        child: DonutChart(
                                            tittle: 'Results Key',
                                            count: listAllResult.length,
                                            listStatus: listStatusRs!),
                                      ),
                                    ],
                                  ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 3,
                              color: const Color.fromARGB(255, 236, 236, 236)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 236, 236, 236)),
                              child: getTittleTextBlack(
                                  'Aggregation by Grades', 25),
                            ),
                            Row(
                              children: [
                                DonutChartGrade(
                                    count: listObjectives.length,
                                    listStatus: listAvg!,
                                    tittle: 'Grades'),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        avgTotal!.isNaN
                                            ? getTittleText(
                                                'NaN', 30, Colors.blue)
                                            : getTittleText(
                                                '${avgTotal!.round()}',
                                                30,
                                                Colors.blue),
                                        const Text(
                                          'Average',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const Text(
                                          '(From direct management)',
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ]),
                                )
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: getTittleTextBlack('No objectives comfirmed yet', 20),
                ),
              )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  void statusChart(List<ObjectivesModel> listOb, List<ResultsModel> listRs) {
    List<String> statusName = [
      'Off-track',
      'Attention',
      'On-Track',
      'Success',
      'Excellent',
    ];
    List<int> indexRs = [0, 0, 0, 0, 0];
    List<int> indexObj = [0, 0, 0, 0, 0];
    listStatusObj = [];
    listStatusRs = [];
    listAvg = [];
    for (ObjectivesModel ob in listOb) {
      double avg = 0;
      int total = 0;
      int count = 0;
      for (ResultsModel rs in listRs) {
        if (rs.selfGrade != null) {
          if (ob.id == rs.objId) {
            total = total + rs.selfGrade!;
            count++;
            for (int i = 0; i < statusName.length; i++) {
              {
                if (rs.selfGrade == i + 1) {
                  indexRs[i]++;
                }
              }
            }
          }
        }
      }
      avg = total / count;
      listAvg!.add(avg);

      // print((listAvg!.reduce((value, element) => value + element) /
      //         listAvg!.length)
      //     .ceil());

      if (avg.isNaN) {
      } else {
        for (int i = 0; i < statusName.length; i++) {
          {
            // print(statusType[i]!);
            if (avg.round() == i + 1) {
              indexObj[i]++;
            }
          }
        }
      }
    }
    listAvg!.sort();

    if (listAvg!.last.isNaN) {
      if (listAvg!.first.isNaN) {
        avgTotal = listAvg!.reduce((value, element) => value + element) /
            listAvg!.length;
      } else {
        avgTotal = listAvg!.first;
      }
    } else {
      avgTotal = listAvg!.reduce((value, element) => value + element) /
          listAvg!.length;
    }
    for (int i = 0; i < statusName.length; i++) {
      listStatusObj!
          .add(StatusChartModel(name: statusName[i], count: indexObj[i]));
      listStatusRs!
          .add(StatusChartModel(name: statusName[i], count: indexRs[i]));
    }
  }
}
