import 'package:flutter/material.dart';
import 'package:gbv_tracker/screens/case_screen.dart';
import 'package:gbv_tracker/screens/app_info_screen.dart';
import 'package:gbv_tracker/screens/archive_screen.dart';
import 'package:gbv_tracker/screens/dashboard_screen.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/forgetten_password_screen.dart';
import 'package:gbv_tracker/screens/forms/add_reaction_screen.dart';
import 'package:gbv_tracker/screens/forms/edit_case_scren.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/notification_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:gbv_tracker/screens/report_case_screen.dart';
import 'package:gbv_tracker/screens/trash_screen.dart';
import 'package:gbv_tracker/screens/welcome_screen.dart';

void main() {
  runApp(GBVApp());
}

class GBVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xff4169e1),
        accentColor: Colors.blueAccent
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        ReportCaseScreen.id : (context) => ReportCaseScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        DashboardScreen.id : (context) => DashboardScreen(),
        ReceivedCaseScreen.id : (context) => ReceivedCaseScreen(),
        FollowupScreen.id : (context) => FollowupScreen(),
        ArchiveScreen.id : (context) => ArchiveScreen(),
        TrashScreen.id : (context) => TrashScreen(),
        ForgottenPasswordScreen.id : (context) => ForgottenPasswordScreen(),
        AppInfoScreen.id : (context) => AppInfoScreen(),
        NotificationScreen.id : (context)=> NotificationScreen(),
      },
    );
  }
}
