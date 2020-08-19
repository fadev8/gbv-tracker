import 'package:flutter/material.dart';
import 'package:gbv_tracker/widgets/ChartCard.dart';
import 'package:pie_chart/pie_chart.dart';


class AllCasesPage extends StatefulWidget {
  @override
  _AllCasesPageState createState() => _AllCasesPageState();
}

class _AllCasesPageState extends State<AllCasesPage> {

  List<Color> colorList = [Colors.blue, Colors.orangeAccent, Colors.grey];

  Map<String, double> genderDataMap = {"Female":149, "Male":30};//gender origin
  Map<String, double> natureDataMap = {"Real":179, "Fake":0};//for Fake or real cases
  Map<String, double> caseStatusDataMap = {"Newly Received":18, "Ongoing":110, "Closed":51};


  @override
  void initState() {
    super.initState();
    //TODO populate every datamap with relevant data

  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child:SingleChildScrollView(
        child: Wrap(
          children: [
            ChartCard(dataMap: genderDataMap, colorList: colorList),
            ChartCard(dataMap: natureDataMap, colorList: colorList),
            ChartCard(dataMap: caseStatusDataMap, colorList: colorList),

          ],
        )
      ),
    );
  }
}


