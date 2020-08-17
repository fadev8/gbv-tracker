import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('GBV Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10,left: 35, right: 35, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
              onPress: (){
                //TODO submit data
                print('Login tapped');
              },
              title: 'Login',
            )
          ],
        ),
      ),
    );
  }
}

