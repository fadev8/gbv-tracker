import 'package:flutter/material.dart';
import 'package:gbv_tracker/widgets/ChartCard.dart';
import 'package:pie_chart/pie_chart.dart';

// ignore: must_be_immutable
class AllCasesPage extends StatefulWidget {
  double femaleReportedNumber = 1, maleReportedNumber = 1;
  double realCasesNumber = 1, fakeCasesNumber = 1;
  double newlyReceived = 1, ongoingCases = 1, closedCases = 1;

  AllCasesPage({
    this.ongoingCases,
    this.closedCases,
    this.newlyReceived,
    this.fakeCasesNumber,
    this.realCasesNumber,
    this.maleReportedNumber,
    this.femaleReportedNumber,
  });

  @override
  _AllCasesPageState createState() => _AllCasesPageState();
}

class _AllCasesPageState extends State<AllCasesPage> {
  Map<String, double> genderDataMap = Map();
  Map<String, double> natureDataMap = Map();
  Map<String, double> caseStatusDataMap = Map();

  List<Color> colorList = [Colors.blue, Colors.orangeAccent, Colors.grey];

  @override
  void initState() {
    super.initState();
    genderDataMap = {
      "Female": widget.femaleReportedNumber,
      "Male": widget.maleReportedNumber
    }; //gender origin
    natureDataMap = {
      "Real": widget.realCasesNumber,
      "Fake": widget.fakeCasesNumber
    }; //for Fake or real cases
    caseStatusDataMap = {
      "Newly Received": widget.newlyReceived,
      "Ongoing": widget.ongoingCases,
      "Closed": widget.closedCases
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Wrap(
        children: [
          ChartCard(dataMap: genderDataMap, colorList: colorList),
          ChartCard(dataMap: natureDataMap, colorList: colorList),
          ChartCard(dataMap: caseStatusDataMap, colorList: colorList),
        ],
      )),
    );
  }
}
