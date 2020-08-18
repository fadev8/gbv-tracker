import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/pages/dashboardpages/cases_overview_page.dart';
import 'package:gbv_tracker/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  static String id = 'dashboard-screen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final int _tabLength = 5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: _tabLength,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Cases Dashboard'),
            actions: [
              IconButton(
                color: Colors.orange,
                icon: Icon(
                  FontAwesomeIcons.signOutAlt,
                ),
                onPressed: () {
                  //TODO logout operation here
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                },
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: [
                Text(
                  'Overview',
                  style: kTabsTitleStyle,
                ),
                Text(
                  'Figure',
                  style: kTabsTitleStyle,
                ),
                Text(
                  'All cases',
                  style: kTabsTitleStyle,
                ),
                Text(
                  'Overview',
                  style: kTabsTitleStyle,
                ),
                Text(
                  'Overview',
                  style: kTabsTitleStyle,
                ),
              ],
            ),
          ),
          drawer: NavDrawer(),
          body: TabBarView(
            children: [
              CasesOverviewPage(),
              Container(
                color: Colors.greenAccent,
              ),
              Container(
                color: Colors.redAccent,
              ),
              Container(
                color: Colors.purpleAccent,
              ),
              Container(
                color: Colors.blueAccent,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
