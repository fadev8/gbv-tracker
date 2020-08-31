import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/screens/archive_screen.dart';
import 'package:gbv_tracker/screens/followup_screen.dart';
import 'package:gbv_tracker/screens/forms/add_reaction_screen.dart';
import 'package:gbv_tracker/screens/forms/edit_case_scren.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/screens/receivedcases_screen.dart';
import 'package:gbv_tracker/screens/trash_screen.dart';
import 'package:gbv_tracker/services/case.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';

import 'package:gbv_tracker/core/api.dart';
import 'package:gbv_tracker/core/init.dart';

import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';


class CaseScreen extends StatefulWidget {
  final String parentScreen;
  static String id = 'single_case_screen';
  final int case_id;

  CaseScreen({@required this.parentScreen, @required this.case_id});
  @override
  _CaseScreenState createState() => _CaseScreenState();

}

class _CaseScreenState extends State<CaseScreen> {
  String _title;

  TextEditingController archiveControler, trashControler;


  String victim_name = "";
  String victim_sex = "";
  int victim_age = 0;
  String victim_id_telephone = "";
  String victim_marital_status = "";
  String victim_province = "";
  String victim_district = "";
  String victim_sector = "";
  String victim_cell = "";
  String victim_village = "";

  String violence_type = "";
  String violence_description = "";


  String abuser_name = "";
  String abuser_relation = "";
  String abuser_marital_status = "";
  String abuser_sex = "";
  String abuser_age = "0";
  String abuser_to_police = "NO";

  String abuser_province = "";
  String abuser_district = "";
  String abuser_sector = "";
  String abuser_cell = "";
  String abuser_village = "";


  String intervation_done = "";
  String intervation_done_by = "";
  String intervation_done_details = "";


  ReceivedCaseDetailsData() async
  {
    var user_category = await getRef("user_category");

    if (user_category != null) {
      if (user_category == "SU") {
        responseCasesDetailsDataJson =
        await getCaseDetails(widget.case_id.toString());
        responseCasesSupportDataJson =
        await getCaseSupportDetails(widget.case_id.toString());

        setState(() {

          if (responseCasesDetailsDataJson['status'] == "1") {
            responseCasesDetailsData = responseCasesDetailsDataJson['data'];
            print(responseCasesDetailsData);
            print(responseCasesSupportDataJson);

            if (responseCasesDetailsData['victim_name'] != null)
              victim_name = responseCasesDetailsData['victim_name'];
            if (responseCasesDetailsData['victim_sex'] != null)
              victim_sex = responseCasesDetailsData['victim_sex'];

            if (responseCasesDetailsData['victim_age'] != null)
              victim_age = responseCasesDetailsData['victim_age'];
            if (responseCasesDetailsData['victim_phone_nid'] != null)
              victim_id_telephone =
              responseCasesDetailsData['victim_phone_nid'];

            if (responseCasesDetailsData['victim_marital_status'] != null)
              victim_marital_status =
              responseCasesDetailsData['victim_marital_status'];
            if (responseCasesDetailsData['victim_province'] != null)
              victim_province = responseCasesDetailsData['victim_province'];


            if (responseCasesDetailsData['victim_district'] != null)
              victim_district = responseCasesDetailsData['victim_district'];
            if (responseCasesDetailsData['victim_sector'] != null)
              victim_sector = responseCasesDetailsData['victim_sector'];

            if (responseCasesDetailsData['victim_cell'] != null)
              victim_cell = responseCasesDetailsData['victim_cell'];
            if (responseCasesDetailsData['victim_village'] != null)
              victim_village = responseCasesDetailsData['victim_village'];


            if (responseCasesDetailsData['violence_description'] != null)
              violence_description =
              responseCasesDetailsData['violence_description'];
            if (responseCasesDetailsData['violence_type'] != null)
              violence_type = responseCasesDetailsData['violence_type'];


            if (responseCasesDetailsData['abuser_name'] != null)
              abuser_name = responseCasesDetailsData['abuser_name'];
            if (responseCasesDetailsData['abuser_sex'] != null)
              abuser_sex = responseCasesDetailsData['abuser_sex'];

            if (responseCasesDetailsData['relationship'] != null)
              abuser_relation = responseCasesDetailsData['relationship'];
            if (responseCasesDetailsData['abuser_marital_status'] != null)
              abuser_marital_status =
              responseCasesDetailsData['abuser_marital_status'];

            if (responseCasesDetailsData['abuser_age_range'] != null)
              abuser_age = responseCasesDetailsData['abuser_age_range'];
            if (responseCasesDetailsData['followup_status'] != null &&  responseCasesDetailsData['followup_status'] == "true")   abuser_to_police = "YES";

            if (responseCasesDetailsData['abuser_province'] != null)
              abuser_province = responseCasesDetailsData['abuser_province'];
            if (responseCasesDetailsData['abuser_disctrict'] != null)
              abuser_district = responseCasesDetailsData['abuser_disctrict'];
            if (responseCasesDetailsData['abuser_sector'] != null)
              abuser_sector = responseCasesDetailsData['abuser_sector'];

            if (responseCasesDetailsData['abuser_cell'] != null)
              abuser_cell = responseCasesDetailsData['abuser_cell'];
            if (responseCasesDetailsData['abuser_village'] != null)
              abuser_village = responseCasesDetailsData['abuser_village'];


            if (responseCasesSupportDataJson['status'] == "1") {
              responseCasesSupportData = responseCasesSupportDataJson['data'];
//              print(responseCasesSupportData);

              if (responseCasesSupportData['intervation_done'] != null)
                   intervation_done = responseCasesSupportData['intervation_done'];
              if (responseCasesSupportData['intervation_details'] != null)
                intervation_done_details = responseCasesSupportData['intervation_details'];
              if (responseCasesSupportData['intervation_done_by'] != null)
                     intervation_done_by =    responseCasesSupportData['intervation_done_by'];
            }
          }
        });
      }
      else {

      }
    } else {

    }
  }



        List<IconButton> actionButtons() {
          if (widget.parentScreen != null) {
            if (widget.parentScreen == ReceivedCaseScreen.id) {
              //========= RECEIVED CASE action buttons ============

              return [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.eye,
                    color: Colors.lightBlue,
                  ),
                  onPressed: () {
                    //========== Action for View =========
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.edit, color: Colors.green),
                  onPressed: () {
                    //calling the Add Reaction screen
                    addReaction(widget.case_id.toString());
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.book,
                    color: Colors.lightBlue,
                  ),
                  onPressed: () {
                    //calling the Review/edit screen
                    editCase(widget.case_id.toString());
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.archive),
                  onPressed: () {
                    //archive a case
                    archiveCase(
                        widget.case_id.toString(), context, archiveControler);
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    //delete a case
                    deleteCase(widget.case_id.toString(), context);
                  },
                ),
              ];
            } else if (widget.parentScreen == TrashScreen.id) {
              return [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.trashRestore,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    //restore case action
                    restoreCase(widget.case_id.toString(), context);
                  },
                ),
              ];
            } else if (widget.parentScreen == FollowupScreen.id) {
              return [
                IconButton(
                  icon: Icon(FontAwesomeIcons.edit, color: Colors.green),
                  onPressed: () {
                    //calling the Add Reaction screen
                    addReaction(widget.case_id.toString());
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.archive),
                  onPressed: () {},
                ),
              ];
            } else if (widget.parentScreen == ArchiveScreen.id) {
              //=============== ARCHIVE action buttons ============
              return [
                IconButton(
                  icon: Icon(FontAwesomeIcons.eye, color: Colors.lightBlue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.archive),
                  tooltip: 'Unarchive',
                  onPressed: () {
                    //Unarchive a case
                    unArchiveCase(widget.case_id.toString(), context);
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    deleteCase(widget.case_id.toString(), context);
                  },
                ),
              ];
            }
          }
        }

       @override
        void initState() {
          super.initState();

          if (widget.parentScreen != null) {
            if (widget.parentScreen == ReceivedCaseScreen.id) {
              _title = "Received Case";
            } else if (widget.parentScreen == TrashScreen.id) {
              _title = "Trash Case";
            } else if (widget.parentScreen == FollowupScreen.id) {
              _title = "Case in progress";
            } else if (widget.parentScreen == ArchiveScreen.id) {
              _title = "Archive Case";
            }
          }

          ReceivedCaseDetailsData();
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_title),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                LogoutButton(
                  onPressed: () {
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


                  Card(

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
                          text: '    Names              : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: victim_name,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            //age
                            TextSpan(
                              text: '\n    Sex                    : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),

                            TextSpan(
                              text: victim_sex,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            TextSpan(
                              text: '\n    Age                    : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),


                            TextSpan(
                              text: victim_age.toString(),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            TextSpan(
                              text: '\n    ID/Telephone   : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),


                            TextSpan(
                              text: victim_id_telephone,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: '\n    Marital Status  : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),

                            TextSpan(
                              text: victim_marital_status,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Province            : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: victim_province,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    District               : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: victim_district,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Sector                : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: victim_sector,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Cell                     : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: victim_cell,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            TextSpan(
                              text: '\n    Village                : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: victim_village,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            // Violence Information Section
                            TextSpan(
                              text: '\n\n* Violence Information\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600],
                                fontSize: 14,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Type                : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: violence_type,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Description    : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: violence_description,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            // Perpetrator Information Section
                            TextSpan(
                              text: '\n\n* Perpetrator Information\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600],
                                fontSize: 14,
                              ),
                            ),


                            //age
                            TextSpan(
                              text: '\n    Name                   : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_name,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            TextSpan(
                              text: '\n    Relationship       : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_relation,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            TextSpan(
                              text: '\n    Marital Status    : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_marital_status,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Sex                       : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_sex,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Age interval        : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_sex,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    To RIB/RNP         : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_to_police,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            TextSpan(
                              text: '\n    Province              : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_province,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            TextSpan(
                              text: '\n    District                 : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_district,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Sector                  : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_sector,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            //age
                            TextSpan(
                              text: '\n    Cell                       : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_cell,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),

                            TextSpan(
                              text: '\n    Village                  : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: abuser_village,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n\n* Act!onaid support\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600],
                                fontSize: 14,
                              ),
                            ),

                            TextSpan(
                              text: '\n    Intervention done      : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: intervation_done.toLowerCase(),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Intervention done by : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: intervation_done_by,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),


                            TextSpan(
                              text: '\n    Intervention details   : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: intervation_done_details,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),





                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }


        //=================================================================
        //         ACTION FUNCTIONS
        //=================================================================
        void addReaction(String case_id) {
          //========== Function to edit Reaction to a case ==========
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddReactionScreen(
              case_id: case_id,
            );
          }));
        }

        void editCase(String case_id) {
          //======== Go to Edit case =====================
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditCaseScreen(
              case_id: case_id,
            );
          }));
        }

        archiveCase(String case_id, BuildContext context,
            TextEditingController controller) {
          //========= Archive a case ==============
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Confirm Archive this case ?'),
                content: Container(
                  child: Wrap(
                    children: [
                      Text(
                        'Please Specify the reason',
                      ),
                      Container(
                        child: TextField(
                          onChanged: (value) {
                            //TODO : take the reason value here Archive Case
                          },
                          maxLines: 2,
                          controller: archiveControler,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  RoundedButton(
                    title: 'Cancel ',
                    color: Colors.grey,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButton(
                    title: 'Confirm',
                    onPress: () {
                      //TODO : Archive a chase here
                    },
                    color: Colors.blueAccent,
                  )
                ],
              );
            },
          );
        }

        deleteCase(String case_id, BuildContext ctx) {
          return showDialog(
            context: ctx,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Move to Trash ?'),
                content: Container(
                  child: Wrap(
                    children: [
                      Text(
                        'Please Specify the reason',
                      ),
                      Container(
                        child: TextField(
                          onChanged: (value) {
                            //TODO : take reason value here Trash Case
                          },
                          controller: trashControler,
                          maxLines: 2,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  RoundedButton(
                    title: 'Cancel ',
                    color: Colors.grey,
                    onPress: () {
                      Navigator.pop(ctx);
                    },
                  ),
                  RoundedButton(
                    title: 'Confirm',
                    onPress: () {
                      //TODO : Delete a case here
                    },
                  )
                ],
              );
            },
          );
        }

        unArchiveCase(String case_id, BuildContext context) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Unarchive this case ?'),
                content: Text('Do you really want to Unarchive this case?'),
                actions: [
                  RoundedButton(
                    title: 'Cancel ',
                    color: Colors.grey,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButton(
                    title: 'Confirm',
                    onPress: () {
                      //TODO : Unarchive a case here
                    },
                    color: Colors.blueAccent,
                  )
                ],
              );
            },
          );
        }

        restoreCase(String case_id, BuildContext context) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Restoring a case'),
                content: Text('Do you really want to Restore this case?'),
                actions: [
                  RoundedButton(
                    title: 'Cancel ',
                    color: Colors.grey,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  RoundedButton(
                    title: 'Confirm',
                    onPress: () {
                      //TODO : Restore a case here
                    },
                    color: Colors.blueAccent,
                  )
                ],
              );
            },
          );
        }
      }


