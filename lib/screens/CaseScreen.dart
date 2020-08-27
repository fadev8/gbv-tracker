import 'package:flutter/material.dart';
import 'package:gbv_tracker/screens/archive_screen.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:gbv_tracker/screens/trash_screen.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';

class CaseScreen extends StatefulWidget {
  final String parentScreen;

  CaseScreen({@required this.parentScreen});
  @override
  _CaseScreenState createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  String _title;

  @override
  void initState() {
    super.initState();
    if(widget.parentScreen != null){
      if(widget.parentScreen == ReceivedCaseScreen.id){
        _title = "Received Case";
      }
      else if(widget.parentScreen == TrashScreen.id){
        _title = "Trash Case";
      }
      else if(widget.parentScreen == FollowupScreen.id){
        _title = "Case in progress";
      }
      else if(widget.parentScreen == ArchiveScreen.id){
        _title = "Archive Case";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
          ),
          LogoutButton(
             onPressed: (){
               //TODO : logout operation here
               Navigator.pushNamed(context, LoginScreen.id);
             },
          )
        ],
      ),

    );
  }
}
