import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/archive_screen.dart';
import 'package:gbv_tracker/screens/dashboard_screen.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
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
            color: Color(0xff1f508B),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(FontAwesomeIcons.home,color: kDrawerIconsColor,),
                  title: Text('Dashboard',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.popAndPushNamed(context, DashboardScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.layerGroup,color: kDrawerIconsColor,),
                  title: Text('Received Cases',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.popAndPushNamed(context, ReceivedCaseScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.chevronUp,color: kDrawerIconsColor,
                  ),
                  title: Text('Followup in progress',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.popAndPushNamed(context, FollowupScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.archive, color: kDrawerIconsColor,),
                  title: Text('Archive',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.popAndPushNamed(context, ArchiveScreen.id);
                  },
                ),
                Divider(
                  color: Colors.white10
                  ,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.trash, color: kDrawerIconsColor,),
                  title: Text('Trash',style: kDrawerTitleStyle,),
                  onTap: (){
                    Navigator.popAndPushNamed(context, TrashScreen.id);
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
