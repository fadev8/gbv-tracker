import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/archive_screen.dart';
import 'package:gbv_tracker/screens/dashboard_screen.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:gbv_tracker/screens/report_screen.dart';
import 'package:gbv_tracker/screens/settings_screen.dart';
import 'package:gbv_tracker/screens/trash_screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50,bottom: 30,right: 70),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Drawer(
          child: Container(
            //color: Colors.orange,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(FontAwesomeIcons.home),
                  title: Text('Dashboard',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.pushNamed(context, DashboardScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.layerGroup),
                  title: Text('Received Cases',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.pushNamed(context, ReceivedCaseScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.chevronUp
                  ),
                  title: Text('Followup in progress',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.pushNamed(context, FollowupScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.archive),
                  title: Text('Archive',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.pushNamed(context, ArchiveScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.trash),
                  title: Text('Trash',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.pushNamed(context, TrashScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.chartBar),
                  title: Text('Report',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.pushNamed(context, ReportScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.pushNamed(context,SettingsScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
