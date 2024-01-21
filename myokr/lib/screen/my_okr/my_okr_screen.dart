import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myokr/item/period_widget.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/model/firebase/objective_model.dart';
import 'package:myokr/model/firebase/period_model.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/provider/firebase/period_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/my_widget_provider.dart';
import 'package:myokr/screen/add_okr/component/button_widget.dart';
import 'package:myokr/screen/my_okr/component/list_objectives_widget.dart';
import 'package:myokr/screen/my_okr/component/tab_bar.dart';
import 'package:provider/provider.dart';

class MyOkrScreen extends StatefulWidget {
  const MyOkrScreen({Key? key}) : super(key: key);

  static const routeName = '/my-okr-screen';
  @override
  State<MyOkrScreen> createState() => _MyOkrScreenState();
}

class _MyOkrScreenState extends State<MyOkrScreen> {
  PeriodModel? periodModel;
  List<ObjectivesModel> listObjectives = [];
  ObjectivesStatus? statusObjectives;
  ObjectivesProvider? objectivesProvider;
  ResultProvider? resultProvider;
  List<ResultsModel> listResult = [];
  ResultStatus? resultStatus;
  String userid = '';
  @override
  void initState() {
    context.read<ObjectivesProvider>().setStatus(ObjectivesStatus.loading);
    context.read<PeriodProvider>().getPeriod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    periodModel = context.watch<PeriodProvider>().nowPeriod;
    objectivesProvider = context.watch<ObjectivesProvider>();
    // resultProvider = context.watch<ResultProvider>();
    // listResult = resultProvider!.resultList;
    userid = context.watch<User?>()!.uid;
    if (periodModel != null) {
      objectivesProvider!.loadObj(periodModel!.id, userid);
      listObjectives = objectivesProvider!.objectivesList;
      statusObjectives = objectivesProvider!.getStatus;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 5, top: 10, right: 20, bottom: 10),
        child: periodModel != null
            ? SingleChildScrollView(
                primary: false,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 20, top: 10, bottom: 10),
                  child: width < 1000
                      ? SingleChildScrollView(
                          primary: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              topWidget(context),
                              statusObjectives != ObjectivesStatus.loading
                                  ? statusObjectives == ObjectivesStatus.success
                                      ? ListObjectives(
                                          listObjectives: listObjectives,
                                          status: statusObjectives!)
                                      : SizedBox(
                                          height: 200,
                                          width: double.infinity,
                                          child: Center(
                                              child: getTittleTextBlack(
                                                  'Data does not exist', 18)))
                                  : const SizedBox(
                                      width: double.infinity,
                                      height: 300,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              const TabBarMyOkr()
                            ],
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  topWidget(context),
                                  ListObjectives(
                                      listObjectives: listObjectives,
                                      status: statusObjectives!),
                                ],
                              ),
                            ),
                            const Expanded(flex: 2, child: TabBarMyOkr()),
                          ],
                        ),
                ),
              )
            : const SizedBox(
                height: 500,
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }

  SingleChildScrollView topWidget(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
              width: 220,
              child: PeriodWidget(
                type: 0,
              )),
          const SizedBox(
            width: 40,
          ),
          SizedBox(
            width: 150,
            child: ButtonWidget(
                onTap: () {
                  context.read<MyWidgetProvider>().changePage('0-1');
                },
                color: Colors.blue,
                tittle: 'New Obj'),
          )
        ],
      ),
    );
  }
}
