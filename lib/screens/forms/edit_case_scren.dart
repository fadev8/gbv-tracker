import 'package:flutter/material.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';

class EditCaseScreen extends StatefulWidget {
  static String id = 'edit_case_screen';
  final String case_id;

  EditCaseScreen({@required this.case_id});

  @override
  _EditCaseScreenState createState() => _EditCaseScreenState();
}

class _EditCaseScreenState extends State<EditCaseScreen> {
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
                  RoundedInput(
                    onChanged: () {},
                    hint: 'Perpetrator\'s name',
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
                  RoundedInput(
                    onChanged: () {},
                    hint: 'Relationship',
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
                      onChanged: (val) {
                        setState(() {});
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text('[Select]'),
                        ),

                      ],
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
                      onChanged: (val) {
                        setState(() {});
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text('[Select]'),
                        ),

                      ],
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
                  RoundedInput(
                    onChanged: () {},
                    hint: 'Perpetrator\'s cell',
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
                  RoundedInput(
                    onChanged: () {},
                    hint: 'Perpetrator\'s village',
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
                  RoundedButton(
                    title: 'Cancel',
                    color: Colors.grey,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButton(
                    title: ' Save ',
                    onPress: () {
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
