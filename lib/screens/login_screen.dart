import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';
import 'package:toast/toast.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:gbv_tracker/screens/dashboard_screen.dart';
import 'dart:core';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;



class LoginScreen extends StatefulWidget {
  static String id = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


//Text field Controllers
final TextEditingController usernameField=new  TextEditingController();
final TextEditingController passwordField=new  TextEditingController();

// Login post reques to the server
            Login(String username,String password ) async {

              http.Response response  = await http.post(BASE_URL+"users",


                  body: {
                    'action': "user-Login",
                    'username': username,
                    'password': password,


                  });

              //check http code
              if(response.statusCode==200) {

                      responseJson = convert.jsonDecode(response.body);
                      print(responseJson);

                      if(responseJson['status']=="1")
                          {

                             SweetAlert.show(context,
                                title: responseJson['message'],
                                style: SweetAlertStyle.success);
                                responseData=responseJson['data'];
                                print(responseData);

                                // save login data
                                setRef("user_names",responseData['UserName']);
                                setRef("user_category",responseData['UserCat']);

                                setRef("user_id",responseData['UserId'].toString());
                                setRef("user_names",responseData['UserName']);
                                setRef("user_category",responseData['User_Cat']);
                                setRef("user_district",responseData['district'].toString());
                                setRef("user_sector",responseData['sector'].toString());



                              Navigator.pushNamed(context, DashboardScreen.id);


                          }
                else if (responseJson['status']=="0")
                  {
                      SweetAlert.show(context,
                        title: responseJson['message'],
                        style: SweetAlertStyle.error);
                  }
                else   Toast.show("Invalid Response Status", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);


              }
              else if (response.statusCode==500)
              {
                 SweetAlert.show(context,
                    title: "Server Error",
                    style: SweetAlertStyle.error);

              }
              else
              {
                SweetAlert.show(context,
                    title: "Network Error",
                    style: SweetAlertStyle.error);
              }


            }



// login  Post request


String username,password;
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
                        controller : usernameField,
                      ),
                      RoundedInput(
                        hint: 'Password',
                        controller : passwordField,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        onPress: () {
//                          //TODO submit data
//                          Navigator.pushNamed(context, DashboardScreen.id);
//                          print('Login tapped');
                          // field field validation
                              username=usernameField.text;
                              password= passwordField.text;
//                              showLoadingDialog();

                              if(username !='' && password!='')
                                {


                                 Login(username,password);
////                                  Toast.show(user.Display(statusCode), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

                                }
                              else
                                {
                                  Toast.show("Please fill all the field and proceed", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                }


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
