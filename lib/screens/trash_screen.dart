import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/case_screen.dart';
import 'package:gbv_tracker/screens/notification_screen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/drawer.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';

import 'login_screen.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';

class TrashScreen extends StatefulWidget {
  static String id = 'trash-screen';
  @override
  _TrashScreenState createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  String fromDate = DateTime.now().subtract(Duration(days: 1)).toString();
  String toDate = DateTime.now().toString();
  String start = "50", limit = "0";
  DateTime _date = DateTime.now();
  bool loadingData = false;

  DeletedCaseData() async {
    setState(() {
      loadingData = true;
    });
    var user_category = await getRef("user_category");

    if (user_category != null) {
      if (user_category == "SU") {
        deletedCasesListJson = await getDeletedCaseList(start, limit);
        setState(() {
          if (deletedCasesListJson['status'] == "1") {
            deletedCasesList = deletedCasesListJson['data'];
            print(deletedCasesList);
          }
        });
      } else {}
    } else {}

    setState(() {
      loadingData = false;
    });
  }

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
    DeletedCaseData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trash'),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.pushNamed(context, NotificationScreen.id);
              },
            ),
            LogoutButton(
              onPressed: () {
                //TODO : Logout operation here
                Logout() ;
                Navigator.popAndPushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
        drawer: NavDrawer(),
        body: ListView(
          padding: EdgeInsets.all(10).copyWith(bottom: 20),
          children: [
            ExpansionTile(
              title: Text('Filter'),
              leading: Icon(Icons.filter_list),
              children: [
                Wrap(
                  spacing: 4,
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
                          child: Text('Select District'),
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
                      child: Text('Preview', style: TextStyle(color: Colors.white),),
                      color: Colors.blueAccent,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm'),
                              content: Text('Do you want to view Deleted cases ?'),
                              actions: [
                                FlatButton(
                                  child: Text('Cancel',style: TextStyle(color: Colors.black),),
                                  color: Colors.grey,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),


                                FlatButton(
                                  child: Text('Confirm', style: TextStyle(color: Colors.white),),
                                  onPressed: () {
                                    //TODO : Submit Trash filter data

                                  },
                                  color: Colors.blueAccent,
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            loadingData
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: [
                          DataColumn(label: (Text('Channel'))),
                          DataColumn(label: (Text('Phone Used to report'))),
                          DataColumn(label: (Text('Victim\'s name'))),
                          DataColumn(label: (Text('Violence Type'))),
                          DataColumn(label: (Text('Description'))),
                          DataColumn(label: (Text('Date'))),
                          DataColumn(label: (Text('Reason'))),
                        ],
                        rows: deletedCasesList
                            .map(
                              ((element) => DataRow(
                                    onSelectChanged: (b) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CaseScreen(
                                          parentScreen: TrashScreen.id,
                                          case_id: element["case_id"],
                                        );
                                      }));
                                    },
                                    cells: <DataCell>[
                                      DataCell(Text(element["channel"])),
                                      DataCell(Text(element[
                                                  "telephone_used_to_report"] !=
                                              null
                                          ? element["telephone_used_to_report"]
                                          : "N/A")),
                                      DataCell(Text(element["victim_name"])),
                                      DataCell(Text(element["violence_type"])),
                                      DataCell(Text(
                                          element["violence_description"] !=
                                                  null
                                              ? element["violence_description"]
                                              : "N/A")),
                                      DataCell(Text(element["received_date"])),
                                      DataCell(Text(element["reason"])),
                                    ],
                                  )),
                            )
                            .toList()),
                  ),
          ],
        ),
      ),
    );
  }
}
