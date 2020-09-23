import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class ReceivedCaseScreen extends StatefulWidget {
  static String id = 'received-cases-screen';
  @override
  _ReceivedCaseScreenState createState() => _ReceivedCaseScreenState();
}

class _ReceivedCaseScreenState extends State<ReceivedCaseScreen> {
  String fromDate = DateTime.now().subtract(Duration(days: 1)).toString();
  String toDate = DateTime.now().toString();

  ScrollController _controller = ScrollController();
  String start = "50", limit = "0";
  int startOffset = 50, limitOffset = 0;
  bool moreCasesAvailable = true;
  bool loadingMoreCases = false;
  List<DataRow> dataRows = List();

  DateTime _date = DateTime.now();
  bool loadingData = false;

  ReceivedCaseData() async {
    setState(() {
      loadingData = true;
    });
    var user_category = await getRef("user_category");

    if (user_category != null) {
      if (user_category == "SU") {
        receivedCasesListJson = await getReceivedCaseList(start, limit);
        setState(() {
          if (receivedCasesListJson['status'] == "1") {
            receivedCasesList.addAll(receivedCasesListJson['data']);
            print(receivedCasesList);
          }
        });
      } else {}
    } else {}

    setState(() {
      loadingData = false;
    });
  }

  loadMoreCases() async {
    //print('invoqued loading more cases...');
    if (moreCasesAvailable == false) {
      print('returning...morecaseaval');
      return;
    }
    if (loadingMoreCases == true) {
      print('returning loadin..');
      return;
    }
    loadingMoreCases = true;

    limitOffset = startOffset;
    startOffset = startOffset * 2;
    start = '$startOffset';
    limit = '$limitOffset';

    print('start is now to $start');

    var user_category = await getRef("user_category");

    if (user_category != null) {
      if (user_category == "SU") {
        receivedCasesListJson = await getReceivedCaseList(start, limit);

        if (receivedCasesListJson['status'] == "1") {
          receivedCasesList = receivedCasesListJson['data'];
          print('Data is retrieved');
        }
      } else {}
    } else {}
    setState(() {});

    loadingMoreCases = false;
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
    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        loadMoreCases();
      }
    });
    ReceivedCaseData();
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
                Navigator.pushNamed(context, NotificationScreen.id);
              },
            ),
            LogoutButton(
              onPressed: () {
                //TODO : Logout operation here
                Logout();
                Navigator.popAndPushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
        drawer: NavDrawer(),
        body: ListView(
          controller: _controller,
          padding: EdgeInsets.all(10).copyWith(bottom: 20),
          children: [
            ExpansionTile(
              title: Text('Filter'),
              leading: Icon(Icons.filter_list),
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
                      child: Text(
                        'Preview',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blueAccent,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm'),
                              content:
                                  Text('Do you want to view Received Cases?'),
                              actions: [
                                FlatButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  color: Colors.grey,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    //TODO : Submit Received Case filter data
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
                        ],
                        rows: receivedCasesList
                            .map(
                              ((element) => DataRow(
                                    onSelectChanged: (b) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CaseScreen(
                                          parentScreen: ReceivedCaseScreen.id,
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
                                    ],
                                  )),
                            )
                            .toList()

//                  DataColumn(label: (Text('Phone Used to report'))),
//                  DataColumn(label: (Text('Victim\'s name'))),
//                  DataColumn(label: (Text('Description'))),
//                  DataColumn(label: (Text('Date'))),
//                ],
//                rows: cases.map((cas) => DataRow(
//                  onSelectChanged: (b){
//                    Navigator.push(context, MaterialPageRoute(
//                      builder: (context){
//                        return CaseScreen(parentScreen: ReceivedCaseScreen.id,actualCase: cas,);
//                      }
//                    ));
//                  },
//                  cells: [
//                    DataCell(Text('${cas.victimPhoneNid}')),
//                    DataCell(Text('${cas.names}')),
//                    DataCell(Text('${cas.violenceDescription}')),
//                    DataCell(Text('${cas.receivedDate}')),
//                  ],
//                )).toList(),

                        ),
                  ),
          ],
        ),
      ),
    );
  }
}
