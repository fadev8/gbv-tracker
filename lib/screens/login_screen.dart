import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';
import 'package:gbv_tracker/screens/app_info_screen.dart';
import 'package:gbv_tracker/screens/forgetten_password_screen.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:gbv_tracker/screens/dashboard_screen.dart';
import 'dart:core';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

bool showLoader = false;

class LoginScreen extends StatefulWidget {
  static String id = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//Text field Controllers
  final TextEditingController usernameField = new TextEditingController();
  final TextEditingController passwordField = new TextEditingController();

// Login post request to the server


  homeRedirection() async
    {
        var user_category = await getRef("user_category");

            if (user_category!=null)
            {
              Navigator.pushNamed(context, DashboardScreen.id);
            }
    }



  Login(String username, String password) async {
    setState(() {
      //show the Loader
      showLoader = true;
    });
    http.Response response = await http.post(BASE_URL + "users", body: {
      'action': "user-Login",
      'username': username,
      'password': password,
    });

    //close the spinner
    setState(() {
      showLoader = false;
    });

    //check http code
    if (response.statusCode == 200) {
      responseJson = convert.jsonDecode(response.body);
      print(responseJson);

      if (responseJson['status'] == "1") {
        SweetAlert.show(context,
            title: responseJson['message'], style: SweetAlertStyle.success);
        responseData = responseJson['data'];
        print(responseData);

        // save login data
        setRef("user_names", responseData['UserName']);
        setRef("user_category", responseData['UserCat']);

        setRef("user_id", responseData['UserId'].toString());
        setRef("user_names", responseData['UserName']);
        setRef("user_category", responseData['User_Cat']);
        setRef("user_district", responseData['district'].toString());
        setRef("user_sector", responseData['sector'].toString());

        Navigator.pushNamed(context, DashboardScreen.id);
      } else if (responseJson['status'] == "0") {
        SweetAlert.show(context,
            title: responseJson['message'], style: SweetAlertStyle.error);
      } else
        Toast.show("Invalid Response Status", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (response.statusCode == 500) {
      SweetAlert.show(context,
          title: "Server Error", style: SweetAlertStyle.error);
    } else {
      SweetAlert.show(context,
          title: "Network Error", style: SweetAlertStyle.error);
    }


  }






// login  Post request

  String username, password;


  @override
  void initState() {
    super.initState();

    homeRedirection();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showLoader,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Color(0xdf6ca0ba),
                  child: Hero(
                    tag: 'banner',
                    child: Image.asset('images/banner.jpeg'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          Text(
                            'App Info',
                            style: TextStyle(fontSize: 12),
                          ),
                          Icon(
                            Icons.info_outline,
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, AppInfoScreen.id);
                        print('Tapped info');
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage('images/actiaid.png'),
                  )),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 10, left: 35, right: 35, bottom: 10),
                    child: Column(
                      children: [
                        RoundedInput(
                          hint: 'Username',
                          controller: usernameField,
                        ),
                        RoundedInput(
                          hint: 'Password',
                          controller: passwordField,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                          minWidth: 300,
                          onPress: () {
//                          //TODO submit data
//                          Navigator.pushNamed(context, DashboardScreen.id);


                            // field field validation
                            username = usernameField.text;
                            password = passwordField.text;
//                              showLoadingDialog();

                            if (username != '' && password != '') {
                              //login operation here
                              Login(username,password);


                            } else {
                              Toast.show("Please fill all the field and proceed",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                          },
                          title: 'Login',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock_outline),
                              Text(
                                'Forgot password ?',
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                          onTap: () {

//                          Navigator.pushNamed(
//                              context, ForgottenPasswordScreen.id);
                          },
                        ),
                      ],
                    ),
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
