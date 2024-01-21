import 'package:flutter/material.dart';
import 'package:myokr/item/text_item.dart';
import 'package:myokr/model/status_chart_model.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class DonutChart extends StatelessWidget {
  const DonutChart(
      {Key? key,
      required this.count,
      required this.listStatus,
      required this.tittle})
      : super(key: key);
  final int count;
  final String tittle;
  final List<StatusChartModel> listStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: SfCircularChart(
        tooltipBehavior: TooltipBehavior(
            enable: true, tooltipPosition: TooltipPosition.pointer),
        legend: Legend(
            isVisible: true, position: LegendPosition.right, iconHeight: 24),
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
        series: <CircularSeries>[
          DoughnutSeries<StatusChartModel, String>(
            dataSource: listStatus,
            animationDuration: 500,
            xValueMapper: (StatusChartModel data, _) => data.name,
            yValueMapper: (StatusChartModel data, _) => data.count,
          )
        ],
      ),
    );
  }
}
