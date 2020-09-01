import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:toast/toast.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';

class AddReactionScreen extends StatefulWidget {
  static String id = 'edit_case_screen';
  final String case_id;
  AddReactionScreen({@required this.case_id});

  @override
  _AddReactionScreenState createState() => _AddReactionScreenState();
}

class _AddReactionScreenState extends State<AddReactionScreen> {
  //variables
  String selectedIntervention="SELECT", interventionDoneBy="SELECT", interventionDescription;
  TextEditingController controller = new TextEditingController();



  SupportCase(String interventionDone,String interventionDoneBy,String interventionDescription) async {

    http.Response response = await http.post(BASE_URL + "claims", body: {
      'action': "Add-Suport",
      'intervation': interventionDone,
      'intervation_by': interventionDoneBy,
      'service_get': interventionDescription,
      'specification':"N/A",
      'case_id':widget.case_id,
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
          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text('Intervention done'),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton(
                      onChanged: (val){
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
                          child: Text('Perpetrator arrested'),
                          value: 'PERPETRATOR ARRESTED',
                        ),
                        DropdownMenuItem(
                          child: Text('Forward to court'),
                          value: 'FORWARDED TO COURT',
                        ),
                        DropdownMenuItem(
                          child: Text('Under ongoing investigation'),
                          value: 'UNDER INVESTIGATION',
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
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Wrap(
                children: [
                  Text('Intervention done by'),
                  DropdownButton(
                    onChanged: (val){
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
                      onChanged: (val){
                       setState(() {
                         interventionDescription = val;
                       });
                      },
                      maxLines: 4,
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'What service did the victim get?'
                      ),
                    )
                  ],
                ),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedButton(
                    title: 'Cancel',
                    color: Colors.grey,
                    onPress: (){
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButton(
                    title: ' Save ',
                    onPress: (){
                      interventionDescription=controller.text;
                      if (interventionDescription != '' && selectedIntervention!='SELECT' && interventionDoneBy!='SELECT') {
                        print(interventionDescription);
                        SupportCase( selectedIntervention, interventionDoneBy, interventionDescription);
//                            Navigator.pushNamed(context, DashboardScreen.id);
////                                  Toast.show(user.Display(statusCode), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      } else {
                        Toast.show("Please fill all the field and proceed",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
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
