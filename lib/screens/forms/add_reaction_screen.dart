import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/notification_screen.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:toast/toast.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';
import 'package:gbv_tracker/core/api.dart';

import '../dashboard_screen.dart';

class AddReactionScreen extends StatefulWidget {
  static String id = 'edit_case_screen';
  final String case_id;
  AddReactionScreen({@required this.case_id});

  @override
  _AddReactionScreenState createState() => _AddReactionScreenState();
}

class _AddReactionScreenState extends State<AddReactionScreen> {
  //variables
  String selectedIntervention = "SELECT",
      interventionDoneBy = "SELECT",
      interventionDescription;
  TextEditingController controller = new TextEditingController();

  //from Date and to date variables
  DateTime _date = DateTime.now();
  String fromDate="",toDate="";

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

  SupportCase(String interventionDone, String interventionDoneBy,
      String interventionDescription,String from,String to) async {
    http.Response response = await http.post(BASE_URL + "claims", body: {
      'action': "Add-Suport",
      'intervation': interventionDone,
      'intervation_by': interventionDoneBy,
      'service_get': interventionDescription,
      'from': from,
      'to': to,
      'specification': "N/A",
      'case_id': widget.case_id,
    });
    print(response.statusCode);

    //check http code
    if (response.statusCode == 200) {
      responseJson = convert.jsonDecode(response.body);
      print(responseJson);

      if (responseJson['status'] == "1") {
        Toast.show(responseJson['message'], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//        SweetAlert.show(context,
//            title: responseJson['message'], style: SweetAlertStyle.success);

        print(responseJson);

        // save login data

        Navigator.pushNamed(context, FollowupScreen.id);
      } else if (responseJson['status'] == "0") {
        SweetAlert.show(context,
            title: responseJson['message'], style: SweetAlertStyle.error);
      } else
        Toast.show("Invalid Response Status", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (response.statusCode == 500) {
      Toast.show("Server eror", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      SweetAlert.show(context,
          title: "Network Error", style: SweetAlertStyle.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Reaction'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, NotificationScreen.id);
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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text('Intervention done'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: DropdownButton(
                        onChanged: (val) {
                          print(val);
                          setState(() {
                            selectedIntervention = val;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(selectedIntervention.toLowerCase()),
                          ),
                          DropdownMenuItem(
                            child: Text('Forward to RIB/RNP'),
                            value: 'FOWARDED TO RNP/RIB',
                          ),
                          DropdownMenuItem(
                            child: Text('Host in Safe House'),
                            value: 'HOSTED IN SAFE HOUSE',
                          ),
                          DropdownMenuItem(
                            child: Text('Psychological support'),
                            value: 'PSYCHOLOGICAL SUPPORT',
                          ),
                          DropdownMenuItem(
                            child: Text('Legal support'),
                            value: 'LEGAL SUPPORT',
                          ),
                          DropdownMenuItem(
                            child: Text('Supported to access GBV stop center'),
                            value: 'SUPPORTED ON STOP CENTER',
                          ),
                          DropdownMenuItem(
                            child: Text('Financial support'),
                            value: 'FINANCIAL SUPPORT',
                          ),

                          DropdownMenuItem(
                            child: Text('Closed cases'),
                            value: 'CLOSED CASES',
                          ),
                          DropdownMenuItem(
                            child: Text('Others'),
                            value: 'OTHERS',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              //==========Date to display in case of Hosted in SafeHouse =========
              Wrap(
                children: [
                  selectedIntervention == 'HOSTED IN SAFE HOUSE'
                      ? Column(
                          children: [
                            Text('Select Dates'),
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
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        )
                      : Text('')
                ],
              ),

              Wrap(
                children: [
                  Text('Intervention done by'),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (val) {
                        print(val);
                        setState(() {
                          interventionDoneBy = val;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text(interventionDoneBy.toLowerCase()),
                        ),
                        DropdownMenuItem(
                          child: Text('Partners'),
                          value: 'PARTNERS',
                        ),
                        DropdownMenuItem(
                          child: Text('AAR'),
                          value: 'AAR',
                        ),
                        DropdownMenuItem(
                          child: Text('Safeguarding'),
                          value: 'SAFEGUARDING',
                        ),
                        DropdownMenuItem(
                          child: Text('RIB/RNP/One Stop Center'),
                          value: 'RNP/RIB/ONE STOP CENTER',
                        ),
                        DropdownMenuItem(
                          child: Text('Others'),
                          value: 'OTHERS',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Intervention done Description'),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          interventionDescription = val;
                        });
                      },
                      maxLines: 4,
                      controller: controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'What service did the victim get?'),
                    )
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                    onPressed: () {
                      interventionDescription = controller.text;
                      if (interventionDescription != '' &&
                          selectedIntervention != 'SELECT' &&
                          interventionDoneBy != 'SELECT') {
                        print(fromDate+" "+toDate);
                        SupportCase(selectedIntervention, interventionDoneBy,
                            interventionDescription,fromDate,toDate);
                            Navigator.pushNamed(context, DashboardScreen.id);
//                                  Toast.show(user.Display(statusCode), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      } else {
                        Toast.show(
                            "Please fill all the field and proceed", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
