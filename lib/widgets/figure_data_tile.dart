import 'package:flutter/material.dart';
import 'package:gbv_tracker/widgets/overview_data_tile.dart';

class FigureDataTile extends StatelessWidget {

  final Color iconColor;
  final IconData icon;
  final String title;
  final int dataNumber;

  FigureDataTile({
    @required this.iconColor,
    @required this.icon,
    this.title,
    this.dataNumber

});
  @override
  Widget build(BuildContext context) {
    return OverviewDataTile(
      textColor: Colors.indigo,
      casesNumber: dataNumber,
      casesType: title,
      icon: icon,
      iconColor: iconColor,
    );
  }
}
