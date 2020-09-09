import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/notification_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';
import 'package:toast/toast.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

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
  String Sectors;
  bool loadingData = false;

  String perpretorMaritalStatus = "SELECT";
  String victimMaritalStatus = "SELECT";

  //Text field Controllers
  final TextEditingController perpretorNameField = new TextEditingController();
  final TextEditingController perpretorReletationField =
      new TextEditingController();
  final TextEditingController perpretorCellField = new TextEditingController();
  final TextEditingController perpretorVillageField =
      new TextEditingController();

  String perpretorName = "";
  String perpretorReletation = "";
  String perpretorCell = "";
  String perpretorVillage = "";

  List data = [];
  List Districtdata = [];
  List Sectorsdata = [];

  Future<String> ProvinceData() async {
    setState(() {
      loadingData = true;
    });
    var user_category = await getRef("user_category");

    if (user_category != null) {
      ProvinceListJson = await getProvince();
      setState(() {
        if (ProvinceListJson['status'] == "1") {
          data = ProvinceListJson['data'];
          print(data);
        }
      });
    } else {}
    setState(() {
      loadingData = false;
    });
  }

  Future<String> DistrictData(String Province) async {

    var user_category = await getRef("user_category");
    Districtdata = [];
    if (user_category != null) {
      DistrictListJson = await getDistrict(Province);
      setState(() {
        if (DistrictListJson['status'] == "1") {
          Districtdata = DistrictListJson['data'];
          print(Districtdata);
        }
      });
    } else {}

  }

  Future<String> SectorData(String District) async {

    var user_category = await getRef("user_category");

    if (user_category != null) {
      SectorListJson = await getSectors(District);
      setState(() {
        if (SectorListJson['status'] == "1") {
          Sectorsdata = SectorListJson['data'];
          print(Sectorsdata);
        }
      });
    } else {}

  }

  EditCase(
      String perpretorName,
      String perpretorReletation,
      String perpretorMaritalStatus,
      String Province,
      String District,
      String Sectors,
      String perpretorCell,
      String perpretorVillage,
      String victimMaritalStatus) async {
    setState(() {
      loadingData = true;
    });
    http.Response response = await http.post(BASE_URL + "claims", body: {
      'action': "PreviewCase",
      'perp_name': perpretorName,
      'relationship': perpretorReletation,
      'perp_marital': perpretorMaritalStatus,
      'victim_marital': victimMaritalStatus,
      'abuser_province': Province,
      'abuser_district': District,
      'abuser_sector': Sectors,
      'abuser_cell': perpretorCell,
      'abuser_village': perpretorVillage,
      'record': widget.case_id,
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

        Navigator.pushNamed(context, ReceivedCaseScreen.id);
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

    setState(() {
      loadingData = false;
    });
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
        body: loadingData
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Text('Perpetrator\'s name '),
                        TextField(
                          onChanged: (val) {},
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Perpetrator\'s name',
                          ),
                          controller: perpretorNameField,
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
                          onChanged: (val) {},
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Relationship',
                          ),
                          controller: perpretorReletationField,
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
                          width: double.infinity,
                          child: DropdownButton(
                            isExpanded: true,
                            onChanged: (val) {
                              setState(() {
                                perpretorMaritalStatus = val;
                                print(perpretorMaritalStatus);
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text(perpretorMaritalStatus),
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
                          child: DropdownButton<String>(
                            isExpanded: true,
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
                          child: DropdownButton(
                            isExpanded: true,
                            items: Districtdata.map((item) {
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
                          child: DropdownButton(
                            isExpanded: true,
                            items: Sectorsdata.map((item) {
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
                          onChanged: (val) {},
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Perpetrator\'s cell',
                          ),
                          controller: perpretorCellField,
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
                          onChanged: (val) {},
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Perpetrator\'s village',
                          ),
                          controller: perpretorVillageField,
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
                          width: double.infinity,
                          child: DropdownButton(
                            isExpanded: true,
                            onChanged: (val) {
                              setState(() {
                                victimMaritalStatus = val;

                                print(victimMaritalStatus);
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text(victimMaritalStatus),
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
                          child: Text('Save',style: TextStyle(color: Colors.white),),
                          color: Colors.blueAccent,
                          onPressed: () {
                            perpretorName = perpretorNameField.text;
                            perpretorReletation = perpretorReletationField.text;
                            perpretorCell = perpretorCellField.text;
                            perpretorVillage = perpretorVillageField.text;
                            if (perpretorName != "" &&
                                perpretorReletation != "" &&
                                perpretorCell != "" &&
                                perpretorVillage != "" &&
                                Province != "" &&
                                District != "" &&
                                Sectors != "" &&
                                perpretorMaritalStatus != "SELECT" &&
                                victimMaritalStatus != "") {
                              EditCase(
                                  perpretorName,
                                  perpretorReletation,
                                  perpretorMaritalStatus,
                                  Province,
                                  District,
                                  Sectors,
                                  perpretorCell,
                                  perpretorVillage,
                                  victimMaritalStatus);
                            } else {
                              Toast.show(
                                  "Please fill all the field and proceed",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
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
