import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverviewDataTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final String periodName;
  final int casesNumber;
  final String casesType;
  final Color textColor;

  OverviewDataTile(
      {@required this.icon,
      @required this.iconColor,
      this.borderColor,
      this.textColor,
      this.periodName,
      this.casesNumber,
      this.casesType});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(10).copyWith(right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: iconColor,
              child: Icon(icon,color: Colors.white,size: 32,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  periodName ?? '',
                  style: TextStyle(
                    color: iconColor ?? textColor,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '$casesNumber',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: textColor),
                ),
                Text(
                  casesType ?? '',
                  style: TextStyle(
                    color: textColor ?? Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
