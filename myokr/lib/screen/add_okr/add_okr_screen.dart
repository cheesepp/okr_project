// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myokr/item/constants.dart';
import 'package:myokr/item/period_widget.dart';
import 'package:myokr/item/random_string.dart';
import 'package:myokr/item/show_snack_bar.dart';
import 'package:myokr/model/firebase/period_model.dart';
import 'package:myokr/model/local_storage/result_hive_model/results_hive_model.dart';
import 'package:myokr/provider/firebase/add_objectives_provider.dart';
import 'package:myokr/provider/firebase/period_provider.dart';
import 'package:myokr/provider/local_storage/raw_objectives.dart';
import 'package:myokr/screen/add_okr/component/button_widget.dart';
import 'package:myokr/screen/add_okr/component/form_field_widget.dart';
import 'package:myokr/screen/add_okr/component/result_item.dart';
import 'package:provider/provider.dart';

class AddOrkScreen extends StatefulWidget {
  const AddOrkScreen({Key? key}) : super(key: key);
  static const routeName = '/add-okr';
  @override
  State<AddOrkScreen> createState() => _AddOrkScreenState();
}

class _AddOrkScreenState extends State<AddOrkScreen> {
  PeriodModel? periodModel;
  TextEditingController objectController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Box<ResultsHiveModel>? box;
  List<ResultsHiveModel> listHiveModel = [];
  String id = getRandomString(20);
  bool loadRs = false;
  bool loadOb = false;
  bool clearRs = false;
  @override
  void initState() {
    getResult();
    getObject();
    context.read<PeriodProvider>().getPeriod();
    super.initState();
  }

  @override
  void dispose() {
    objectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    periodModel = context.watch<PeriodProvider>().nowPeriod;
    double width = MediaQuery.of(context).size.width;
    AddRawObjectiveProvider addRaw = context.watch<AddRawObjectiveProvider>();
    return periodModel != null
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              primary: false,
              child: Consumer<AddOjectivesProvider>(
                builder: (context, provider, child) => loadRs &&
                        loadOb &&
                        provider.getCount != 0
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                const PeriodWidget(type: 1),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        addRaw.removeOb();
                                        objectController.clear();
                                        context
                                            .read<AddOjectivesProvider>()
                                            .setCount(1);
                                        setState(() {
                                          clearRs = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color.fromARGB(
                                              255, 247, 121, 112),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: const SizedBox(
                                        width: 100,
                                        height: 40,
                                        child: Center(
                                          child: Text(
                                            'Clear Form',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Form(
                              key: globalKey,
                              child: FormFieldWidget(
                                onChanged: (txt) {
                                  addRaw.saveObject(txt);
                                },
                                fontStyle: true,
                                padding: false,
                                maxLength: true,
                                maxLines: 4,
                                controller: objectController,
                                hintText:
                                    'Viết các định hướng và mục tiêu quan trọng sẽ đạt được',
                                labelText: 'Objectives',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kGreyColorWidget,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => ResultItem(
                                    clearRs: clearRs,
                                    periodId: periodModel!.id,
                                    objectives: objectController.text,
                                    resultsHiveModel: listHiveModel.isNotEmpty
                                        ? listHiveModel.length ==
                                                provider.getCount
                                            ? listHiveModel[index]
                                            : ResultsHiveModel()
                                        : ResultsHiveModel(),
                                    id: id,
                                    index: index,
                                    onTap: () {
                                      if (provider.getCount > 1) {
                                        provider.decreaseCount();
                                        box!.deleteAt(index);
                                      }
                                    },
                                  ),
                                  itemCount: provider.getCount,
                                  physics: const NeverScrollableScrollPhysics(),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: ButtonWidget(
                                    onTap: () {
                                      setState(() {
                                        provider.increaseCount();
                                      });
                                    },
                                    color: const Color.fromARGB(
                                        255, 165, 198, 228),
                                    tittle: 'Add new key result')),
                            const SizedBox(
                              height: 20,
                            ),
                            width < 1000
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buttonItem(
                                          'COMFIRM AND SUBMIT OKR', context),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      buttonItem('SAVE AS DRAFT', context),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        flex: 17,
                                        child: buttonItem(
                                            'COMFIRM AND SUBMIT OKR', context),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        flex: 17,
                                        child: buttonItem(
                                            'SAVE AS DRAFT', context),
                                      )
                                    ],
                                  ),
                          ],
                        ))
                    : Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ))
        : Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  ButtonWidget buttonItem(tittle, contex) {
    AddOjectivesProvider addOjectivesProvider =
        context.read<AddOjectivesProvider>();
    AddRawObjectiveProvider addRawObjectiveProvider =
        context.read<AddRawObjectiveProvider>();
    return ButtonWidget(
      color: Colors.white,
      onTap: () async {
        if (globalKey.currentState!.validate()) {
          if (tittle == 'COMFIRM AND SUBMIT OKR') {
            addOjectivesProvider.setRequestBool(true);
            await Future.delayed(const Duration(seconds: 2));
            objectController.clear();
            showSnackBar(contex, 'Successfully comfirmed and submited okr');
            addOjectivesProvider.setRequestBool(false);
            addOjectivesProvider.setCount(1);
            addOjectivesProvider.clearListRs();
            setState(() {
              id = getRandomString(20);
            });
            addRawObjectiveProvider.removeOb();
          } else if (tittle == 'SAVE AS DRAFT') {
            setState(() {});
            addRawObjectiveProvider.removeOb();
            addRawObjectiveProvider.setAddRawBool(true);
            await Future.delayed(const Duration(seconds: 1));
            addRawObjectiveProvider.setAddRawBool(false);
            showSnackBar(contex, 'Successfully saved as draft');
          }
        }
      },
      tittle: tittle,
    );
  }

  Future<void> getResult() async {
    AddOjectivesProvider addObjectProvider =
        context.read<AddOjectivesProvider>();
    box = await Hive.openBox<ResultsHiveModel>('results');
    if (box!.length > 0) {
      listHiveModel = box!.values.toList();
    }
    if (listHiveModel.isNotEmpty) {
      addObjectProvider.setCount(listHiveModel.length);
    }

    setState(() {
      loadRs = true;
    });
  }

  Future<void> getObject() async {
    var box = Hive.box('objective');
    String obj = await box.get('obj') ?? '';
    if (obj.isNotEmpty) {
      setState(() {
        objectController.text = obj;
      });
    }
    setState(() {
      loadOb = true;
    });
  }
}
