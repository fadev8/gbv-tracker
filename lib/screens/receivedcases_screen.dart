import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/widgets/drawer.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';

import 'login_screen.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';

class ReceivedCaseScreen extends StatefulWidget {
  static String id = 'received-cases-screen';
  @override
  _ReceivedCaseScreenState createState() => _ReceivedCaseScreenState();
}

class _ReceivedCaseScreenState extends State<ReceivedCaseScreen> {

  String fromDate, toDate;
  List<DataRow> dataRows = List();
  DateTime _date = DateTime.now();
  bool isRowSelected = false;

  ReceivedCaseData() async
  {
    var user_category = await getRef("user_category");

    if (user_category!=null)
    {
      if (user_category=="SU")
      {
        receivedCasesListJson = await getReceivedCaseList();
        setState(() {

          if(receivedCasesListJson['status']=="1")
          {
            receivedCasesList=receivedCasesListJson['data'];
            print(receivedCasesList);
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

  void populateDataRows(){
    for(int i = 0; i <15; i++){
      DataRow row = DataRow(
        onSelectChanged: (x){
          if(x){
            print('Selected index');
          }

        },
        cells: [
          DataCell(Text('099013$i\'43')),
          DataCell(Text('099013$i\'43')),
          DataCell(Text('099013$i\'43')),
          DataCell(Text('099013$i\'43')),
          DataCell(IconButton(
            icon: Icon(Icons.calendar_view_day),
            onPressed: (){
              setState(() {
                print('action');
              });
            },
          ))
        ]
      );

      dataRows.add(row);
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
    populateDataRows();
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
                  DataColumn(
                      label: (Text('Channel'))
                  ),
                  DataColumn(
                    label: (Text('GBV Type'))
                  ),
                  DataColumn(
                      label: (Text('Victim\'s name'))
                  ),
                  DataColumn(
                      label: (Text('Victim\'s sex'))
                  ),
                  DataColumn(
                      label: (Text('Date'))
                  ),
                  DataColumn(
                      label: (Text('Action'))
                  ),
                ],
                rows:receivedCasesList.map(((element) => DataRow(
                  onSelectChanged: (x){
                    if(x){
                      print('Selected index');
                    }

                  },
                  cells: <DataCell>[
                    DataCell(Text(element["channel"])),
                    DataCell(Text(element["violence_type"])),
                    DataCell(Text(element["names"])),
                    DataCell(Text(element["victim_sex"])),
                    DataCell(Text(element["received_date"])),
                    DataCell(IconButton(
                      icon: Icon(Icons.calendar_view_day),
                      onPressed: (){
                        setState(() {
                          print('action');
                        });
                      },
                    ))
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
