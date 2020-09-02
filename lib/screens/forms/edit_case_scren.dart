import 'package:flutter/material.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';

class EditCaseScreen extends StatefulWidget {
  static String id = 'edit_case_screen';
  final String case_id;

  EditCaseScreen({@required this.case_id});

  @override
  _EditCaseScreenState createState() => _EditCaseScreenState();
}

class _EditCaseScreenState extends State<EditCaseScreen> {

  String Province;
  String District;
  String  Sectors;
  List data=[];
  List Districtdata=[];
  List Sectorsdata=[];

  Future<String> ProvinceData() async
  {
    var user_category = await getRef("user_category");

                  if (user_category!=null)
                  {

                      ProvinceListJson = await getProvince();
                      setState(() {

                        if(ProvinceListJson['status']=="1")
                        {
                          data=ProvinceListJson['data'];
                          print(data);
                        }

                      });

                  }else
                  {

                  }
  }

  Future<String> DistrictData(String Province) async
  {
      var user_category = await getRef("user_category");
      Districtdata=[];
      if (user_category!=null)
      {

        DistrictListJson = await getDistrict(Province);
        setState(() {

          if(DistrictListJson['status']=="1")
          {
                Districtdata=DistrictListJson['data'];
                print(Districtdata);
          }

        });

      }else
      {

      }
  }

        Future<String> SectorData(String District) async
        {
          var user_category = await getRef("user_category");

          if (user_category!=null)
          {

            SectorListJson= await getSectors(District);
            setState(() {

              if(SectorListJson['status']=="1")
              {
                  Sectorsdata=SectorListJson['data'];
                  print(Sectorsdata);
              }

            });

          }else
          {

          }
        }


  @override
  void initState() {
    super.initState();
    this.ProvinceData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Review / Edit Case'),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white,),
              onPressed: (){
                //TODO : Display Notification
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
                  Text('Perpetrator\'s name '),
                  TextField(
                    onChanged: (val){

                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Perpetrator\'s name',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //Relationship
              Wrap(
                children: [
                  Text('Relationship '),
                  TextField(
                    onChanged: (val){

                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Relationship',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //Marital status
              Wrap(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text('Marital Status (Perpetrator)'),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24),
                    child: DropdownButton(
                      onChanged: (val) {
                        setState(() {});
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text('[Select]'),
                        ),
                        DropdownMenuItem(
                          child: Text('SINGLE'),
                          value: 'SINGLE',
                        ),
                        DropdownMenuItem(
                          child: Text('MARRIED'),
                          value: 'MARRIED',
                        ),
                        DropdownMenuItem(
                          child: Text('DIVORCED'),
                          value: 'DIVORCED',
                        ),
                        DropdownMenuItem(
                          child: Text('OTHER'),
                          value: 'OTHER',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //province
              Wrap(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text('Perpetrator Province'),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: DropdownButton<String>(

                      items: data.map((item) {
                        return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {

                          Province = newVal;
                          DistrictData(Province);
                        });
                      },
                      value: Province,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //district
              Wrap(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text('Perpetrator Distict'),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: DropdownButton(
                      items:  Districtdata.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['name']),
                          value: item['id'].toString(),
                        );
                      }).toList(),

                      onChanged: (newVal) {
                        setState(() {
                          District = newVal;
                          print(District);
                          SectorData(District);
                        });
                      },
                      value: District,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //sector
              Wrap(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text('Perpetrator Sector'),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: DropdownButton(
                      items:  Sectorsdata.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['name']),
                          value: item['id'].toString(),
                        );
                      }).toList(),

                      onChanged: (newVal) {
                        setState(() {

                          Sectors = newVal;
                          print(Sectors);

                        });
                      },
                      value: Sectors,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //cell
              Wrap(
                children: [
                  Text('Perpetrator\'s cell'),
                  TextField(
                    onChanged: (val){

                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Perpetrator\'s cell',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),

              //Village
              Wrap(
                children: [
                  Text('Perpetrator\'s village'),
                  TextField(
                    onChanged: (val){

                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Perpetrator\'s village',
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 16,
              ),

              //victim's marital status
              Wrap(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text('Marital Status (Victim)'),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24),
                    child: DropdownButton(
                      onChanged: (val) {
                        setState(() {});
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text('[Select]'),
                        ),
                        DropdownMenuItem(
                          child: Text('SINGLE'),
                          value: 'SINGLE',
                        ),
                        DropdownMenuItem(
                          child: Text('MARRIED'),
                          value: 'MARRIED',
                        ),
                        DropdownMenuItem(
                          child: Text('DIVORCED'),
                          value: 'DIVORCED',
                        ),
                        DropdownMenuItem(
                          child: Text('OTHER'),
                          value: 'OTHER',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    child: Text('Cancel'),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Save'),
                    onPressed: () {
                      //TODO : Save the reaction
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
