import 'package:flutter/material.dart';
import 'package:myokr/model/firebase/result_model.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/screen/my_okr/component/view_okr/update_result.dart';
import 'package:provider/provider.dart';

class ViewOKRWidget extends StatefulWidget {
  const ViewOKRWidget({Key? key}) : super(key: key);

  @override
  State<ViewOKRWidget> createState() => _ViewOKRWidgetState();
}

class _ViewOKRWidgetState extends State<ViewOKRWidget> {
  ResultProvider? resultProvider;
  List<ResultsModel> listResult = [];
  bool showResult = true;
  @override
  Widget build(BuildContext context) {
    resultProvider = context.watch<ResultProvider>();
    listResult = resultProvider!.resultList;
    double width = MediaQuery.of(context).size.width;
    var objectivesModel = context.watch<ObjectivesProvider>().clickObj;
    return listResult.isNotEmpty
        ? Container(
            padding: width < 1000 ? null : const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => UpdateWidget(
                      index: index,
                      objectivesModel: objectivesModel!,
                      resultsModel: listResult[index]),
                  itemCount: listResult.length,
                )
              ],
            ),
          )
        : Container();
  }
}
