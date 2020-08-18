import 'package:flutter/material.dart';
import 'package:gbv_tracker/screens/archive_screen.dart';
import 'package:gbv_tracker/screens/dashboard_screen.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:gbv_tracker/screens/report_screen.dart';
import 'package:gbv_tracker/screens/settings_screen.dart';
import 'package:gbv_tracker/screens/trash_screen.dart';

void main() {
  runApp(GBVApp());
}

class GBVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
        DashboardScreen.id : (context) => DashboardScreen(),
        ReceivedCaseScreen.id : (context) => ReceivedCaseScreen(),
        FollowupScreen.id : (context) => FollowupScreen(),
        ArchiveScreen.id : (context) => ArchiveScreen(),
        TrashScreen.id : (context) => TrashScreen(),
        SettingsScreen.id : (context) =>SettingsScreen(),
        ReportScreen.id : (context) => ReportScreen(),
      },
    );
  }
}
