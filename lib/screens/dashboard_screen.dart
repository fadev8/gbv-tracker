import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/pages/dashboardpages/all_cases_page.dart';
import 'package:gbv_tracker/screens/pages/dashboardpages/cases_overview_page.dart';
import 'package:gbv_tracker/screens/pages/dashboardpages/figure_page.dart';
import 'package:gbv_tracker/widgets/drawer.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';


import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';

class DashboardScreen extends StatefulWidget {
   static String id = 'dashboard-screen';
@override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final int _tabLength = 3;

      int today=0,lastSevenDays=0,thisMonth=0,lastNinetyDays=0,total=0,pending=0,progress=0,closed=0;
      int allCase=0,physical=0,psychology=0,sexual=0,property=0,others=0;
      int male=0,female=0,fake=0,real=0,newlyReceived=0,ongoing=0,archived=0;


  dashboardData() async
  {
    var user_category = await getRef("user_category");



    print("ccc"+user_category);
    if (user_category!=null)
    {
      if (user_category=="SU")
      {
                      //get Overview data
                      responseOverviewJson =await getDefaultAdminCaseOverview();
                      print(responseOverviewJson);
                      responseOverviewData=responseOverviewJson['data'];

                      if(responseOverviewData!=null){

                           setState(() {
                             closed =responseOverviewData['closed_cases'];
                             progress=responseOverviewData['followup_in_progress'];
                             pending= responseOverviewData['pending'];
                             lastSevenDays= responseOverviewData['last_seven_days'];
                             lastNinetyDays =responseOverviewData['last_nighty_days'];
                             thisMonth= responseOverviewData['this_month'];
                             today= responseOverviewData['today'] ;
                             total= responseOverviewData['total_cases'];
                           });

                      }

                      //get caseFigures Data
                      responseFigureDataJson=await getDefaultAdminCaseFigure();
                      responseFigureData=responseFigureDataJson['data'];
                      print(responseFigureData);

                      if(responseFigureData!=null) {
                       setState(() {
                         allCase = responseFigureData['all'];
                         physical = responseFigureData['physical'];
                         psychology = responseFigureData['psychological'];
                         sexual = responseFigureData['sexual'];
                         property = responseFigureData['property'];
                         others = responseFigureData['others'];
                       });
                      }

                      responseAllCasesDataJson=await getAllCases();
                      responseAllCasesData =responseAllCasesDataJson['data'];
                      print(responseAllCasesData);

                      if(responseAllCasesData!=null) {

                       setState(() {
                         male = responseAllCasesData['male'];
                         female = responseAllCasesData['female'];
                         real = responseAllCasesData['real'];
                         fake = responseAllCasesData['fake'];
                         ongoing = responseAllCasesData['ongoing'];
                         newlyReceived = responseAllCasesData['received'];
                         archived = responseAllCasesData['closed'];
                       });
                      }




      }
      else
        {

        }
    }else
      {
        today=9000;
      }
  }

  @override
  void initState() {


    super.initState();

    if (mounted) {
      dashboardData();
    }


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
                  onPressed: () {
                    //TODO : show notifications here
                  },
                ),
                LogoutButton(
                  onPressed: () {
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
                  closesCases: closed,
                  followupProgress: progress,
                  pendingCases: pending,
                  receivedLast7days: lastSevenDays,
                  receivedLast90days: lastNinetyDays,
                  receivedMonth: thisMonth,
                  receivedToday: today,
                  totalCases: total,
                ),
                FigurePage(
                    otherCases: others,
                    propertyCases: property,
                    psychologicalCases: psychology,
                    physicalCases: physical,
                    allCases: allCase,
                    sexualCases: sexual

                ), //TODO pass in data here
                AllCasesPage(
                  closedCases: archived.toDouble(),
                  fakeCasesNumber: fake.toDouble(),
                  femaleReportedNumber: female.toDouble(),
                  maleReportedNumber: male.toDouble(),
                  newlyReceived: newlyReceived.toDouble(),
                  ongoingCases: ongoing.toDouble(),
                  realCasesNumber: real.toDouble(),
                ), //TODO pass in data here
              ],
            ),
          ),
        ),
      );
    }



  }

