import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/dashboard_screen.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10, left: 35, right: 35, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                    child: Text(
                  'GBV Tracker',
                  style: kHeadingTextStyle,
                )),
              ),
              Expanded(
                  flex: 1,
                  child: Image(image: AssetImage('images/actiaid.png'),)),
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
                          //TODO submit data
                          Navigator.pushNamed(context, DashboardScreen.id);
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
    );
  }
}
