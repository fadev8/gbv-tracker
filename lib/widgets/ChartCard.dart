import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ChartCard extends StatelessWidget {

  final Map<String, double> dataMap;
  final List<Color> colorList;

  ChartCard({@required this.dataMap, @required this.colorList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Card(
        margin: EdgeInsets.only(bottom: 4),
        elevation: 2,
        child: PieChart(
          showChartValuesInPercentage: false,
          dataMap: dataMap,
          colorList: colorList,
          legendPosition: LegendPosition.right,
        ),
      ),
    );
  }
}