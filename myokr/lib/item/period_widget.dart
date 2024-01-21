import 'package:flutter/material.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/model/firebase/period_model.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/provider/firebase/period_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/my_widget_provider.dart';
import 'package:provider/provider.dart';

class PeriodWidget extends StatefulWidget {
  const PeriodWidget({
    Key? key,
    required this.type,
  }) : super(key: key);
  final int type;
  @override
  State<PeriodWidget> createState() => _PeriodWidgetState();
}

class _PeriodWidgetState extends State<PeriodWidget> {
  PeriodProvider? periodProvider;
  PeriodModel? periodModel;
  @override
  void initState() {
    periodProvider = context.read<PeriodProvider>();
    periodProvider!.getPeriod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    periodModel = context.watch<PeriodProvider>().nowPeriod;
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: getTittleTextBlack('Select Period', 24),
                content: Container(
                  color: Colors.white,
                  height: 400,
                  width: 300,
                  child: SingleChildScrollView(
                    primary: false,
                    child: periodProvider!.periodList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    context
                                        .read<PeriodProvider>()
                                        .getIndexP(index);
                                    if (widget.type == 0) {
                                      context
                                          .read<MyWidgetProvider>()
                                          .setTabBarKey(0);
                                      context
                                          .read<ObjectivesProvider>()
                                          .setStatus(ObjectivesStatus.loading);
                                      context
                                          .read<ObjectivesProvider>()
                                          .removeClickObj();
                                      context
                                          .read<ResultProvider>()
                                          .resultList
                                          .clear();
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Radio(
                                            value: index,
                                            groupValue: context
                                                .read<PeriodProvider>()
                                                .getIndex,
                                            onChanged: (value) {
                                              context
                                                  .read<PeriodProvider>()
                                                  .getIndexP(index);
                                              if (widget.type == 0) {
                                                context
                                                    .read<MyWidgetProvider>()
                                                    .setTabBarKey(0);
                                                context
                                                    .read<ObjectivesProvider>()
                                                    .setStatus(ObjectivesStatus
                                                        .loading);
                                                context
                                                    .read<ObjectivesProvider>()
                                                    .removeClickObj();
                                                context
                                                    .read<ResultProvider>()
                                                    .resultList
                                                    .clear();
                                              }
                                              Navigator.pop(context);
                                            }),
                                        periodBox(
                                            periodProvider!.periodList[index]),
                                      ],
                                    ),
                                  ),
                                )),
                            itemCount: periodProvider!.periodList.length,
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              )),
      child: periodModel != null
          ? periodBox(periodProvider!.nowPeriod)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Container periodBox(PeriodModel periodModel) {
    return Container(
        color: Colors.white,
        height: 50,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  border: Border.all(width: 1)),
              child: Center(
                child: getTittleTextBlack(periodModel.period, 18),
              ),
            ),
            Container(
              height: 50,
              width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  border: Border.all(width: 1)),
              child: Align(
                alignment: Alignment.centerRight,
                child: getTittleTextBlack(periodModel.month.toString(), 18),
              ),
            )
          ],
        ));
  }
}
