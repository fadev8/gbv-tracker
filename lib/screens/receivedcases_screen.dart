import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/CaseScreen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/drawer.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';

import 'login_screen.dart';

class ReceivedCaseScreen extends StatefulWidget {
  static String id = 'received-cases-screen';
  @override
  _ReceivedCaseScreenState createState() => _ReceivedCaseScreenState();
}

class _ReceivedCaseScreenState extends State<ReceivedCaseScreen> {
  String fromDate, toDate;
  List<DataRow> dataRows = List();
  List<Case> cases = [
    Case(
        abuserAgeRange: '14-17',
        abuserSex: 'MALE',
        age: 25,
        channel: "USSD",
        districtId: 2,
        id: 2598,
        names: "SONIA",
        receivedDate: "2020-08-26",
        status: "PENDING",
        ussdUserId: 5155,
        victimPhoneNid: "1199280059936114",
        violenceType: "SEXUAL",
        victimMaritalStatus: "MARRIED",
        victimSector: 1,
        victimSex: 'FEMALE',
        violenceDescription: "You see"),
    Case(
        abuserAgeRange: '14-17',
        abuserSex: 'MALE',
        age: 35,
        channel: "USSD",
        districtId: 2,
        id: 2598,
        names: "CAROL",
        receivedDate: "2020-08-26",
        status: "PENDING",
        ussdUserId: 5155,
        victimPhoneNid: "1199280059936114",
        violenceType: "SEXUAL",
        victimMaritalStatus: "MARRIED",
        victimSector: 1,
        victimSex: 'FEMALE',
        violenceDescription: "Cnskjde"),
    Case(
        abuserAgeRange: '14-17',
        abuserSex: 'MALE',
        age: 29,
        channel: "USSD",
        districtId: 2,
        id: 2598,
        names: "ALIMA",
        receivedDate: "2020-08-26",
        status: "PENDING",
        ussdUserId: 5155,
        victimPhoneNid: "1199280059936114",
        violenceType: "SEXUAL",
        victimMaritalStatus: "MARRIED",
        victimSector: 1,
        victimSex: 'FEMALE',
        violenceDescription: "You see"),
  ];
  DateTime _date = DateTime.now();
  bool isRowSelected = false;

  Future<String> initDatePicker() async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (pickedDate != null && pickedDate != _date) {
      _date = pickedDate;
    }
    return _date.toString();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Received Cases'),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                //TODO : show notifications here
              },
            ),
            LogoutButton(
              onPressed: () {
                //TODO : Logout operation here
                Navigator.popAndPushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
        drawer: NavDrawer(),
        body: ListView(
          padding: EdgeInsets.all(10).copyWith(bottom: 20),
          children: [
            Wrap(
              spacing: 20,
              children: [
                DropdownButton(
                  onChanged: (index) {
                    if (index != 0) {
                      setState(() {
                        //TODO action when the menu is tapped
                        print('selected index $index');
                      });
                    }
                  },
                  items: [
                    //TODO populate the Dropdown with data
                    DropdownMenuItem(
                      child: Text('District'),
                    ),
                    DropdownMenuItem(
                      child: Text('District 1'),
                    ),
                    DropdownMenuItem(
                      child: Text('District 2'),
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
                      child: Text('GBV type'),
                    ),
                    DropdownMenuItem(
                      child: Text('Received cases'),
                    ),
                    DropdownMenuItem(
                      child: Text('Followup in progress'),
                    ),
                  ],
                ),
              ],
            ),
            Wrap(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                      color: Colors.grey,
                      child: Text('From :'),
                      onPressed: () async {
                        fromDate = await initDatePicker();
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        fromDate ?? '',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      color: Colors.grey,
                      padding: EdgeInsets.all(0),
                      child: Text('To :'),
                      onPressed: () async {
                        toDate = await initDatePicker();
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        toDate ?? '',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text('Submit', style: kButtonTextStyle),
                  color: Colors.blueAccent,
                  onPressed: () {
                    //TODO Submit the value of the Dropdown button
                  },
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: (Text('Phone Used to report'))),
                  DataColumn(label: (Text('Victim\'s name'))),
                  DataColumn(label: (Text('Description'))),
                  DataColumn(label: (Text('Date'))),
                ],
                rows: cases.map((cas) => DataRow(
                  onSelectChanged: (b){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return CaseScreen(parentScreen: ReceivedCaseScreen.id,actualCase: cas,);
                      }
                    ));
                  },
                  cells: [
                    DataCell(Text('${cas.victimPhoneNid}')),
                    DataCell(Text('${cas.names}')),
                    DataCell(Text('${cas.violenceDescription}')),
                    DataCell(Text('${cas.receivedDate}')),
                  ],
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
