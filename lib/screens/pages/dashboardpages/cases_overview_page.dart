import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/widgets/figure_data_tile.dart';
import 'package:gbv_tracker/widgets/overview_data_tile.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';

class CasesOverviewPage extends StatelessWidget {
  //TODO here are values to be filled up from the API
  int receivedToday = 2;
  int receivedLast7days = 9;
  int receivedMonth = 30;
  int receivedLast90days = 36;
  //second part of data
  int totalCases = 434;
  int pendingCases = 23;
  int followupProgress = 12;
  int closesCases = 34;

  CasesOverviewPage({
    this.closesCases,
    this.receivedLast7days,
    this.receivedToday,
    this.receivedLast90days,
    this.followupProgress,
    this.pendingCases,
    this.totalCases,
    this.receivedMonth,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(9).copyWith(bottom: 24),
      children: [

        ExpansionTile(
          leading: Icon(Icons.filter_list),
          title: Text('Filter'),
          children: [
            Wrap(
              spacing: 6,
              children: [
                DropdownButton(
                  onChanged: (index) {
                    //TODO action when the menu is tapped
                    print('selected index $index');
                  },
                  items: [
                    //TODO populate the Dropdown with data
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                  ],
                ),
                DropdownButton(
                  focusColor: Colors.grey,
                  onChanged: (index) {
                    //TODO action when the menu is tapped
                    print('selected index $index');
                  },
                  items: [
                    //TODO populate the Dropdown with data
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                  ],
                ),
                DropdownButton(
                  onChanged: (index) {
                    //TODO action when the menu is tapped
                    print('selected index $index');
                  },
                  items: [
                    //TODO populate the Dropdown with data
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                    DropdownMenuItem(
                      child: Text('Filter by Province'),
                    ),
                  ],
                ),
                RoundedButton(
                  title: 'Submit',
                  color: Colors.blueAccent,
                  onPress: () {
                    //TODO Submit the value of the Dropdown button
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
        Column(
          children: [
            OverviewDataTile(
              periodName: 'Today',
              casesNumber: receivedToday,
              casesType: 'Received cases',
              icon: Icons.today,
              iconColor: Colors.red,
            ),
            SizedBox(
              height: 8,
            ),
            OverviewDataTile(
              periodName: 'Last 7 Days',
              casesNumber: receivedLast7days,
              casesType: 'Received cases',
              icon: FontAwesomeIcons.calendarWeek,
              iconColor: Colors.green,
            ),
            SizedBox(
              height: 8,
            ),
            OverviewDataTile(
              periodName: 'This Month',
              casesNumber: receivedMonth,
              casesType: 'Received cases',
              icon: Icons.calendar_today,
              iconColor: Colors.orangeAccent,
            ),
            SizedBox(
              height: 8,
            ),
            OverviewDataTile(
              periodName: 'Last 90 Days',
              casesNumber: receivedLast90days,
              casesType: 'Received cases',
              icon: Icons.calendar_today,
              iconColor: Colors.lightBlueAccent,
            ),
            SizedBox(
              height: 16,
            ),
            Divider(
              color: Colors.teal,
            ),
            SizedBox(
              height: 16,
            ),
            FigureDataTile(
              title: 'Total Cases',
              dataNumber: totalCases,
              icon: FontAwesomeIcons.briefcase,
              iconColor: Colors.lightBlueAccent,
            ),
            SizedBox(
              height: 8,
            ),
            FigureDataTile(
              title: 'Pending Cases',
              dataNumber: pendingCases,
              icon: FontAwesomeIcons.hourglassEnd,
              iconColor: Colors.lightBlueAccent,
            ),
            SizedBox(
              height: 8,
            ),
            FigureDataTile(
              title: 'Followup in progress',
              dataNumber: followupProgress,
              icon: Icons.thumb_up,
              iconColor: Colors.lightBlueAccent,
            ),
            SizedBox(
              height: 8,
            ),
            FigureDataTile(
              title: 'Closed Cases',
              dataNumber: closesCases,
              icon: Icons.lock,
              iconColor: Colors.lightBlueAccent,
            ),
            SizedBox(
              height: 8,
            ),
          ],
        )
      ],
    );
  }
}
