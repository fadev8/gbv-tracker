import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/archive_screen.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:gbv_tracker/screens/trash_screen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';

class CaseScreen extends StatefulWidget {
  final String parentScreen;
  static String id = 'single_case_screen';
  Case actualCase;

  CaseScreen({@required this.parentScreen, @required this.actualCase});
  @override
  _CaseScreenState createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  String _title;

  List<IconButton> actionButtons(){
    if(widget.parentScreen != null){
      if(widget.parentScreen == ReceivedCaseScreen.id){
        return [
          IconButton(
            icon: Icon(FontAwesomeIcons.plus,color: Colors.greenAccent,),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.edit,color: Colors.lightBlue),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.archive),
            onPressed: (){},
          ),IconButton(
            icon: Icon(FontAwesomeIcons.trash,color: Colors.red,),
            onPressed: (){},
          ),
        ];
      }
      else if(widget.parentScreen == TrashScreen.id){
        return [
          IconButton(
            icon: Icon(FontAwesomeIcons.trashRestore,color: Colors.greenAccent,),
            onPressed: (){},
          ),
        ];
      }
      else if(widget.parentScreen == FollowupScreen.id){
        return [
          IconButton(
            icon: Icon(FontAwesomeIcons.edit,color: Colors.lightBlue),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.archive),
            onPressed: (){},
          ),
        ];
      }
      else if(widget.parentScreen == ArchiveScreen.id){
        return [
          IconButton(
            icon: Icon(FontAwesomeIcons.edit,color: Colors.lightBlue),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.archive),
            tooltip: 'Unarchive',
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.trash,color: Colors.red,),
            onPressed: (){},
          ),
        ];
      }
    }
  }

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
            icon: Icon(Icons.notifications,color: Colors.white,),
          ),
          LogoutButton(
             onPressed: (){
               //TODO : logout operation here
               Navigator.pushNamed(context, LoginScreen.id);
             },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: actionButtons(),
            ),
            Divider(
              height: 1,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(

                columns: [
                  DataColumn(
                      label: Text('Names', style: kTableHeaderStyle,)
                  ),
                  DataColumn(label: Expanded(child: Text('Age', style: kTableHeaderStyle,),),)
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Text('${widget.actualCase.names}')
                      ),
                      DataCell(
                          Text('${widget.actualCase.age}')
                      ),
                    ]
                  )

                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
