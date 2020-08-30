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

      body: SingleChildScrollView(
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

              child: Card(

                  child: ListTile(

                    title: Text("* Victim Information\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[600],
                        fontSize: 16,

                      ),
                    ),

                    subtitle: RichText(
                      text:
                      TextSpan(
                        text: '    Names                ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' : ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: 'Muhima Ndohole',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          //age
                          TextSpan(
                              text: '\n    Sex                      ',
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                          ),
                          ),
                          TextSpan(
                            text: ' : ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '\n    Age                     ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),

                          TextSpan(
                            text: '  : ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '\n    ID/Telephone     ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),

                          TextSpan(
                            text: ' : ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: '\n    Marital Status    ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' : ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Province              : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    District                 : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Sector                  : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Cell                       : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '\n    Village                  : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          // Violence Information Section
                          TextSpan(
                            text: '\n\n* Violence Information\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[600],
                              fontSize: 16,
                              ),
                          ),


                          TextSpan(
                            text: '\n    Type                : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Description    : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          // Perpetrator Information Section
                          TextSpan(
                            text: '\n\n* Perpetrator Information\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[600],
                              fontSize: 16,
                            ),
                          ),




                          //age
                          TextSpan(
                            text: '\n    Name                   : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '\n    Relationship       : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '\n    Marital Status    : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Sex                       : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Age interval        : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    To RIB/RNP         : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '\n    Province              : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '\n    District                 : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Sector                  : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          //age
                          TextSpan(
                            text: '\n    Cell                       : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: '\n    Village                  : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),




                          TextSpan(
                            text: '\n\n* Act!onaid support\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[600],
                              fontSize: 16,
                            ),
                          ),

                          TextSpan(
                            text: '\n    Intervention done:          : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Specification                   : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Intervention done by      : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),


                          TextSpan(
                            text: '\n    Intervention details:       : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '700',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),




                        ],
                      ),
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),

    );
  }
}
