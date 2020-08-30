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

                             dashboardData();

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



  int today=0,lastSevenDays=0,thisMonth=0,lastNinetyDays=0,total=0,pending=0,progress=0,closed=0;
  int allCase=0,physical=0,psychology=0,sexual=0,property=0,others=0;
  int male=0,female=0,fake=0,real=0,newlyReceived=0,ongoing=0,archived=0;




  dashboardData() async
  {

    var user_category = await getRef("user_category");

    if (user_category!=null)
    {
      if (user_category=="SU")
      {
        //get Overview data
        responseOverviewJson =await getDefaultAdminCaseOverview();
        print(responseOverviewJson);
        responseOverviewData=responseOverviewJson['data'];

        if(responseOverviewData!=null){

          closed =responseOverviewData['pending'];
          progress=responseOverviewData['followup_in_progress'];
          pending= responseOverviewData['pending'];
          lastSevenDays= responseOverviewData['last_seven_days'];
          lastNinetyDays =responseOverviewData['last_nighty_days'];
          thisMonth= responseOverviewData['this_month'];
          today= responseOverviewData['today'] ;
          total= responseOverviewData['total_cases'];

        }

        //get caseFigures Data
        responseFigureDataJson=await getDefaultAdminCaseFigure();
        responseFigureData=responseFigureDataJson['data'];
        print(responseFigureData);

        if(responseFigureData!=null) {
          allCase = responseFigureData['all'];
          physical = responseFigureData['physical'];
          psychology = responseFigureData['psychological'];
          sexual = responseFigureData['sexual'];
          property = responseFigureData['property'];
          others = responseFigureData['other'];
        }

        responseAllCasesDataJson=await getAllCases();
        responseAllCasesData =responseAllCasesDataJson['data'];
        print(responseAllCasesData);

        if(responseAllCasesData!=null) {

          male = responseAllCasesData['male'];
          female = responseAllCasesData['female'];
          real = responseAllCasesData['real'];
          fake = responseAllCasesData['fake'];
          ongoing = responseAllCasesData['ongoing'];
          newlyReceived = responseAllCasesData['received'];
          archived = responseAllCasesData['closed'];
        }




      }
      else
      {

      }
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
