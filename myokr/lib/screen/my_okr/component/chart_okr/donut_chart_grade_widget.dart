import 'package:flutter/material.dart';
import 'package:myokr/item/text_item.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class DonutChartGrade extends StatelessWidget {
  const DonutChartGrade(
      {Key? key,
      required this.count,
      required this.listStatus,
      required this.tittle})
      : super(key: key);
  final int count;
  final String tittle;
  final List<double> listStatus;
  @override
  Widget build(BuildContext context) {
    List<ChartData>? list;

    if (listStatus.length == 1) {
      if (listStatus.first.isNaN) {
        list = [ChartData('${listStatus.first} - ${listStatus.last}', 1)];
      } else {
        list = [ChartData('${listStatus.first}', 1)];
      }
    } else {
      if (listStatus.first.isNaN) {
        list = [ChartData('${listStatus.first} - ${listStatus.last}', 1)];
      } else {
        if (listStatus.last.isNaN) {
          list = [ChartData('${listStatus.first}', 1)];
        } else {
          list = [ChartData('${listStatus.first} - ${listStatus.last}', 1)];
        }
      }
    }
    return Expanded(
      flex: 6,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: SfCircularChart(
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
              widget: Container(
                color: Colors.transparent,
                height: 50,
                child: Column(
                  children: [
                    getTittleTextBlack('$count', 20),
                    Text(
                      tittle,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            )
          ],
          legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              iconHeight: 24,
              textStyle:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: list,
              animationDuration: 500,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => 1,
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
