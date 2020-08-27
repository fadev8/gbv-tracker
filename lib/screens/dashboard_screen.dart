import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/pages/dashboardpages/all_cases_page.dart';
import 'package:gbv_tracker/screens/pages/dashboardpages/cases_overview_page.dart';
import 'package:gbv_tracker/screens/pages/dashboardpages/figure_page.dart';
import 'package:gbv_tracker/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';

class DashboardScreen extends StatefulWidget {
  static String id = 'dashboard-screen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final int _tabLength = 3;

  @override
  void initState() {
    super.initState();
    // TODO: Pick data from the API Here
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: _tabLength,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: (){
                  //TODO : show notifications here
                },
              ),
              LogoutButton(
                onPressed: (){
                  //TODO : Logout operation here
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                },
              ),
            ],
            //App TabBar===================
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

              ],
            ),
          ),

          //== App Drawer ==========================
          drawer: NavDrawer(),

          //===== Tab pages ======================
          body: TabBarView(
            children: [
              CasesOverviewPage(
                //TODO replace here with true data
                closesCases: 12,
                followupProgress: 45,
                pendingCases: 34,
                receivedLast7days: 3,
                receivedLast90days: 54,
                receivedMonth: 6,
                receivedToday: 43,
                totalCases: 76,
              ),
              FigurePage(),//TODO pass in data here
              AllCasesPage(
                closedCases: 23,
                fakeCasesNumber: 3,femaleReportedNumber: 67,
                maleReportedNumber: 34,
                newlyReceived: 65,
                ongoingCases: 12,
                realCasesNumber: 54,
              ),//TODO pass in data here
            ],
          ),
        ),
      ),
    );
  }
}
