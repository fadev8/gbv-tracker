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
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';

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
  TextEditingController archiveControler, trashControler;

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
              addReaction(widget.actualCase);
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.book,
              color: Colors.lightBlue,
            ),
            onPressed: () {
              //calling the Review/edit screen
              editCase(widget.actualCase);
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.archive),
            onPressed: () {
              //archive a case
              archiveCase(widget.actualCase, context, archiveControler);
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.trash,
              color: Colors.red,
            ),
            onPressed: () {
              //delete a case
              deleteCase(widget.actualCase, context);
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
              restoreCase(widget.actualCase, context);
            },
          ),
        ];
      } else if (widget.parentScreen == FollowupScreen.id) {
        return [
          IconButton(
            icon: Icon(FontAwesomeIcons.edit, color: Colors.green),
            onPressed: () {
              //calling the Add Reaction screen
              addReaction(widget.actualCase);
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
              unArchiveCase(widget.actualCase, context);
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.trash,
              color: Colors.red,
            ),
            onPressed: () {
              deleteCase(widget.actualCase, context);
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
                      label: Text(
                    'Names',
                    style: kTableHeaderStyle,
                  )),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Age',
                        style: kTableHeaderStyle,
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('${widget.actualCase.names}')),
                    DataCell(Text('${widget.actualCase.age}')),
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  //=================================================================
  //         ACTION FUNCTIONS
  //=================================================================
  void addReaction(Case cas) {
    //========== Function to edit Reaction to a case ==========
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddReactionScreen(
        cas: cas,
      );
    }));
  }

  void editCase(Case cas) {
    //======== Go to Edit case =====================
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditCaseScreen(
        cas: cas,
      );
    }));
  }

  archiveCase(
      Case cas, BuildContext context, TextEditingController controller) {
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

  deleteCase(Case cas, BuildContext ctx) {
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

  unArchiveCase(Case cas, BuildContext context) {
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

  restoreCase(Case cas, BuildContext context) {
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
