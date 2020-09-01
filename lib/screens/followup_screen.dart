import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/CaseScreen.dart';
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

  String fromDate, toDate;
  String start="50",  limit ="0";

  //List<DataRow> dataRows = List();
  DateTime _date = DateTime.now();
  bool isRowSelected = false;


                  SupportedCaseData() async
                  {
                    var user_category = await getRef("user_category");
                
                    if (user_category!=null)
                    {
                      if (user_category=="SU")
                      {
                        supportedCasesListJson = await getSupportedCaseList(start,limit);
                        setState(() {
                
                          if(supportedCasesListJson['status']=="1")
                          {
                              supportedCasesList=supportedCasesListJson['data'];
                              print(supportedCasesList);
                          }
                        });
                      }
                      else
                      {
                
                      }
                    }else
                    {
                
                    }
                  }
  Future<String> initDatePicker() async{
    DateTime pickedDate = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(1950), lastDate: DateTime(2100));


    if(pickedDate != null && pickedDate != _date){
      _date = pickedDate;
    }
    return _date.toString();
  }

  @override
  void initState() {
    super.initState();
    SupportedCaseData();
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
              onPressed: (){
                //TODO : show notifications here
              },
            ),
            LogoutButton(
              onPressed: (){
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
            ExpansionTile(
              leading: Icon(Icons.filter_list),
              title: Text('Filter'),
              children: [
                Wrap(
                  spacing: 20,
                  children: [
                    DropdownButton(
                      onChanged: (index) {
                        if(index != 0){
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
                          onPressed: () async{
                            fromDate = await initDatePicker();
                            setState(() {
                            });
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
                          onPressed: ()async{
                            toDate = await initDatePicker();
                            setState(() {
                            });
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
                    RoundedButton(
                      title:'Preview',
                      color: Colors.blueAccent,
                      onPress: () {
                        //TODO Submit the value of the Dropdown button
                      },
                    ),
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [

                  DataColumn(
                      label: (Text('Channel'))
                  ),
                  DataColumn(
                      label: (Text('Phone Used to report'))
                  ),
                  DataColumn(
                      label: (Text('Victim\'s name'))
                  ),
                  DataColumn(
                      label: (Text('Violence Type'))
                  ),
                  DataColumn(
                      label: (Text('Description'))
                  ),
                  DataColumn(
                      label: (Text('Date'))
                  ),

                ],
                  rows:supportedCasesList.map(((element) => DataRow(
                    onSelectChanged: (b){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return CaseScreen(parentScreen: FollowupScreen.id,case_id: element["case_id"],);
                          }
                      ));
                    },
                    cells: <DataCell>[
                      DataCell(Text(element["channel"])),
                      DataCell(Text(element["telephone_used_to_report"] != null ? element["telephone_used_to_report"] : "N/A")),
                      DataCell(Text(element["victim_name"])),
                      DataCell(Text(element["violence_type"])),
                      DataCell(Text(element["violence_description"] != null ? element["violence_description"] : "N/A")),
                      DataCell(Text(element["received_date"])),
                    ],
                  )),).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
