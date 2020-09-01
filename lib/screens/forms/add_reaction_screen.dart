import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';

class AddReactionScreen extends StatefulWidget {
  static String id = 'edit_case_screen';
  final String case_id;
  AddReactionScreen({@required this.case_id});

  @override
  _AddReactionScreenState createState() => _AddReactionScreenState();
}

class _AddReactionScreenState extends State<AddReactionScreen> {
  //variables
  String selectedIntervention, interventionDoneBy, interventionDescription;
  TextEditingController controller;

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
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text('[Select]'),
                        ),
                        DropdownMenuItem(
                          child: Text('Forward to RIB/RNP'),
                          value: 'Forward to RIB/RNP',
                        ),
                        DropdownMenuItem(
                          child: Text('Host in Safe House'),
                          value: 'Host in Safe House',
                        ),
                        DropdownMenuItem(
                          child: Text('Psychological support'),
                          value: 'Psychological support',
                        ),
                        DropdownMenuItem(
                          child: Text('Legal support'),
                          value: 'Legal support',
                        ),
                        DropdownMenuItem(
                          child: Text('Supported to access GBV stop center'),
                          value: 'Supported to access GBV stop center',
                        ),
                        DropdownMenuItem(
                          child: Text('Financial support'),
                          value: 'Financial support',
                        ),
                        DropdownMenuItem(
                          child: Text('Perpetrator arrested'),
                          value: 'Perpetrator arrested',
                        ),
                        DropdownMenuItem(
                          child: Text('Forward to court'),
                          value: 'Forward to court',
                        ),
                        DropdownMenuItem(
                          child: Text('Under ongoing investigation'),
                          value: 'Under ongoing investigation',
                        ),
                        DropdownMenuItem(
                          child: Text('Closed cases'),
                          value: 'Closed cases',
                        ),
                        DropdownMenuItem(
                          child: Text('Others'),
                          value: 'Others',
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
                      setState(() {
                        interventionDoneBy = val;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text('[Select]'),
                      ),
                      DropdownMenuItem(
                        child: Text('Partners'),
                        value: 'Partners',
                      ),
                      DropdownMenuItem(
                        child: Text('AAR'),
                        value: 'AAR',
                      ),
                      DropdownMenuItem(
                        child: Text('Safeguarding'),
                        value: 'Safeguarding',
                      ),
                      DropdownMenuItem(
                        child: Text('RIB/RNP/Total B One Stop Center'),
                        value: 'RIB/RNP/Total B One Stop Center',
                      ),
                      DropdownMenuItem(
                        child: Text('Others'),
                        value: 'Others',
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
                  FlatButton(
                    child: Text('Cancel'),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Save'),
                    onPressed: (){
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
