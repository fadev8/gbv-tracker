import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/case_screen.dart';
import 'package:gbv_tracker/screens/notification_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/drawer.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';

import 'login_screen.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';

class FollowupScreen extends StatefulWidget {
  static String id = 'followup-screen';
  @override
  _FollowupScreenState createState() => _FollowupScreenState();
}

class _FollowupScreenState extends State<FollowupScreen> {
  String fromDate = DateTime.now().subtract(Duration(days: 1)).toString();
  String toDate = DateTime.now().toString();
  String start = "50", limit = "0";
  int startOffset = 50, limitOffset = 0;
  bool moreCasesAvailable = true;
  bool loadingMoreCases = false;
  ScrollController _controller = ScrollController();

  //List<DataRow> dataRows = List();
  DateTime _date = DateTime.now();
  bool loadingData = false;

  String District;
  List Districtdata = [];
  String violenceType = 'SELECT';


  caseResearch(String Status,String District,String Type,String from,String to,String start, String limit) async {
    setState(() {
      loadingData = true;
    });
    var user_category = await getRef("user_category");
    supportedCasesList=[];
    if (user_category != null) {
//      if (user_category == "SU") {
      supportedCasesListJson = await getReceivedCaseResearch(Status,District,Type,from,to,start, limit);
      setState(() {
        if (supportedCasesListJson['status'] == "1") {
          supportedCasesList.addAll(supportedCasesListJson['data']);
          print(supportedCasesList);
        }
        else
          {
//            print(supportedCasesList['status']);
//            print(supportedCasesList['message']);
          }
      });
//      } else {}
    } else {}

    setState(() {
      loadingData = false;
    });
  }


  Future<String> DistrictData() async {

    var user_category = await getRef("user_category");
    Districtdata = [];
    if (user_category != null) {
      DistrictListJson = await getAllDistrict();
      setState(() {
        if (DistrictListJson['status'] == "1") {
          Districtdata = DistrictListJson['data'];
          print(Districtdata);
        }
      });
    } else {}

  }

  SupportedCaseData() async {
    setState(() {
      loadingData = true;
    });
    var user_category = await getRef("user_category");

    if (user_category != null) {
//      if (user_category == "SU") {
        supportedCasesListJson = await getSupportedCaseList(start, limit);
        setState(() {
          if (supportedCasesListJson['status'] == "1") {
            supportedCasesList = supportedCasesListJson['data'];
            print(supportedCasesList);
          }
        });
//      } else {}
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
//      if (user_category == "SU") {
        supportedCasesListJson = await getSupportedCaseList(start, limit);
        setState(() {
          if (supportedCasesListJson['status'] == "1") {
            supportedCasesList.addAll(supportedCasesListJson['data']);
            print(supportedCasesList);
          }
        });
//      } else {}
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
    SupportedCaseData();
    DistrictData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Followup in progress'),
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
              leading: Icon(Icons.filter_list),
              title: Text('Filter'),
              children: [
                Wrap(
                  spacing: 20,
                  children: [
                    DropdownButton(
                      focusColor: Colors.grey,
                      isExpanded: true,
                      onChanged: (newVal) {
                        setState(() {
                          District = newVal;
                          print(District);

                        });
                      },
                      value: District,
                      items: Districtdata.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['name']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                    ),
                    DropdownButton(
                      focusColor: Colors.grey,
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          violenceType = val;
                          print(violenceType);
                        });
                      },
                      items: [
                        //TODO populate the Dropdown with data
                        DropdownMenuItem(
                          child: Text(violenceType),
                        ),
                        DropdownMenuItem(
                          child: Text('Physical'),
                          value: 'Physical',
                        ),
                        DropdownMenuItem(
                          child: Text('Psychological'),
                          value: 'Psychological',
                        ),
                        DropdownMenuItem(
                          child: Text('Sexual'),
                          value: 'Sexual',
                        ),
                        DropdownMenuItem(
                          child: Text('Property'),
                          value: 'Property',
                        ),
                        DropdownMenuItem(
                          child: Text('Teen Pregnancy'),
                          value: 'Teen Pregnancy',
                        ),
                        DropdownMenuItem(
                          child: Text('Child Abuse'),
                          value: 'Child Abuse',
                        ),
                        DropdownMenuItem(
                          child: Text('Other'),
                          value: 'Other',
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
                        print(District +" ==  "+violenceType+ "  == "+fromDate+"== "+toDate);

                        if(violenceType != "SELECT" &&  District != "" &&  fromDate != "" &&  toDate != "")
                        {
                          caseResearch( "SUPPORTED", District, violenceType, fromDate, toDate, start,  limit);
                        }
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
                          DataColumn(label: (Text('User name'))),
                          DataColumn(label: (Text('Victim\'s name'))),
                          DataColumn(label: (Text('Violence Type'))),
                          DataColumn(label: (Text('Description'))),
                          DataColumn(label: (Text('Date'))),
                        ],
                        rows: supportedCasesList
                            .map(
                              ((element) => DataRow(
                                    onSelectChanged: (b) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CaseScreen(
                                          parentScreen: FollowupScreen.id,
                                          case_id: element["case_id"],
                                        );
                                      }));
                                    },
                                    cells: <DataCell>[

                                      DataCell(Text(element["user_firstname"] !=
                                          null
                                          ? element["user_firstname"]+" "+element["user_lastname"]
                                          : " ")),
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
                            .toList()),
                  ),
          ],
        ),
      ),
    );
  }
}
