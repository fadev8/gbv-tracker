import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/dashboard_screen.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 35, right: 35, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Center(
                      child: Image(
                        image: AssetImage('images/actiaid.png'),
                      ),),
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RoundedInput(
                          hint: 'Username',
                        ),
                        RoundedInput(
                          hint: 'Password',
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                          onPress: () {
                            setState(() {
                              showSpinner = true;
                            });
                            //TODO submit data
                            Navigator.pushNamed(context, DashboardScreen.id);
                            setState(() {
                              showSpinner = false;
                            });
                            print('Login tapped');
                          },
                          title: 'Login',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_outline),
                            Text(
                              'Forgot password ?',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
